import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/secure_storage.dart';

const String localNotificationChannel =
    'high_importance_channel';

const String localNotificationChannelTitle =
    'High Importance Notifications';

const String localNotificationChannelDescription =
    'This channel is used for important notifications.';

const String notificationTopic =
    'pipeline_business';

typedef NotificationTapHandler =
FutureOr<void> Function(
    Map<String, dynamic> data,
    );

class FCMService {
  FCMService._internal();

  static final FCMService _singleton =
  FCMService._internal();

  factory FCMService() {
    return _singleton;
  }

  /// ============================================================
  /// Firebase Messaging
  /// ============================================================

  FirebaseMessaging? _messaging;

  /// ============================================================
  /// Local Notification
  /// ============================================================

  final FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel channel =
  const AndroidNotificationChannel(
    localNotificationChannel,
    localNotificationChannelTitle,
    description:
    localNotificationChannelDescription,
    importance: Importance.max,
  );

  /// ============================================================
  /// State
  /// ============================================================

  bool _localNotificationInitialized =
  false;

  bool _fcmInitialized =
  false;

  bool _isInitializing =
  false;

  ProviderContainer? _container;

  NotificationTapHandler?
  _notificationTapHandler;

  /// ============================================================
  /// Subscriptions
  /// ============================================================

  StreamSubscription<RemoteMessage>?
  _onMessageSubscription;

  StreamSubscription<RemoteMessage>?
  _onMessageOpenedAppSubscription;

  StreamSubscription<String>?
  _onTokenRefreshSubscription;

  /// ============================================================
  /// INITIALIZE
  /// ============================================================

