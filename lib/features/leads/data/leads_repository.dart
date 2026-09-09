import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/features/leads/model/lead_activity_response.dart';
import 'package:sale_pipeline_business/features/leads/model/lead_detail_response.dart';
import 'package:sale_pipeline_business/features/leads/model/lead_reminder_response.dart';
import 'package:sale_pipeline_business/features/leads/model/leads_response.dart';
import 'package:sale_pipeline_business/features/leads/model/participants_response.dart';

import '../../../network/api_constants.dart';
import '../../../network/dio_provider.dart';
import '../../../network/error_handler.dart';
import '../../../network/model/default_network_response.dart';

part 'leads_repository.g.dart';

class LeadsRepository {
  LeadsRepository({required this.dio, required this.ref});

  final Dio dio;
  final Ref ref;

  Future<LeadDetailsResponse> fetchLeadDetailByLeadId({
    required int leadId,
  }) async {
    try {
      final response = await dio.get("$kEndPointLeadDetailByLeadId/$leadId");

      return LeadDetailsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler.handle(e).failure.message;
    }
  }

  Future<DefaultNetworkResponse> updateLead({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await dio.post(kEndPointUpdateLead, data: payload);

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler.handle(e).failure.message;
    }
  }

  Future<LeadsResponse> fetchLeadsByOrganizationID({
    required int organizationID,
    required int pageNo,
  }) async {
    try {
      final response = await dio.get(
        kEndPointGetLeadsByOrganizationID,
        queryParameters: {
          kParamOrganizationID: organizationID,
          kParamPage: pageNo,
        },
      );

      if (response.data == null) {
        throw 'Invalid server response';
      }

      return LeadsResponse.fromJson(response.data);
    } on DioException catch (e) {
      String message = ErrorHandler.handle(e).failure.message;

      if (e.response?.data is Map<String, dynamic>) {
        message =
            e.response?.data['message'] ??
            e.response?.data['description'] ??
            e.response?.data['error'] ??
            message;
      }

      throw message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DefaultNetworkResponse> deleteLead({required int leadId}) async {
    try {
      final response = await dio.delete('$kEndPointDeleteLeadByID/$leadId');

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        throw data['message'] ?? ErrorHandler.handle(e).failure.message;
      }

      throw ErrorHandler.handle(e).failure.message;
    }
  }

  /// =========================================================
  /// ACTIVITY LOGS
  /// =========================================================

  Future<LeadActivityResponse> getLeadActivityLogs({
    required int leadId,
  }) async {
    try {
      final response = await dio.get(
        '$kEndPointDeleteLeadByID/$leadId/activity-logs',
      );

      if (response.data == null) {
        throw 'Invalid server response';
      }

      return LeadActivityResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _getErrorMessage(e);
    }
  }

  /// =========================================================
  /// REMINDERS
  /// =========================================================

  Future<LeadReminderResponse> getLeadReminders({required int leadId}) async {
    try {
      final response = await dio.get(
        '$kEndPointDeleteLeadByID/$leadId/reminders',
      );

      if (response.data == null) {
        throw 'Invalid server response';
      }

      return LeadReminderResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _getErrorMessage(e);
    }
  }

  /// =========================================================
  /// PARTICIPANTS
  /// =========================================================

  Future<ParticipantsResponse> getLeadParticipants({
    required int leadId,
  }) async {
    try {
      final response = await dio.get(
        '$kEndPointDeleteLeadByID/$leadId/participants',
      );

      if (response.data == null) {
        throw 'Invalid server response';
      }

      return ParticipantsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _getErrorMessage(e);
    }
  }

  /// =========================================================
  /// CREATE ACTIVITY
  /// =========================================================

  Future<DefaultNetworkResponse> createActivity({
    required int leadId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await dio.post(
        'leads/$leadId/activity-logs',
        data: payload,
      );

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final errors = data['errors'];

        if (errors is Map<String, dynamic>) {
          for (final value in errors.values) {
            if (value is List && value.isNotEmpty) {
              throw value.first.toString();
            }
          }
        }

        throw data['message']?.toString() ??
            ErrorHandler.handle(e).failure.message;
      }

      throw ErrorHandler.handle(e).failure.message;
    }
  }

  /// =========================================================
  /// CREATE REMINDER
  /// =========================================================

