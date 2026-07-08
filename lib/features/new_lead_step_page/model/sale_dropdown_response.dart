import 'dart:convert';

SaleDropdownDataResponse saleDropdownDataResponseFromJson(String str) =>
    SaleDropdownDataResponse.fromJson(json.decode(str));

String saleDropdownDataResponseToJson(SaleDropdownDataResponse data) =>
    json.encode(data.toJson());

class SaleDropdownDataResponse {
  String? status;
  String? responseCode;
  String? description;

  List<SaleStatus>? saleStatus;
  List<DdlItem>? saleSource;
  List<DdlItem>? saleBusinessType;
  List<DdlItem>? saleSme;
  List<DdlItem>? saleDesignation;
  List<DdlItem>? division;
  List<DdlItem>? township;
  List<DdlItem>? followupVia;
  List<DdlItem>? discount;
  List<DdlItem>? plan;
  List<PackageItem>? package;
  List<DdlItem>? customerType;

  SaleDropdownDataResponse({
    this.status,
    this.responseCode,
    this.description,
    this.saleStatus,
    this.saleSource,
    this.saleBusinessType,
    this.saleSme,
    this.saleDesignation,
    this.division,
    this.township,
    this.followupVia,
    this.discount,
    this.plan,
    this.package,
    this.customerType,
  });

  factory SaleDropdownDataResponse.fromJson(Map<String, dynamic> json) {
    return SaleDropdownDataResponse(
      status: json["status"]?.toString(),
      responseCode: json["response_code"]?.toString(),
      description: json["description"]?.toString(),

      saleStatus: _list(json["sale_status"], SaleStatus.fromJson),
      saleSource: _list(json["sale_source"], DdlItem.fromJson),
      saleBusinessType: _list(json["sale_business_type"], DdlItem.fromJson),
      saleSme: _list(json["sale_sme"], DdlItem.fromJson),
      saleDesignation: _list(json["sale_designation"], DdlItem.fromJson),
      division: _list(json["division"], DdlItem.fromJson),
      township: _list(json["township"], DdlItem.fromJson),
      followupVia: _list(json["followup_via"], DdlItem.fromJson),
      discount: _list(json["discount"], DdlItem.fromJson),
      plan: _list(json["plan"], DdlItem.fromJson),
      package: _list(json["package"], PackageItem.fromJson),
      customerType: _list(json["customer_type"], DdlItem.fromJson),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "response_code": responseCode,
    "description": description,
    "sale_status": saleStatus?.map((x) => x.toJson()).toList() ?? [],
    "sale_source": saleSource?.map((x) => x.toJson()).toList() ?? [],
    "sale_business_type":
    saleBusinessType?.map((x) => x.toJson()).toList() ?? [],
    "sale_sme": saleSme?.map((x) => x.toJson()).toList() ?? [],
    "sale_designation":
    saleDesignation?.map((x) => x.toJson()).toList() ?? [],
    "division": division?.map((x) => x.toJson()).toList() ?? [],
    "township": township?.map((x) => x.toJson()).toList() ?? [],
    "followup_via": followupVia?.map((x) => x.toJson()).toList() ?? [],
    "discount": discount?.map((x) => x.toJson()).toList() ?? [],
    "plan": plan?.map((x) => x.toJson()).toList() ?? [],
    "package": package?.map((x) => x.toJson()).toList() ?? [],
    "customer_type": customerType?.map((x) => x.toJson()).toList() ?? [],
  };
}

List<T> _list<T>(
    dynamic value,
    T Function(Map<String, dynamic>) fromJson,
    ) {
  if (value == null || value is! List) return [];

  return value
      .whereType<Map>()
      .map((e) => fromJson(Map<String, dynamic>.from(e)))
      .toList();
}

class DdlItem {
  dynamic key;
  String? value;

  DdlItem({
    this.key,
    this.value,
  });

  factory DdlItem.fromJson(Map<String, dynamic> json) {
    return DdlItem(
      key: json["key"],
      value: json["value"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class PackageItem {
  String? key;
  String? value;
  String? plan;

  PackageItem({
    this.key,
    this.value,
    this.plan,
  });

  factory PackageItem.fromJson(Map<String, dynamic> json) {
    return PackageItem(
      key: json["key"]?.toString(),
      value: json["value"]?.toString(),
      plan: json["plan"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
    "plan": plan,
  };
}

class SaleStatus {
  dynamic key;
  String? value;
  String? weight;

  SaleStatus({
    this.key,
    this.value,
    this.weight,
  });

  factory SaleStatus.fromJson(Map<String, dynamic> json) {
    return SaleStatus(
      key: json["key"],
      value: json["value"]?.toString(),
      weight: json["weight"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
    "weight": weight,
  };
}