  Future<void> initialize({
    required ProviderContainer container,
    NotificationTapHandler?
    onNotificationTap,
  }) async {
    if (_isInitializing) {
      return;
    }

    if (_fcmInitialized) {
      return;
    }

    _isInitializing = true;

    _container = container;

    _notificationTapHandler =
        onNotificationTap;

    try {
      /// --------------------------------------------------------
      /// Local notifications should work even when
      /// FCM/Google Play Services is unavailable.
      /// --------------------------------------------------------

      await _initializeLocalNotifications();

      await _requestLocalNotificationPermission();

      /// --------------------------------------------------------
      /// Firebase is optional.
      /// --------------------------------------------------------

      final firebaseAvailable =
      await _ensureFirebaseAvailable();

      if (!firebaseAvailable) {
        debugPrint(
          'FCM unavailable. '
              'Application will continue without FCM.',
        );

        return;
      }

      _messaging =
          FirebaseMessaging.instance;

      await _initializeFirebaseMessaging();

      _fcmInitialized = true;

      debugPrint(
        'FCM service initialized successfully',
      );
    } catch (error, stackTrace) {
      /// Never crash application because of notification service.
      debugPrint(
        'FCM initialization failed >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    } finally {
      _isInitializing = false;
    }
  }

  /// ============================================================
  /// FIREBASE AVAILABLE
  /// ============================================================

  Future<bool>
  _ensureFirebaseAvailable() async {
    try {
      if (Firebase.apps.isEmpty) {
        debugPrint(
          'Firebase Core is not initialized.',
        );

        return false;
      }

      return true;
    } catch (error, stackTrace) {
      debugPrint(
        'Firebase availability check failed >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      return false;
    }
  }

  /// ============================================================
  /// INITIALIZE FIREBASE MESSAGING
  /// ============================================================

  Future<void>
  _initializeFirebaseMessaging() async {
    final messaging = _messaging;

    if (messaging == null) {
      return;
    }

    await _requestFCMPermission();

    await _configureForegroundNotification();

    /// Setup listeners before token handling.
    _listenForegroundMessages();

    _listenMessageOpenedApp();

    _listenTokenRefresh();

    await _saveInitialToken();

    await _subscribeTopicSafely();

    await _handleInitialMessage();
  }

  /// ============================================================
  /// FCM PERMISSION
  /// ============================================================

  Future<void>
  _requestFCMPermission() async {
    final messaging = _messaging;

    if (messaging == null) {
      return;
    }

    try {
      final settings =
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint(
        'FCM permission status >>> '
            '${settings.authorizationStatus}',
      );
    } catch (error, stackTrace) {
      debugPrint(
        'FCM permission request failed >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// LOCAL NOTIFICATION INITIALIZATION
  /// ============================================================

  Future<void>
  _initializeLocalNotifications() async {
    if (_localNotificationInitialized) {
      return;
    }

    try {
      const androidSettings =
      AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      const iosSettings =
      DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const initializationSettings =
      InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await flutterLocalNotificationsPlugin
          .initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
        _onLocalNotificationTap,
      );

      await _registerAndroidNotificationChannel();

      _localNotificationInitialized =
      true;

      debugPrint(
        'Local notification initialized',
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Local notification initialization failed >>> '
            '$error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// ANDROID LOCAL NOTIFICATION PERMISSION
  /// ============================================================

  Future<void>
  _requestLocalNotificationPermission() async {
    if (defaultTargetPlatform !=
        TargetPlatform.android) {
      return;
    }

    try {
      final androidPlugin =
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      await androidPlugin
          ?.requestNotificationsPermission();
    } catch (error, stackTrace) {
      /// Some Android versions/devices do not need/support this.
      ///
      /// Do not fail app startup.
      debugPrint(
        'Android notification permission error >>> '
            '$error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// ANDROID CHANNEL
  /// ============================================================

  Future<void>
  _registerAndroidNotificationChannel() async {
    if (defaultTargetPlatform !=
        TargetPlatform.android) {
      return;
    }

    try {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
        channel,
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Notification channel creation failed >>> '
            '$error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// IOS FOREGROUND NOTIFICATION
  /// ============================================================

  Future<void>
  _configureForegroundNotification() async {
    if (defaultTargetPlatform !=
        TargetPlatform.iOS) {
      return;
    }

    final messaging = _messaging;

    if (messaging == null) {
      return;
    }

    try {
      await messaging
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (error, stackTrace) {
      debugPrint(
        'iOS foreground notification configuration '
            'failed >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// INITIAL FCM TOKEN
  /// ============================================================

  Future<void>
  _saveInitialToken() async {
    final messaging = _messaging;

    if (messaging == null) {
      return;
    }

    try {
      /// For iOS, wait briefly for APNs.
      if (defaultTargetPlatform ==
          TargetPlatform.iOS) {
        final apnsReady =
        await _waitForAPNSToken();

        if (!apnsReady) {
          debugPrint(
            'APNS token is not ready. '
                'FCM token will be obtained later.',
          );

          return;
        }
      }

      final fcmToken =
      await messaging.getToken();

      if (fcmToken == null ||
          fcmToken.trim().isEmpty) {
        debugPrint(
          'FCM token unavailable on this device',
        );

        return;
      }

      debugPrint(
        'FCM Token >>> $fcmToken',
      );

      await _saveToken(
        fcmToken,
      );
    } catch (error, stackTrace) {
      /// Typical Chinese Android phone may reach here:
      ///
      /// SERVICE_NOT_AVAILABLE
      /// MISSING_INSTANCEID_SERVICE
      /// Google Play Services unavailable
      ///
      /// App continues normally.
      debugPrint(
        'Unable to obtain FCM token >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// SAVE TOKEN
  /// ============================================================

  Future<void> _saveToken(
      String token,
      ) async {
    if (token.trim().isEmpty) {
      return;
    }

    final container = _container;

    if (container == null) {
      return;
    }

    try {
      await container
          .read(
        secureStorageProvider,
      )
          .saveFCMToken(
        token,
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Save FCM token failed >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// TOKEN REFRESH
  /// ============================================================

  void _listenTokenRefresh() {
    final messaging = _messaging;

    if (messaging == null) {
      return;
    }

    _onTokenRefreshSubscription?.cancel();

    _onTokenRefreshSubscription =
        messaging.onTokenRefresh.listen(
              (fcmToken) async {
            debugPrint(
              'Refreshed FCM Token >>> $fcmToken',
            );

            await _saveToken(
              fcmToken,
            );

            /// TODO:
            /// If user is logged in, send refreshed token
            /// to your backend here.
          },
          onError: (
              Object error,
              StackTrace stackTrace,
              ) {
            debugPrint(
              'FCM token refresh error >>> $error',
            );

            debugPrintStack(
              stackTrace: stackTrace,
            );
          },
        );
  }

  /// ============================================================
  /// APNS TOKEN
  /// ============================================================

  Future<bool>
  _waitForAPNSToken() async {
    final messaging = _messaging;

    if (messaging == null) {
      return false;
    }

    try {
      for (var attempt = 0;
      attempt < 10;
      attempt++) {
        final token =
        await messaging.getAPNSToken();

        if (token != null &&
            token.isNotEmpty) {
          debugPrint(
            'APNS Token >>> $token',
          );

          return true;
        }

        await Future<void>.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
      }
    } catch (error, stackTrace) {
      debugPrint(
        'APNS token error >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }

    return false;
  }

  /// ============================================================
  /// TOPIC SUBSCRIPTION
  /// ============================================================

  Future<void>
  _subscribeTopicSafely() async {
    final messaging = _messaging;

    if (messaging == null) {
      return;
    }

    try {
      /// IMPORTANT:
      /// APNs exists only for iOS.
      ///
      /// Your old code checked APNs on Android too,
      /// which caused Android topic subscription to stop.
      if (defaultTargetPlatform ==
          TargetPlatform.iOS) {
        final apnsReady =
        await _waitForAPNSToken();

        if (!apnsReady) {
          debugPrint(
            'Skip topic subscription. '
                'APNS token is not ready.',
          );

          return;
        }
      }

      await messaging.subscribeToTopic(
        notificationTopic,
      );

      debugPrint(
        'Subscribed FCM topic >>> '
            '$notificationTopic',
      );
    } catch (error, stackTrace) {
      /// Chinese Android device without GMS may fail here.
      ///
      /// Ignore safely.
      debugPrint(
        'FCM topic subscription unavailable >>> '
            '$error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// FOREGROUND MESSAGE
  /// ============================================================

  void _listenForegroundMessages() {
    _onMessageSubscription?.cancel();

    _onMessageSubscription =
        FirebaseMessaging.onMessage.listen(
              (remoteMessage) async {
            try {
              debugPrint(
                'Foreground FCM message >>> '
                    '${remoteMessage.messageId}',
              );

              debugPrint(
                'Foreground FCM data >>> '
                    '${remoteMessage.data}',
              );

              /// iOS displays notification automatically because
              /// setForegroundNotificationPresentationOptions()
              /// is enabled.
              if (defaultTargetPlatform ==
                  TargetPlatform.iOS) {
                return;
              }

              final notification =
                  remoteMessage.notification;

              if (notification == null) {
                return;
              }

              await _showAndroidLocalNotification(
                remoteMessage,
              );
            } catch (error, stackTrace) {
              debugPrint(
                'Foreground notification error >>> '
                    '$error',
              );

              debugPrintStack(
                stackTrace: stackTrace,
              );
            }
          },
          onError: (
              Object error,
              StackTrace stackTrace,
              ) {
            debugPrint(
              'FCM foreground stream error >>> '
                  '$error',
            );

            debugPrintStack(
              stackTrace: stackTrace,
            );
          },
        );
  }

  /// ============================================================
  /// SHOW ANDROID LOCAL NOTIFICATION
  /// ============================================================

  Future<void>
  _showAndroidLocalNotification(
      RemoteMessage remoteMessage,
      ) async {
    if (defaultTargetPlatform !=
        TargetPlatform.android) {
      return;
    }

    if (!_localNotificationInitialized) {
      return;
    }

    final notification =
        remoteMessage.notification;

    if (notification == null) {
      return;
    }

    final android =
        notification.android;

    try {
      await flutterLocalNotificationsPlugin
          .show(
        remoteMessage.messageId?.hashCode ??
            notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android:
          AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription:
            channel.description,
            importance:
            Importance.max,
            priority:
            Priority.high,
            icon:
            android?.smallIcon ??
                '@mipmap/ic_launcher',
          ),
        ),
        payload:
        _buildPayload(
          remoteMessage.data,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Show local notification failed >>> '
            '$error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// OPENED APP
  /// ============================================================

  void _listenMessageOpenedApp() {
    _onMessageOpenedAppSubscription
        ?.cancel();

    _onMessageOpenedAppSubscription =
        FirebaseMessaging
            .onMessageOpenedApp
            .listen(
              (remoteMessage) {
            debugPrint(
              'Notification opened app >>> '
                  '${remoteMessage.data}',
            );

            _handleNotificationTap(
              remoteMessage.data,
            );
          },
          onError: (
              Object error,
              StackTrace stackTrace,
              ) {
            debugPrint(
              'Opened notification stream error >>> '
                  '$error',
            );

            debugPrintStack(
              stackTrace: stackTrace,
            );
          },
        );
  }

  /// ============================================================
  /// TERMINATED APP
  /// ============================================================

  Future<void>
  _handleInitialMessage() async {
    final messaging = _messaging;

    if (messaging == null) {
      return;
    }

    try {
      final remoteMessage =
      await messaging.getInitialMessage();

      if (remoteMessage == null) {
        return;
      }

      debugPrint(
        'App launched from notification >>> '
            '${remoteMessage.data}',
      );

      /// Small delay so router has time to initialize.
      await Future<void>.delayed(
        const Duration(
          milliseconds: 300,
        ),
      );

      _handleNotificationTap(
        remoteMessage.data,
      );
    } catch (error, stackTrace) {
      debugPrint(
        'Initial FCM message error >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// LOCAL NOTIFICATION TAP
  /// ============================================================

  void _onLocalNotificationTap(
      NotificationResponse response,
      ) {
    final payload =
        response.payload;

    if (payload == null ||
        payload.isEmpty) {
      return;
    }

    try {
      final decoded =
      jsonDecode(
        payload,
      );

      if (decoded
      is Map<String, dynamic>) {
        _handleNotificationTap(
          decoded,
        );
      } else if (decoded is Map) {
        _handleNotificationTap(
          Map<String, dynamic>.from(
            decoded,
          ),
        );
      }
    } catch (error) {
      debugPrint(
        'Unable to parse notification payload >>> '
            '$error',
      );
    }
  }

  /// ============================================================
  /// NOTIFICATION NAVIGATION
  /// ============================================================

  void _handleNotificationTap(
      Map<String, dynamic> data,
      ) {
    debugPrint(
      'Notification navigation data >>> $data',
    );

    final handler =
        _notificationTapHandler;

    if (handler == null) {
      return;
    }

    try {
      final result =
      handler(
        data,
      );

      if (result is Future) {
        unawaited(
          result,
        );
      }
    } catch (error, stackTrace) {
      debugPrint(
        'Notification navigation error >>> $error',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );
    }
  }

  /// ============================================================
  /// PAYLOAD
  /// ============================================================

  String _buildPayload(
      Map<String, dynamic> data,
      ) {
    if (data.isEmpty) {
      return '{}';
    }

    try {
      return jsonEncode(
        data,
      );
    } catch (_) {
      return '{}';
    }
  }

  /// ============================================================
  /// MANUAL TOKEN RETRY
  /// ============================================================

  /// Useful if:
  /// - device was temporarily offline
  /// - Google Play Services became available later
  /// - APNs was not ready during startup
  Future<void> refreshToken() async {
    if (!_fcmInitialized) {
      return;
    }

    await _saveInitialToken();
  }

  /// ============================================================
  /// DISPOSE
  /// ============================================================

  Future<void> dispose() async {
    await _onMessageSubscription
        ?.cancel();

    await _onMessageOpenedAppSubscription
        ?.cancel();

    await _onTokenRefreshSubscription
        ?.cancel();

    _onMessageSubscription = null;

    _onMessageOpenedAppSubscription =
    null;

    _onTokenRefreshSubscription =
    null;

    _fcmInitialized = false;

    _isInitializing = false;

    _container = null;

    _notificationTapHandler = null;
  }
}