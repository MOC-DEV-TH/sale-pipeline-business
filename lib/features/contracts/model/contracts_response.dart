import 'dart:convert';

ContractsResponse contractedLeadVoFromJson(String str) =>
    ContractsResponse.fromJson(json.decode(str));

String contractedLeadVoToJson(ContractsResponse data) =>
    json.encode(data.toJson());

class ContractsResponse {
  ContractsResponse({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
    this.details,
  });

  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;
  List<ContractDetailVo>? details;

  factory ContractsResponse.fromJson(Map<String, dynamic> json) {
    return ContractsResponse(
      status: json["status"]?.toString(),
      responseCode: json["response_code"]?.toString(),
      description: json["description"]?.toString(),
      isRequieredUpdate: json["is_requiered_update"],
      isforceUpdate: json["isforce_update"],
      details: (json["details"] as List<dynamic>?)
          ?.map((e) => ContractDetailVo.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "details": details?.map((e) => e.toJson()).toList() ?? [],
  };
}

class ContractDetailVo {
  ContractDetailVo({
    this.businessName,
    this.status,
    this.contactInformation,
    this.profileId,
    this.sign,
  });

  String? businessName;
  String? status;
  String? contactInformation;
  String? profileId;
  String? sign;

  factory ContractDetailVo.fromJson(Map<String, dynamic> json) {
    return ContractDetailVo(
      businessName: json["business_name"]?.toString(),
      status: json["status"]?.toString(),
      contactInformation: json["contact_information"]?.toString(),
      profileId: json["profile_id"]?.toString(),
      sign: json["sign"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "business_name": businessName,
    "status": status,
    "contact_information": contactInformation,
    "profile_id": profileId,
    "sign": sign,
  };
}