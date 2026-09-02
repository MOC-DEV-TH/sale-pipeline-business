import 'dart:convert';

OrganizationsResponse organizationsResponseFromJson(String str) =>
    OrganizationsResponse.fromJson(json.decode(str));

String organizationsResponseToJson(OrganizationsResponse data) =>
    json.encode(data.toJson());

class OrganizationsResponse {
  String? status;
  Data? data;

  OrganizationsResponse({this.status, this.data});

  factory OrganizationsResponse.fromJson(Map<String, dynamic> json) =>
      OrganizationsResponse(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data?.toJson()};
}

class Data {
  List<OrganizationVO>? organizations;

  Data({this.organizations});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    organizations: json["organizations"] == null
        ? []
        : List<OrganizationVO>.from(
            json["organizations"]!.map((x) => OrganizationVO.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "organizations": organizations == null
        ? []
        : List<dynamic>.from(organizations!.map((x) => x.toJson())),
  };
}

class OrganizationVO {
  int? id;
  String? name;

  OrganizationVO({this.id, this.name});

  factory OrganizationVO.fromJson(Map<String, dynamic> json) =>
      OrganizationVO(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
