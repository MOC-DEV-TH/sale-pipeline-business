import 'dart:convert';

ParticipantsResponse participantsResponseFromJson(String str) =>
    ParticipantsResponse.fromJson(json.decode(str));

String participantsResponseToJson(ParticipantsResponse data) =>
    json.encode(data.toJson());

class ParticipantsResponse {
  String? status;
  List<ParticipantVO>? data;

  ParticipantsResponse({this.status, this.data});

  factory ParticipantsResponse.fromJson(Map<String, dynamic> json) =>
      ParticipantsResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ParticipantVO>.from(
                json["data"]!.map((x) => ParticipantVO.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ParticipantVO {
  int? id;
  String? name;
  String? email;
  List<int>? organizationIds;
  dynamic managerId;

  ParticipantVO({
    this.id,
    this.name,
    this.email,
    this.organizationIds,
    this.managerId,
  });

  factory ParticipantVO.fromJson(Map<String, dynamic> json) => ParticipantVO(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    organizationIds: json["organization_ids"] == null
        ? []
        : List<int>.from(json["organization_ids"]!.map((x) => x)),
    managerId: json["manager_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "organization_ids": organizationIds == null
        ? []
        : List<dynamic>.from(organizationIds!.map((x) => x)),
    "manager_id": managerId,
  };
}
