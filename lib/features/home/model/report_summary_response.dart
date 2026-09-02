import 'dart:convert';

ReportSummaryResponse activityOverviewResponseFromJson(String str) =>
    ReportSummaryResponse.fromJson(json.decode(str));

String activityOverviewResponseToJson(ReportSummaryResponse data) =>
    json.encode(data.toJson());

class ReportSummaryResponse {
  ReportSummaryResponse({
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
  ReportSummaryDetail? details;

  factory ReportSummaryResponse.fromJson(Map<String, dynamic> json) {
    return ReportSummaryResponse(
      status: json["status"]?.toString(),
      responseCode: json["response_code"]?.toString(),
      description: json["description"]?.toString(),
      isRequieredUpdate: json["is_requiered_update"],
      isforceUpdate: json["isforce_update"],
      details: json["details"] == null
          ? null
          : ReportSummaryDetail.fromJson(json["details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "details": details?.toJson(),
  };
}

class ReportSummaryDetail {
  ReportSummaryDetail({
    this.dailyFollowUpData,
    this.weeklyFollowUpData,
    this.dailyAppointmentData,
    this.weeklyAppointmentData,
    this.leadAssignedData,
  });

  List<ActivityVO>? dailyFollowUpData;
  List<ActivityVO>? weeklyFollowUpData;
  List<ActivityVO>? dailyAppointmentData;
  List<ActivityVO>? weeklyAppointmentData;
  List<LeadAssignedVO>? leadAssignedData;

  factory ReportSummaryDetail.fromJson(Map<String, dynamic> json) {
    return ReportSummaryDetail(
      dailyFollowUpData: _activityList(json["daily_follow_up_data"]),
      weeklyFollowUpData: _activityList(json["weekly_follow_up_data"]),
      dailyAppointmentData: _activityList(json["daily_appointment_data"]),
      weeklyAppointmentData: _activityList(json["weekly_appointment_data"]),
      leadAssignedData: _leadList(json["lead_assingend_data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "daily_follow_up_data":
    dailyFollowUpData?.map((e) => e.toJson()).toList() ?? [],
    "weekly_follow_up_data":
    weeklyFollowUpData?.map((e) => e.toJson()).toList() ?? [],
    "daily_appointment_data":
    dailyAppointmentData?.map((e) => e.toJson()).toList() ?? [],
    "weekly_appointment_data":
    weeklyAppointmentData?.map((e) => e.toJson()).toList() ?? [],
    "lead_assingend_data":
    leadAssignedData?.map((e) => e.toJson()).toList() ?? [],
  };
}

class ActivityVO {
  ActivityVO({
    this.lid,
    this.followupDate,
    this.businessName,
    this.status,
    this.followupVia,
  });

  String? lid;
  String? followupDate;
  String? businessName;
  String? status;
  String? followupVia;

  factory ActivityVO.fromJson(Map<String, dynamic> json) {
    return ActivityVO(
      lid: json["lid"]?.toString(),
      followupDate: json["followup_date"]?.toString(),
      businessName: json["business_name"]?.toString(),
      status: json["status"]?.toString(),
      followupVia: json["followup_via"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "followup_date": followupDate,
    "business_name": businessName,
    "status": status,
    "followup_via": followupVia,
  };
}

class LeadAssignedVO {
  LeadAssignedVO({
    this.lid,
    this.businessName,
    this.contactNo,
    this.address,
  });

  String? lid;
  String? businessName;
  String? contactNo;
  String? address;

  factory LeadAssignedVO.fromJson(Map<String, dynamic> json) {
    return LeadAssignedVO(
      lid: json["lid"]?.toString(),
      businessName: json["business_name"]?.toString(),
      contactNo: json["contactno"]?.toString(),
      address: json["address"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "business_name": businessName,
    "contactno": contactNo,
    "address": address,
  };
}

List<ActivityVO> _activityList(dynamic value) {
  if (value == null || value is! List) return [];

  return value
      .whereType<Map>()
      .map((e) => ActivityVO.fromJson(Map<String, dynamic>.from(e)))
      .toList();
}

List<LeadAssignedVO> _leadList(dynamic value) {
  if (value == null || value is! List) return [];

  return value
      .whereType<Map>()
      .map((e) => LeadAssignedVO.fromJson(Map<String, dynamic>.from(e)))
      .toList();
}