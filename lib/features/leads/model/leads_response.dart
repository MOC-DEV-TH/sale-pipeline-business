import 'dart:convert';

LeadsResponse leadsResponseFromJson(String str) =>
    LeadsResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String leadsResponseToJson(LeadsResponse data) =>
    json.encode(data.toJson());

class LeadsResponse {
  String? status;
  String? responseCode;
  String? description;
  bool? isRequieredUpdate;
  bool? isforceUpdate;
  List<LeadVO>? details;
  Pagination? pagination;

  LeadsResponse({
    this.status,
    this.responseCode,
    this.description,
    this.isRequieredUpdate,
    this.isforceUpdate,
    this.details,
    this.pagination,
  });

  factory LeadsResponse.fromJson(Map<String, dynamic> json) =>
      LeadsResponse(
        status: json["status"],
        responseCode: json["response_code"],
        description: json["description"],
        isRequieredUpdate: json["is_requiered_update"],
        isforceUpdate: json["isforce_update"],
        details: (json["details"] as List<dynamic>? ?? [])
            .map((x) => LeadVO.fromJson(
          Map<String, dynamic>.from(x as Map),
        ))
            .toList(),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(
          Map<String, dynamic>.from(json["pagination"] as Map),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequieredUpdate,
    "isforce_update": isforceUpdate,
    "details": details?.map((x) => x.toJson()).toList() ?? [],
    "pagination": pagination?.toJson(),
  };
}

class LeadVO {
  int? lid;
  String? uuid;
  List<Field>? fields;
  int? organizationId;
  String? plan;
  int? leadAssign;
  int? createdBy;
  String? createdByName;
  String? uploadedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  LeadVO({
    this.lid,
    this.uuid,
    this.fields,
    this.organizationId,
    this.plan,
    this.leadAssign,
    this.createdBy,
    this.createdByName,
    this.uploadedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory LeadVO.fromJson(Map<String, dynamic> json) => LeadVO(
    lid: _parseInt(json["lid"]),
    uuid: json["uuid"],
    fields: (json["fields"] as List<dynamic>? ?? [])
        .map((x) => Field.fromJson(
      Map<String, dynamic>.from(x as Map),
    ))
        .toList(),
    organizationId: _parseInt(json["organization_id"]),
    plan: json["plan"],
    leadAssign: _parseInt(json["lead_assign"]),
    createdBy: _parseInt(json["created_by"]),
    createdByName: json["created_by_name"],
    uploadedBy: json["uploaded_by"],
    createdAt: _parseDate(json["created_at"]),
    updatedAt: _parseDate(json["updated_at"]),
  );

  /// Access a field by its API key.
  Field? fieldByKey(String key) {
    for (final field in fields ?? const <Field>[]) {
      if (field.key == key) return field;
    }
    return null;
  }

  String? fieldValue(String key) => fieldByKey(key)?.value;

  String? get businessName => fieldValue("business_name");
  String? get contactName => fieldValue("contact_name");

  // Compatibility with your existing LeadCard.
  String? get firstname => contactName;

  String? get lastName => fieldValue("last_name");
  String? get contactEmail => fieldValue("contact_email");
  String? get phone => fieldValue("phone");
  String? get secondaryContactNumber =>
      fieldValue("secondary_contact_number");
  String? get bizType => fieldValue("biz_type");
  String? get source => fieldValue("source");
  String? get division => fieldValue("division");
  String? get township => fieldValue("township");
  String? get address => fieldValue("address");
  String? get product => fieldValue("product");
  String? get package => fieldValue("package");
  String? get packageTotal => fieldValue("package_total");
  String? get discount => fieldValue("discount");
  String? get note => fieldValue("note");
  String? get status => fieldValue("status");
  String? get channel => fieldValue("channel");
  String? get installationAppointment =>
      fieldValue("installation_appointment");
  String? get estContractDate => fieldValue("est_contract_date");
  String? get estStartDate => fieldValue("est_start_date");
  String? get estFollowUpDate => fieldValue("est_follow_up_date");
  String? get closedDate => fieldValue("closed_date");
  String? get meetingNote => fieldValue("meeting_note");
  String? get nextStep => fieldValue("next_step");
  String? get priority => fieldValue("pf_priority");

  String? get cfIo => fieldValue("cf_io");
  String? get cfWhoDidYouMeetWith =>
      fieldValue("cf_who_did_you_meet_with");
  String? get cfBillingNote => fieldValue("cf_billing_note");
  String? get cfProposalReceivedDateFromBw =>
      fieldValue("cf_proposal_received_date_from_bw");
  String? get cfSubmissionDate => fieldValue("cf_submission_date");

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "uuid": uuid,
    "fields": fields?.map((x) => x.toJson()).toList() ?? [],
    "organization_id": organizationId,
    "plan": plan,
    "lead_assign": leadAssign,
    "created_by": createdBy,
    "created_by_name": createdByName,
    "uploaded_by": uploadedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Field {
  String? key;
  String? label;
  String? type;
  String? value;

  Field({
    this.key,
    this.label,
    this.type,
    this.value,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    key: json["key"],
    label: json["label"],
    type: json["type"],
    // Accept string or numeric scalar values while preserving null.
    value: json["value"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "label": label,
    "type": type,
    "value": value,
  };
}

class Pagination {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;

  Pagination({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: _parseInt(json["current_page"]),
    perPage: _parseInt(json["per_page"]),
    total: _parseInt(json["total"]),
    lastPage: _parseInt(json["last_page"]),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
    "last_page": lastPage,
  };
}

int? _parseInt(dynamic value) {
  if (value is int) return value;
  return int.tryParse(value?.toString() ?? "");
}

DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString());
}