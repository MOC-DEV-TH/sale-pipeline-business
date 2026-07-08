import 'dart:convert';

ContractedDetailResponse contractedDetailResponseFromJson(String str) =>
    ContractedDetailResponse.fromJson(json.decode(str));

String contractedDetailResponseToJson(ContractedDetailResponse data) =>
    json.encode(data.toJson());

class ContractedDetailResponse {
  ContractedDetailResponse({
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
  ContractedDetail? details;

  factory ContractedDetailResponse.fromJson(Map<String, dynamic> json) {
    return ContractedDetailResponse(
      status: json["status"]?.toString(),
      responseCode: json["response_code"]?.toString(),
      description: json["description"]?.toString(),
      isRequieredUpdate: json["is_requiered_update"],
      isforceUpdate: json["isforce_update"],
      details: json["details"] == null
          ? null
          : ContractedDetail.fromJson(json["details"]),
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

class ContractedDetail {
  ContractedDetail({
    this.profileId,
    this.division,
    this.township,
    this.plan,
    this.package,
    this.firstname,
    this.phone1,
    this.phone2,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.installationAppointmentDate,
    this.contractedDate,
    this.notes,
    this.businessName,
    this.packageTotal,
    this.customerType,
  });

  String? profileId;
  String? division;
  String? township;
  String? plan;
  String? package;
  String? firstname;
  String? phone1;
  String? phone2;
  String? email;
  String? address;
  String? latitude;
  String? longitude;
  String? installationAppointmentDate;
  String? contractedDate;
  String? notes;
  String? businessName;
  String? packageTotal;
  String? customerType;

  factory ContractedDetail.fromJson(Map<String, dynamic> json) {
    return ContractedDetail(
      profileId: json["profile_id"]?.toString(),
      division: json["division"]?.toString(),
      township: json["township"]?.toString(),
      plan: json["plan"]?.toString(),
      package: json["package"]?.toString(),
      firstname: json["firstname"]?.toString(),
      phone1: json["phone_1"]?.toString(),
      phone2: json["phone_2"]?.toString(),
      email: json["email"]?.toString(),
      address: json["address"]?.toString(),
      latitude: json["latitude"]?.toString(),
      longitude: json["longitude"]?.toString(),
      installationAppointmentDate:
      json["installation"]?.toString(),
      contractedDate: json["contract_date"]?.toString(),
      notes: json["notes"]?.toString(),
      businessName: json["business_name"]?.toString(),
      packageTotal: json["package_total"]?.toString(),
      customerType: json["customer_type"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "division": division,
    "township": township,
    "plan": plan,
    "package": package,
    "firstname": firstname,
    "phone_1": phone1,
    "phone_2": phone2,
    "email": email,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "installation": installationAppointmentDate,
    "contract_date": contractedDate,
    "notes": notes,
    "business_name": businessName,
    "package_total": packageTotal,
    "customer_type": customerType,
  };
}