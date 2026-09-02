import 'dart:convert';

LeadsResponse createLeadResponseFromJson(String str) =>
    LeadsResponse.fromJson(json.decode(str));

String createLeadResponseToJson(LeadsResponse data) =>
    json.encode(data.toJson());

class LeadsResponse {
  String? status;
  String? responseCode;
  String? description;
  bool? isRequiredUpdate;
  bool? isForceUpdate;
  List<LeadVO>? details;
  PaginationVO? pagination;

  LeadsResponse({
    this.status,
    this.responseCode,
    this.description,
    this.isRequiredUpdate,
    this.isForceUpdate,
    this.details,
    this.pagination,
  });

  factory LeadsResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      LeadsResponse(
        status: json["status"],
        responseCode: json["response_code"],
        description: json["description"],
        isRequiredUpdate: json["is_requiered_update"],
        isForceUpdate: json["isforce_update"],
        details: json["details"] == null
            ? []
            : List<LeadVO>.from(
          json["details"].map(
                (x) => LeadVO.fromJson(x),
          ),
        ),
        pagination: json["pagination"] == null
            ? null
            : PaginationVO.fromJson(
          json["pagination"],
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "is_requiered_update": isRequiredUpdate,
    "isforce_update": isForceUpdate,
    "details": details == null
        ? []
        : List<dynamic>.from(
      details!.map(
            (x) => x.toJson(),
      ),
    ),
    "pagination": pagination?.toJson(),
  };
}

class LeadVO {
  int? lid;
  String? uuid;
  String? businessName;

  dynamic firstname;
  dynamic firstName;
  dynamic lastName;

  String? contactName;
  String? contactEmail;

  dynamic contactNo;
  String? phone;
  String? secondaryContactNumber;
  String? title;

  String? bizType;
  String? source;
  String? division;
  String? township;
  String? address;

  String? product;
  String? package;
  String? packageTotal;
  String? discount;

  String? note;
  String? status;
  String? channel;

  String? installationAppointment;
  String? estContractDate;
  String? estStartDate;

  String? followupDate;
  String? followUpDate;
  String? estFollowUpDate;

  String? startDate;

  bool? isReferral;

  String? meetingNote;
  String? nextStep;

  int? organizationId;

  dynamic customFields;

  String? plan;

  int? leadAssign;
  int? createdBy;

  String? createdByName;
  String? uploadedBy;

  String? createdAt;
  String? updatedAt;

  LeadVO({
    this.lid,
    this.uuid,
    this.businessName,
    this.firstname,
    this.firstName,
    this.lastName,
    this.contactName,
    this.contactEmail,
    this.contactNo,
    this.phone,
    this.secondaryContactNumber,
    this.bizType,
    this.source,
    this.division,
    this.township,
    this.address,
    this.product,
    this.package,
    this.packageTotal,
    this.discount,
    this.note,
    this.status,
    this.channel,
    this.installationAppointment,
    this.estContractDate,
    this.estStartDate,
    this.followupDate,
    this.followUpDate,
    this.estFollowUpDate,
    this.startDate,
    this.isReferral,
    this.meetingNote,
    this.nextStep,
    this.organizationId,
    this.customFields,
    this.plan,
    this.leadAssign,
    this.createdBy,
    this.createdByName,
    this.uploadedBy,
    this.createdAt,
    this.updatedAt,
    this.title
  });

  factory LeadVO.fromJson(
      Map<String, dynamic> json,
      ) =>
      LeadVO(
        lid: json["lid"],
        uuid: json["uuid"],
        businessName: json["business_name"],
        title: json["title"],
        firstname: json["firstname"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        contactName: json["contact_name"],
        contactEmail: json["contact_email"],
        contactNo: json["contactno"],
        phone: json["phone"],
        secondaryContactNumber:
        json["secondary_contact_number"],
        bizType: json["biz_type"],
        source: json["source"],
        division: json["division"],
        township: json["township"],
        address: json["address"],
        product: json["product"],
        package: json["package"],
        packageTotal: json["package_total"]?.toString(),
        discount: json["discount"]?.toString(),
        note: json["note"],
        status: json["status"],
        channel: json["channel"],
        installationAppointment:
        json["installation_appointment"],
        estContractDate: json["est_contract_date"],
        estStartDate: json["est_start_date"],
        followupDate: json["followup_date"],
        followUpDate: json["follow_up_date"],
        estFollowUpDate: json["est_follow_up_date"],
        startDate: json["start_date"],
        isReferral: json["is_referral"],
        meetingNote: json["meeting_note"],
        nextStep: json["next_step"],
        organizationId: json["organization_id"],
        customFields: json["custom_fields"],
        plan: json["plan"],
        leadAssign: json["lead_assign"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        uploadedBy: json["uploaded_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "uuid": uuid,
    "business_name": businessName,
    "firstname": firstname,
    "first_name": firstName,
    "last_name": lastName,
    "contact_name": contactName,
    "contact_email": contactEmail,
    "contactno": contactNo,
    "phone": phone,
    "secondary_contact_number":
    secondaryContactNumber,
    "biz_type": bizType,
    "source": source,
    "title": title,
    "division": division,
    "township": township,
    "address": address,
    "product": product,
    "package": package,
    "package_total": packageTotal,
    "discount": discount,
    "note": note,
    "status": status,
    "channel": channel,
    "installation_appointment":
    installationAppointment,
    "est_contract_date": estContractDate,
    "est_start_date": estStartDate,
    "followup_date": followupDate,
    "follow_up_date": followUpDate,
    "est_follow_up_date": estFollowUpDate,
    "start_date": startDate,
    "is_referral": isReferral,
    "meeting_note": meetingNote,
    "next_step": nextStep,
    "organization_id": organizationId,
    "custom_fields": customFields,
    "plan": plan,
    "lead_assign": leadAssign,
    "created_by": createdBy,
    "created_by_name": createdByName,
    "uploaded_by": uploadedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class PaginationVO {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;

  PaginationVO({
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
  });

  factory PaginationVO.fromJson(
      Map<String, dynamic> json,
      ) =>
      PaginationVO(
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