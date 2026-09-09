import 'dart:convert';

LeadsResponse leadsResponseFromJson(String str) =>
    LeadsResponse.fromJson(json.decode(str));

String leadsResponseToJson(LeadsResponse data) => json.encode(data.toJson());

class LeadsResponse {
  dynamic status;
  dynamic responseCode;
  dynamic description;
  dynamic isRequieredUpdate;
  dynamic isforceUpdate;

  List<LeadVO>? details;

  PaginationVO? pagination;

  LeadsResponse({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
    this.details,
    this.pagination,
  });

  factory LeadsResponse.fromJson(Map<String, dynamic> json) => LeadsResponse(
    status: json["status"],
    responseCode: json["response_code"],
    description: json["description"],
    isRequieredUpdate: json["is_requiered_update"],
    isforceUpdate: json["isforce_update"],

    details: json["details"] == null
        ? []
        : List<LeadVO>.from(
            (json["details"] as List).map(
              (x) => LeadVO.fromJson(Map<String, dynamic>.from(x)),
            ),
          ),

    pagination: json["pagination"] == null
        ? null
        : PaginationVO.fromJson(Map<String, dynamic>.from(json["pagination"])),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,

    "details": details == null
        ? []
        : List<dynamic>.from(details!.map((x) => x.toJson())),

    "pagination": pagination?.toJson(),
  };
}

class LeadVO {
  dynamic lid;
  dynamic businessName;
  dynamic status;
  dynamic firstname;

  dynamic followupDate;
  dynamic followUpDate;

  dynamic contactno;

  dynamic package;
  dynamic plan;

  dynamic leadAssign;
  dynamic createdByName;
  dynamic createdDate;

  dynamic customFields;

  dynamic estContractDate;

  dynamic title;
  dynamic bizType;
  dynamic source;
  dynamic updatedAt;
  dynamic closedDate;

  LeadVO({
    this.lid,
    this.businessName,
    this.status,
    this.firstname,
    this.followupDate,
    this.followUpDate,
    this.contactno,
    this.package,
    this.plan,
    this.leadAssign,
    this.createdByName,
    this.createdDate,
    this.customFields,
    this.estContractDate,
    this.title,
    this.bizType,
    this.source,
    this.updatedAt,
    this.closedDate
  });

  factory LeadVO.fromJson(Map<String, dynamic> json) => LeadVO(
    lid: json["lid"],
    businessName: json["business_name"],
    status: json["status"],
    firstname: json["firstname"],

    followupDate: json["followup_date"],
    followUpDate: json["follow_up_date"],

    contactno: json["contactno"],

    package: json["package"],
    plan: json["plan"],

    leadAssign: json["lead_assign"],
    createdByName: json["created_by_name"],
    createdDate: json["created_date"],

    customFields: json["custom_fields"],

    estContractDate: json["est_contract_date"],

    title: json["title"],
    bizType: json["biz_type"],
    source: json["source"],
    updatedAt: json["updated_at"],
    closedDate: json["closed_date"],
  );

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "business_name": businessName,
    "status": status,
    "firstname": firstname,

    "followup_date": followupDate,
    "follow_up_date": followUpDate,

    "contactno": contactno,

    "package": package,
    "plan": plan,

    "lead_assign": leadAssign,
    "created_by": createdByName,
    "created_by_name": createdDate,

    "custom_fields": customFields,

    "est_contract_date": estContractDate,

    "title": title,
    "biz_type": bizType,
    "source": source,
    "updated_at": updatedAt,
    "closed_date": closedDate,
  };
}

class PaginationVO {
  dynamic currentPage;
  dynamic perPage;
  dynamic total;
  dynamic lastPage;

  PaginationVO({this.currentPage, this.perPage, this.total, this.lastPage});

  factory PaginationVO.fromJson(Map<String, dynamic> json) => PaginationVO(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
    "last_page": lastPage,
  };
}
