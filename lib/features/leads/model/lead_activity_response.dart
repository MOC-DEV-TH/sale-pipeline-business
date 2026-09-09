import 'dart:convert';

LeadActivityResponse leadActivityResponseFromJson(String str) => LeadActivityResponse.fromJson(json.decode(str));

String leadActivityResponseToJson(LeadActivityResponse data) => json.encode(data.toJson());

class LeadActivityResponse {
  String? status;
  List<LeadActivityVO>? data;

  LeadActivityResponse({
    this.status,
    this.data,
  });

  factory LeadActivityResponse.fromJson(Map<String, dynamic> json) => LeadActivityResponse(
    status: json["status"],
    data: json["data"] == null ? [] : List<LeadActivityVO>.from(json["data"]!.map((x) => LeadActivityVO.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LeadActivityVO {
  int? id;
  int? leadId;
  String? subject;
  String? type;
  DateTime? activityAt;
  String? activityAtLocal;
  List<int>? participantIds;
  List<Participant>? participants;
  String? description;
  bool? sendEmailReminder;
  dynamic reminderSentAt;
  int? createdBy;
  String? creatorName;
  DateTime? createdAt;
  DateTime? updatedAt;

  LeadActivityVO({
    this.id,
    this.leadId,
    this.subject,
    this.type,
    this.activityAt,
    this.activityAtLocal,
    this.participantIds,
    this.participants,
    this.description,
    this.sendEmailReminder,
    this.reminderSentAt,
    this.createdBy,
    this.creatorName,
    this.createdAt,
    this.updatedAt,
  });

  factory LeadActivityVO.fromJson(Map<String, dynamic> json) => LeadActivityVO(
    id: json["id"],
    leadId: json["lead_id"],
    subject: json["subject"],
    type: json["type"],
    activityAt: json["activity_at"] == null ? null : DateTime.parse(json["activity_at"]),
    activityAtLocal: json["activity_at_local"],
    participantIds: json["participant_ids"] == null ? [] : List<int>.from(json["participant_ids"]!.map((x) => x)),
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    description: json["description"],
    sendEmailReminder: json["send_email_reminder"],
    reminderSentAt: json["reminder_sent_at"],
    createdBy: json["created_by"],
    creatorName: json["creator_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "subject": subject,
    "type": type,
    "activity_at": activityAt?.toIso8601String(),
    "activity_at_local": activityAtLocal,
    "participant_ids": participantIds == null ? [] : List<dynamic>.from(participantIds!.map((x) => x)),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "description": description,
    "send_email_reminder": sendEmailReminder,
    "reminder_sent_at": reminderSentAt,
    "created_by": createdBy,
    "creator_name": creatorName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Participant {
  int? id;
  String? name;
  String? email;

  Participant({
    this.id,
    this.name,
    this.email,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
  };
}
