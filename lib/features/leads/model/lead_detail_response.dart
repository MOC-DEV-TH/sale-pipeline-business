import 'dart:convert';

LeadDetailResponse businessDetailVoFromJson(String str) =>
    LeadDetailResponse.fromJson(json.decode(str));

String businessDetailVoToJson(LeadDetailResponse data) =>
    json.encode(data.toJson());

class LeadDetailResponse {
  LeadDetailResponse({
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
  LeadDetailVO? details;

  factory LeadDetailResponse.fromJson(Map<String, dynamic> json) {
    return LeadDetailResponse(
      status: json["status"]?.toString(),
      responseCode: json["response_code"]?.toString(),
      description: json["description"]?.toString(),
      isRequieredUpdate: json["is_requiered_update"],
      isforceUpdate: json["isforce_update"],
      details: json["details"] == null
          ? null
          : LeadDetailVO.fromJson(json["details"]),
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

class LeadDetailVO {
  LeadDetailVO({
    this.lid,
    this.uid,
    this.profileId,
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.contactInformation,
    this.package,
    this.plan,
    this.notes,
    this.installation,
    this.leadSource,
    this.businessType,
    this.businessCategory,
    this.township,
    this.division,
    this.contactno,
    this.businessName,
    this.currentIsp,
    this.potential,
    this.weighted,
    this.followupVia,
    this.followupDate,
    this.estimateFlightdate,
    this.channel,
    this.designation,
    this.compound,
    this.createdBy,
    this.updatedBy,
    this.creationDate,
    this.modifiedDate,
    this.status,
    this.statusKey,
    this.packageTotal,
    this.referrelId,
    this.leadAssign,
    this.isReferal,
    this.discount,
    this.latitude,
    this.longitude,
    this.contractDate,
    this.customerNote,
    this.installationAppointmentDate,
    this.secondaryContactNumber,
    this.businessTypeOther,
    this.designationTypeOther,
    this.meetingNotes,
    this.nextStep,
    this.estContractDate,
    this.estStartDate,
    this.estFollowUpDate,
    this.customerType,
  });

  String? lid;
  String? uid;
  String? profileId;
  String? firstname;
  String? lastname;
  String? email;
  String? address;
  String? contactInformation;
  String? package;
  String? plan;
  String? notes;
  String? installation;
  String? leadSource;
  String? customerType;
  String? businessType;
  String? businessCategory;
  String? township;
  String? division;
  String? contactno;
  String? businessName;
  String? currentIsp;
  String? potential;
  String? weighted;
  String? followupVia;
  String? followupDate;
  String? estimateFlightdate;
  String? channel;
  String? designation;
  String? compound;
  String? createdBy;
  String? updatedBy;
  String? creationDate;
  String? modifiedDate;
  String? status;
  String? statusKey;
  String? packageTotal;
  String? referrelId;
  String? leadAssign;
  String? isReferal;
  String? discount;
  String? latitude;
  String? longitude;
  String? contractDate;
  String? installationAppointmentDate;
  String? customerNote;
  String? secondaryContactNumber;
  String? businessTypeOther;
  String? designationTypeOther;
  String? meetingNotes;
  String? nextStep;
  String? estContractDate;
  String? estStartDate;
  String? estFollowUpDate;

  factory LeadDetailVO.fromJson(Map<String, dynamic> json) {
    return LeadDetailVO(
      lid: json["lid"]?.toString(),
      uid: json["uid"]?.toString(),
      profileId: json["profile_id"]?.toString(),
      firstname: json["firstname"]?.toString(),
      lastname: json["lastname"]?.toString(),
      email: json["email"]?.toString(),
      customerType: json["customer_type"]?.toString(),
      address: json["address"]?.toString(),
      contactInformation: json["contact_information"]?.toString(),
      package: json["package"]?.toString(),
      plan: json["plan"]?.toString(),
      notes: json["notes"]?.toString(),
      installation: json["installation"]?.toString(),
      leadSource: json["lead_source"]?.toString(),
      businessType: json["business_type"]?.toString(),
      businessCategory: json["business_category"]?.toString(),
      township: json["township"]?.toString(),
      division: json["division"]?.toString(),
      contactno: json["contactno"]?.toString(),
      businessName: json["business_name"]?.toString(),
      currentIsp: json["current_isp"]?.toString(),
      potential: json["potential"]?.toString(),
      weighted: json["weighted"]?.toString(),
      followupVia: json["followup_via"]?.toString(),
      followupDate: json["followup_date"]?.toString(),
      estimateFlightdate: json["estimate_flightdate"]?.toString(),
      channel: json["channel"]?.toString(),
      designation: json["designation"]?.toString(),
      compound: json["compound"]?.toString(),
      createdBy: json["created_by"]?.toString(),
      updatedBy: json["updated_by"]?.toString(),
      creationDate: json["creation_date"]?.toString(),
      modifiedDate: json["modified_date"]?.toString(),
      status: json["status"]?.toString(),
      statusKey: json["status_key"]?.toString(),
      packageTotal: json["package_total"]?.toString(),
      referrelId: json["referrel_id"]?.toString(),
      leadAssign: json["lead_assign"]?.toString(),
      isReferal: json["isReferal"]?.toString(),
      discount: json["discount"]?.toString(),
      latitude: json["latitude"]?.toString(),
      longitude: json["longitude"]?.toString(),
      contractDate: json["contract_date"]?.toString(),
      installationAppointmentDate:
      json["installation_appointment_date"]?.toString(),
      customerNote: json["customer_note"]?.toString(),
      secondaryContactNumber:
      json["secondary_contact_number"]?.toString(),
      businessTypeOther: json["business_type_other"]?.toString(),
      designationTypeOther: json["designation_other"]?.toString(),
      meetingNotes: json["meeting_notes"]?.toString(),
      nextStep: json["next_step"]?.toString(),
      estContractDate: json["est_contract_date"]?.toString(),
      estStartDate: json["est_start_date"]?.toString(),
      estFollowUpDate: json["follow_up_date"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "uid": uid,
    "profile_id": profileId,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "customer_type": customerType,
    "address": address,
    "contact_information": contactInformation,
    "package": package,
    "plan": plan,
    "notes": notes,
    "installation": installation,
    "lead_source": leadSource,
    "business_type": businessType,
    "business_category": businessCategory,
    "township": township,
    "division": division,
    "contactno": contactno,
    "business_name": businessName,
    "current_isp": currentIsp,
    "potential": potential,
    "weighted": weighted,
    "followup_via": followupVia,
    "followup_date": followupDate,
    "estimate_flightdate": estimateFlightdate,
    "channel": channel,
    "designation": designation,
    "compound": compound,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "creation_date": creationDate,
    "modified_date": modifiedDate,
    "status": status,
    "status_key": statusKey,
    "package_total": packageTotal,
    "referrel_id": referrelId,
    "lead_assign": leadAssign,
    "isReferal": isReferal,
    "discount": discount,
    "latitude": latitude,
    "longitude": longitude,
    "contract_date": contractDate,
    "installation_appointment_date": installationAppointmentDate,
    "customer_note": customerNote,
    "secondary_contact_number": secondaryContactNumber,
    "designation_other": designationTypeOther,
    "business_type_other": businessTypeOther,
    "meeting_notes": meetingNotes,
    "next_step": nextStep,
    "est_contract_date": estContractDate,
    "est_start_date": estStartDate,
    "follow_up_date": estFollowUpDate,
  };
}