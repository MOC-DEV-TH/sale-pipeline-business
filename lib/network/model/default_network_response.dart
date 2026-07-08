// To parse this JSON data, do
//
//     final networkResultVo = networkResultVoFromJson(jsonString);

import 'dart:convert';

DefaultNetworkResponse networkResultVoFromJson(String str) => DefaultNetworkResponse.fromJson(json.decode(str));

String networkResultVoToJson(DefaultNetworkResponse data) => json.encode(data.toJson());

class DefaultNetworkResponse {
  DefaultNetworkResponse({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
  });

  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;

  factory DefaultNetworkResponse.fromJson(Map<String, dynamic> json) => DefaultNetworkResponse(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
  };
}
