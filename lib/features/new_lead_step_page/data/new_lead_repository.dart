import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/network/model/default_network_response.dart';

import '../../../network/api_constants.dart';
import '../../../network/dio_provider.dart';
import '../../../network/error_handler.dart';
import '../model/sale_dropdown_response.dart';

part 'new_lead_repository.g.dart';

class NewLeadRepository {
  NewLeadRepository({required this.dio, required this.ref});

  final Dio dio;
  final Ref ref;

  Future<SaleDropdownDataResponse> fetchSaleDropdownData() async {
    try {
      final response = await dio.get(kEndPointGetSaleDdlData);

      if (response.data == null) {
        throw Exception('Invalid server response');
      }

      late final Map<String, dynamic> json;

      if (response.data is String) {
        json = jsonDecode(response.data) as Map<String, dynamic>;
      } else if (response.data is Map) {
        json = Map<String, dynamic>.from(response.data as Map);
      } else {
        throw Exception(
          'Unexpected response type: ${response.data.runtimeType}',
        );
      }

      return SaleDropdownDataResponse.fromJson(json);
    } on DioException catch (e) {
      debugPrint('Sale DDL Error >>> ${e.response?.data}');

      String message = ErrorHandler.handle(e).failure.message;

      final errorData = e.response?.data;

      if (errorData is Map) {
        final map = Map<String, dynamic>.from(errorData);

        message = map['message']?.toString() ??
            map['description']?.toString() ??
            map['error']?.toString() ??
            message;
      }

      throw message;
    } catch (e) {
      debugPrint('Sale DDL Catch Error >>> $e');
      rethrow;
    }
  }

  Future<DefaultNetworkResponse> submitLead({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await dio.post(
        kEndPointSubmitLead,
        data: payload,
      );

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler.handle(e).failure.message;
    }
  }
}

@riverpod
NewLeadRepository newLeadRepository(NewLeadRepositoryRef ref) {
  return NewLeadRepository(dio: ref.watch(dioProvider()), ref: ref);
}

@riverpod
Future<SaleDropdownDataResponse> fetchSaleDropdownData(
  FetchSaleDropdownDataRef ref,
) async {
  final repository = ref.watch(newLeadRepositoryProvider);
  return repository.fetchSaleDropdownData();
}
