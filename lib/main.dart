import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'fcm/fcm_service.dart';
import 'firebase_options.dart';
import 'routing/go_router/go_router_delegate.dart';
import 'utils/fonts.dart';

final ProviderContainer container = ProviderContainer();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// ============================================================
/// FCM BACKGROUND HANDLER
/// ============================================================

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    debugPrint(
      'FCM Background Message >>> '
      '${message.messageId}',
    );

    debugPrint(
      'FCM Background Data >>> '
      '${message.data}',
    );
  } catch (error, stackTrace) {
    /// FCM/Firebase failure must not crash
    /// background isolate.
    debugPrint(
      'FCM background handler unavailable >>> '
      '$error',
    );

    debugPrintStack(stackTrace: stackTrace);
  }
}

/// ============================================================
/// MAIN
/// ============================================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  registerErrorHandlers();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Initialize only required app services here.
  await _bootstrap();

  try {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (error, stackTrace) {
    debugPrint(
      'Unable to register FCM background handler >>> '
      '$error',
    );

    debugPrintStack(stackTrace: stackTrace);
  }

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

/// ============================================================
/// BOOTSTRAP
/// ============================================================

Future<void> _bootstrap() async {
  try {
    await GetStorage.init();
  } catch (error, stackTrace) {
    debugPrint('GetStorage initialization error >>> $error');

    debugPrintStack(stackTrace: stackTrace);

    /// GetStorage may be required by your application.
    ///
    /// If your whole application depends on it,
    /// you may prefer rethrow here.
  }

  try {
    await initializeDateFormatting('en_US');
  } catch (error, stackTrace) {
    debugPrint(
      'Date formatting initialization error >>> '
      '$error',
    );

    debugPrintStack(stackTrace: stackTrace);
  }
}

/// ============================================================
/// OPTIONAL NOTIFICATION INITIALIZATION
/// ============================================================

Future<void> _initializeNotificationServicesSafely() async {
  try {
    /// Firebase initialization itself is optional
    /// for application startup.
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    debugPrint('Firebase initialized successfully');
  } catch (error, stackTrace) {
    debugPrint(
      'Firebase unavailable on this device >>> '
      '$error',
    );

    debugPrintStack(stackTrace: stackTrace);

    return;
  }

  try {
    await FCMService().initialize(container: container);
  } catch (error, stackTrace) {
    debugPrint('FCM unavailable on this device >>> $error');

    debugPrintStack(stackTrace: stackTrace);
  }
}

/// ============================================================
/// APP
/// ============================================================

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    /// Wait until Flutter UI has started.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_initializeNotificationServicesSafely());
    });
  }

  @override
  void dispose() {
    unawaited(FCMService().dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterDelegateProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      supportedLocales: const [Locale('en'), Locale('my')],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routeInformationParser: router.routeInformationParser,

      routeInformationProvider: router.routeInformationProvider,

      routerDelegate: router.routerDelegate,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: kFontFuturuRegular,
      ),

      themeMode: ThemeMode.system,
    );
  }
}

/// ============================================================
/// GLOBAL ERROR HANDLING
/// ============================================================

void registerErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);

    debugPrint(details.exceptionAsString());

    debugPrint(details.stack.toString());
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint('Unhandled error >>> $error');

    debugPrintStack(stackTrace: stack);

    /// Returning true means the error
    /// has been handled.
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (kDebugMode) {
      debugPrint(details.exceptionAsString());

      debugPrint(details.stack.toString());
    }

    return const Material(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Something went wrong.\n'
            'Please restart the application.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  };
}
