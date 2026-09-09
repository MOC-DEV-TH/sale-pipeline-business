import 'dart:convert';

LeadReminderResponse leadReminderResponseFromJson(String str) => LeadReminderResponse.fromJson(json.decode(str));

String leadReminderResponseToJson(LeadReminderResponse data) => json.encode(data.toJson());

class LeadReminderResponse {
  String? status;
  List<LeadReminderVO>? data;

  LeadReminderResponse({
    this.status,
    this.data,
  });

  factory LeadReminderResponse.fromJson(Map<String, dynamic> json) => LeadReminderResponse(
    status: json["status"],
    data: json["data"] == null ? [] : List<LeadReminderVO>.from(json["data"]!.map((x) => LeadReminderVO.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LeadReminderVO {
  int? id;
  int? leadId;
  String? note;
  DateTime? remindAt;
  String? remindAtLocal;
  List<int>? participantIds;
  List<Participant>? participants;
  dynamic reminderSentAt;
  bool? isSent;
  int? createdBy;
  String? creatorName;
  DateTime? createdAt;
  DateTime? updatedAt;

  LeadReminderVO({
    this.id,
    this.leadId,
    this.note,
    this.remindAt,
    this.remindAtLocal,
    this.participantIds,
    this.participants,
    this.reminderSentAt,
    this.isSent,
    this.createdBy,
    this.creatorName,
    this.createdAt,
    this.updatedAt,
  });

  factory LeadReminderVO.fromJson(Map<String, dynamic> json) => LeadReminderVO(
    id: json["id"],
    leadId: json["lead_id"],
    note: json["note"],
    remindAt: json["remind_at"] == null ? null : DateTime.parse(json["remind_at"]),
    remindAtLocal: json["remind_at_local"],
    participantIds: json["participant_ids"] == null ? [] : List<int>.from(json["participant_ids"]!.map((x) => x)),
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    reminderSentAt: json["reminder_sent_at"],
    isSent: json["is_sent"],
    createdBy: json["created_by"],
    creatorName: json["creator_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lead_id": leadId,
    "note": note,
    "remind_at": remindAt?.toIso8601String(),
    "remind_at_local": remindAtLocal,
    "participant_ids": participantIds == null ? [] : List<dynamic>.from(participantIds!.map((x) => x)),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "reminder_sent_at": reminderSentAt,
    "is_sent": isSent,
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
