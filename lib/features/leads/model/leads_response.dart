import 'dart:convert';

LeadsResponse leadVoFromJson(String str) =>
    LeadsResponse.fromJson(json.decode(str));

String leadVoToJson(LeadsResponse data) => json.encode(data.toJson());

class LeadsResponse {
  LeadsResponse({
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
  List<LeadDetailVO>? details;

  factory LeadsResponse.fromJson(Map<String, dynamic> json) {
    return LeadsResponse(
      status: json["status"]?.toString(),
      responseCode: json["response_code"]?.toString(),
      description: json["description"]?.toString(),
      isRequieredUpdate: json["is_requiered_update"],
      isforceUpdate: json["isforce_update"],
      details: (json["details"] as List<dynamic>?)
          ?.map((e) => LeadDetailVO.fromJson(e))
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

class LeadDetailVO {
  LeadDetailVO({
    this.lid,
    this.businessName,
    this.status,
    this.firstname,
    this.followupDate,
    this.followUpDate,
    this.contactNo,
    this.package,
    this.plan,
    this.leadAssign,
    this.createdBy,
    this.estContractDate,
  });

  String? lid;
  String? businessName;
  String? status;
  String? firstname;
  String? followupDate;
  String? followUpDate;
  String? contactNo;
  String? package;
  String? plan;
  String? leadAssign;
  String? createdBy;
  String? estContractDate;

  factory LeadDetailVO.fromJson(Map<String, dynamic> json) {
    return LeadDetailVO(
      lid: json["lid"]?.toString(),
      businessName: json["business_name"]?.toString(),
      status: json["status"]?.toString(),
      firstname: json["firstname"]?.toString(),
      followupDate: json["followup_date"]?.toString(),
      followUpDate: json["follow_up_date"]?.toString(),
      contactNo: json["contactno"]?.toString(),
      package: json["package"]?.toString(),
      plan: json["plan"]?.toString(),
      leadAssign: json["lead_assign"]?.toString(),
      createdBy: json["created_by"]?.toString(),
      estContractDate: json["est_contract_date"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "business_name": businessName,
    "status": status,
    "firstname": firstname,
    "followup_date": followupDate,
    "follow_up_date": followUpDate,
    "contactno": contactNo,
    "package": package,
    "plan": plan,
    "lead_assign": leadAssign,
    "created_by": createdBy,
    "est_contract_date": estContractDate,
  };
}