  Future<DefaultNetworkResponse> createReminder({
    required int leadId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await dio.post('leads/$leadId/reminders', data: payload);

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final errors = data['errors'];

        if (errors is Map<String, dynamic>) {
          for (final value in errors.values) {
            if (value is List && value.isNotEmpty) {
              throw value.first.toString();
            }
          }
        }

        throw data['message']?.toString() ??
            data['description']?.toString() ??
            ErrorHandler.handle(e).failure.message;
      }

      throw ErrorHandler.handle(e).failure.message;
    }
  }

  /// =========================================================
  /// REMOVE ACTIVITY
  /// =========================================================
  Future<DefaultNetworkResponse> removeActivity({
    required int leadId,
    required int activityLogId,
  }) async {
    try {
      final response = await dio.delete(
        'leads/$leadId/activity-logs/$activityLogId',
      );

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        throw data['message']?.toString() ??
            ErrorHandler.handle(e).failure.message;
      }

      throw ErrorHandler.handle(e).failure.message;
    }
  }

  /// =========================================================
  /// REMOVE REMINDER
  /// =========================================================

  Future<DefaultNetworkResponse> removeReminder({
    required int leadId,
    required int reminderId,
  }) async {
    try {
      final response = await dio.delete('leads/$leadId/reminders/$reminderId');

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        throw data['message']?.toString() ??
            ErrorHandler.handle(e).failure.message;
      }

      throw ErrorHandler.handle(e).failure.message;
    }
  }

  /// =========================================================
  /// UPDATE ACTIVITY
  /// =========================================================

  Future<DefaultNetworkResponse> updateActivity({
    required int leadId,
    required int activityLogId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await dio.patch(
        'leads/$leadId/activity-logs/$activityLogId',
        data: payload,
      );

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final errors = data['errors'];

        if (errors is Map<String, dynamic>) {
          for (final value in errors.values) {
            if (value is List && value.isNotEmpty) {
              throw value.first.toString();
            }
          }
        }

        throw data['message']?.toString() ??
            ErrorHandler.handle(e).failure.message;
      }

      throw ErrorHandler.handle(e).failure.message;
    }
  }

  /// =========================================================
  /// UPDATE REMINDER
  /// =========================================================

  Future<DefaultNetworkResponse> updateReminder({
    required int leadId,
    required int reminderId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await dio.patch(
        'leads/$leadId/reminders/$reminderId',
        data: payload,
      );

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        final errors = data['errors'];

        if (errors is Map<String, dynamic>) {
          for (final value in errors.values) {
            if (value is List && value.isNotEmpty) {
              throw value.first.toString();
            }
          }
        }

        throw data['message']?.toString() ??
            ErrorHandler.handle(e).failure.message;
      }

      throw ErrorHandler.handle(e).failure.message;
    }
  }

  /// =========================================================
  /// GET ERROR MESSAGE
  /// =========================================================

  String _getErrorMessage(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ??
          data['description']?.toString() ??
          ErrorHandler.handle(e).failure.message;
    }

    return ErrorHandler.handle(e).failure.message;
  }
}

@riverpod
LeadsRepository leadsRepository(LeadsRepositoryRef ref) {
  return LeadsRepository(dio: ref.watch(dioProvider), ref: ref);
}

@riverpod
Future<LeadDetailsResponse> fetchLeadDetail(
  FetchLeadDetailRef ref, {
  required int leadId,
}) async {
  final repository = ref.watch(leadsRepositoryProvider);

  return repository.fetchLeadDetailByLeadId(leadId: leadId);
}

@riverpod
Future<LeadsResponse> fetchLeadsByOrganizationID(
  FetchLeadsByOrganizationIDRef ref, {
  required int organizationID,
  required int pageNo,
}) async {
  final repository = ref.watch(leadsRepositoryProvider);

  return repository.fetchLeadsByOrganizationID(
    organizationID: organizationID,
    pageNo: pageNo,
  );
}

/// ===========================================================
/// ACTIVITY LOG PROVIDER
/// ===========================================================

@riverpod
Future<LeadActivityResponse> leadActivityLogs(
  LeadActivityLogsRef ref, {
  required int leadId,
}) {
  return ref.watch(leadsRepositoryProvider).getLeadActivityLogs(leadId: leadId);
}

/// ===========================================================
/// REMINDER PROVIDER
/// ===========================================================

@riverpod
Future<LeadReminderResponse> leadReminders(
  LeadRemindersRef ref, {
  required int leadId,
}) {
  return ref.watch(leadsRepositoryProvider).getLeadReminders(leadId: leadId);
}

/// ===========================================================
/// PARTICIPANTS PROVIDER
/// ===========================================================

@riverpod
Future<ParticipantsResponse> leadParticipants(
  LeadParticipantsRef ref, {
  required int leadId,
}) {
  return ref.watch(leadsRepositoryProvider).getLeadParticipants(leadId: leadId);
}
