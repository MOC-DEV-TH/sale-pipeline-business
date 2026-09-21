// To parse this JSON data, do
//
//     final leadDetailsResponse = leadDetailsResponseFromJson(jsonString);

import 'dart:convert';

LeadDetailsResponse leadDetailsResponseFromJson(String str) => LeadDetailsResponse.fromJson(json.decode(str));

String leadDetailsResponseToJson(LeadDetailsResponse data) => json.encode(data.toJson());

class LeadDetailsResponse {
  String? status;
  LeadDetailData? data;

  LeadDetailsResponse({
    this.status,
    this.data,
  });

  factory LeadDetailsResponse.fromJson(Map<String, dynamic> json) => LeadDetailsResponse(
    status: json["status"],
    data: json["data"] == null ? null : LeadDetailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class LeadDetailData {
  int? lid;
  String? uuid;
  String? businessName;
  String? firstname;
  String? firstName;
  String? lastName;
  String? contactName;
  String? contactEmail;
  dynamic contactno;
  dynamic phone;
  String? secondaryContactNumber;
  String? bizType;
  String? source;
  String? division;
  String? township;
  String? address;
  String? product;
  String? package;
  String? packageTotal;
  dynamic discount;
  String? note;
  String? status;
  String? channel;
  dynamic installationAppointment;
  DateTime? estContractDate;
  DateTime? estStartDate;
  DateTime? followupDate;
  DateTime? followUpDate;
  DateTime? estFollowUpDate;
  dynamic closedDate;
  bool? isReferral;
  String? meetingNote;
  String? nextStep;
  int? organizationId;
  CustomFields? customFields;
  String? plan;
  int? leadAssign;
  int? createdBy;
  String? createdByName;
  String? uploadedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  CustomFieldsByLabel? customFieldsByLabel;
  FieldsByLabel? fieldsByLabel;
  List<LabeledField>? labeledFields;
  List<Section>? sections;

  LeadDetailData({
    this.lid,
    this.uuid,
    this.businessName,
    this.firstname,
    this.firstName,
    this.lastName,
    this.contactName,
    this.contactEmail,
    this.contactno,
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
    this.closedDate,
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
    this.customFieldsByLabel,
    this.fieldsByLabel,
    this.labeledFields,
    this.sections,
  });

  factory LeadDetailData.fromJson(Map<String, dynamic> json) => LeadDetailData(
    lid: json["lid"],
    uuid: json["uuid"],
    businessName: json["business_name"],
    firstname: json["firstname"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    contactName: json["contact_name"],
    contactEmail: json["contact_email"],
    contactno: json["contactno"],
    phone: json["phone"],
    secondaryContactNumber: json["secondary_contact_number"],
    bizType: json["biz_type"],
    source: json["source"],
    division: json["division"],
    township: json["township"],
    address: json["address"],
    product: json["product"],
    package: json["package"],
    packageTotal: json["package_total"],
    discount: json["discount"],
    note: json["note"],
    status: json["status"],
    channel: json["channel"],
    installationAppointment: json["installation_appointment"],
    estContractDate: json["est_contract_date"] == null ? null : DateTime.parse(json["est_contract_date"]),
    estStartDate: json["est_start_date"] == null ? null : DateTime.parse(json["est_start_date"]),
    followupDate: json["followup_date"] == null ? null : DateTime.parse(json["followup_date"]),
    followUpDate: json["follow_up_date"] == null ? null : DateTime.parse(json["follow_up_date"]),
    estFollowUpDate: json["est_follow_up_date"] == null ? null : DateTime.parse(json["est_follow_up_date"]),
    closedDate: json["closed_date"],
    isReferral: json["is_referral"],
    meetingNote: json["meeting_note"],
    nextStep: json["next_step"],
    organizationId: json["organization_id"],
    customFields: json["custom_fields"] == null ? null : CustomFields.fromJson(json["custom_fields"]),
    plan: json["plan"],
    leadAssign: json["lead_assign"],
    createdBy: json["created_by"],
    createdByName: json["created_by_name"],
    uploadedBy: json["uploaded_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    customFieldsByLabel: json["custom_fields_by_label"] == null ? null : CustomFieldsByLabel.fromJson(json["custom_fields_by_label"]),
    fieldsByLabel: json["fields_by_label"] == null ? null : FieldsByLabel.fromJson(json["fields_by_label"]),
    labeledFields: json["labeled_fields"] == null ? [] : List<LabeledField>.from(json["labeled_fields"]!.map((x) => LabeledField.fromJson(x))),
    sections: json["sections"] == null ? [] : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
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
    "contactno": contactno,
    "phone": phone,
    "secondary_contact_number": secondaryContactNumber,
    "biz_type": bizType,
    "source": source,
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
    "installation_appointment": installationAppointment,
    "est_contract_date": estContractDate == null ? null : "${estContractDate!.year.toString().padLeft(4, '0')}-${estContractDate!.month.toString().padLeft(2, '0')}-${estContractDate!.day.toString().padLeft(2, '0')}",
    "est_start_date": estStartDate == null ? null : "${estStartDate!.year.toString().padLeft(4, '0')}-${estStartDate!.month.toString().padLeft(2, '0')}-${estStartDate!.day.toString().padLeft(2, '0')}",
    "followup_date": followupDate == null ? null : "${followupDate!.year.toString().padLeft(4, '0')}-${followupDate!.month.toString().padLeft(2, '0')}-${followupDate!.day.toString().padLeft(2, '0')}",
    "follow_up_date": followUpDate == null ? null : "${followUpDate!.year.toString().padLeft(4, '0')}-${followUpDate!.month.toString().padLeft(2, '0')}-${followUpDate!.day.toString().padLeft(2, '0')}",
    "est_follow_up_date": estFollowUpDate == null ? null : "${estFollowUpDate!.year.toString().padLeft(4, '0')}-${estFollowUpDate!.month.toString().padLeft(2, '0')}-${estFollowUpDate!.day.toString().padLeft(2, '0')}",
    "closed_date": closedDate,
    "is_referral": isReferral,
    "meeting_note": meetingNote,
    "next_step": nextStep,
    "organization_id": organizationId,
    "custom_fields": customFields?.toJson(),
    "plan": plan,
    "lead_assign": leadAssign,
    "created_by": createdBy,
    "created_by_name": createdByName,
    "uploaded_by": uploadedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "custom_fields_by_label": customFieldsByLabel?.toJson(),
    "fields_by_label": fieldsByLabel?.toJson(),
    "labeled_fields": labeledFields == null ? [] : List<dynamic>.from(labeledFields!.map((x) => x.toJson())),
    "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}

class CustomFields {
  dynamic cfBusinessName;
  dynamic cfName;
  dynamic cfWhoDidYouMeetWith;
  dynamic cfMail;
  dynamic cfSeptember;
  dynamic pfTest;
  dynamic cfTestingPhone;
  dynamic cfTest5;
  dynamic pfTest22;
  dynamic cfTestingAugust;
  dynamic cfAungSoeOo;
  dynamic pfTest4;
  dynamic cfTestingSsso;
  dynamic pfTest66;
  dynamic cfTest7;
  dynamic cfTestSoe;
  dynamic cf8;
  dynamic cf9;
  dynamic pfTesttt88;
  dynamic cf92;

  CustomFields({
    this.cfBusinessName,
    this.cfName,
    this.cfWhoDidYouMeetWith,
    this.cfMail,
    this.cfSeptember,
    this.pfTest,
    this.cfTestingPhone,
    this.cfTest5,
    this.pfTest22,
    this.cfTestingAugust,
    this.cfAungSoeOo,
    this.pfTest4,
    this.cfTestingSsso,
    this.pfTest66,
    this.cfTest7,
    this.cfTestSoe,
    this.cf8,
    this.cf9,
    this.pfTesttt88,
    this.cf92,
  });

  factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields(
    cfBusinessName: json["cf_business_name"],
    cfName: json["cf_name"],
    cfWhoDidYouMeetWith: json["cf_who_did_you_meet_with"],
    cfMail: json["cf_mail"],
    cfSeptember: json["cf_september"],
    pfTest: json["pf_test"],
    cfTestingPhone: json["cf_testing_phone"],
    cfTest5: json["cf_test_5"],
    pfTest22: json["pf_test_22"],
    cfTestingAugust: json["cf_testing_august"],
    cfAungSoeOo: json["cf_aung_soe_oo"],
    pfTest4: json["pf_test_4"],
    cfTestingSsso: json["cf_testing_ssso"],
    pfTest66: json["pf_test_66"],
    cfTest7: json["cf_test_7"],
    cfTestSoe: json["cf_test_soe"],
    cf8: json["cf_8"],
    cf9: json["cf_9"],
    pfTesttt88: json["pf_testtt88"],
    cf92: json["cf_9_2"],
  );

  Map<String, dynamic> toJson() => {
    "cf_business_name": cfBusinessName,
    "cf_name": cfName,
    "cf_who_did_you_meet_with": cfWhoDidYouMeetWith,
    "cf_mail": cfMail,
    "cf_september": cfSeptember,
    "pf_test": pfTest,
    "cf_testing_phone": cfTestingPhone,
    "cf_test_5": cfTest5,
    "pf_test_22": pfTest22,
    "cf_testing_august": cfTestingAugust,
    "cf_aung_soe_oo": cfAungSoeOo,
    "pf_test_4": pfTest4,
    "cf_testing_ssso": cfTestingSsso,
    "pf_test_66": pfTest66,
    "cf_test_7": cfTest7,
    "cf_test_soe": cfTestSoe,
    "cf_8": cf8,
    "cf_9": cf9,
    "pf_testtt88": pfTesttt88,
    "cf_9_2": cf92,
  };
}

class CustomFieldsByLabel {
  dynamic the8;
  dynamic the9;
  dynamic the10;
  dynamic businessName;
  dynamic testingCustomer;
  dynamic whoDidYouMeetWith;
  dynamic mail;
  dynamic september;
  dynamic test1;
  dynamic phoneNumber;
  dynamic test5;
  dynamic test2;
  dynamic testingAugust;
  dynamic aungSoeOo;
  dynamic test4;
  dynamic testingSsso;
  dynamic test65;
  dynamic test7;
  dynamic testSoe;
  dynamic testtt88;

  CustomFieldsByLabel({
    this.the8,
    this.the9,
    this.the10,
    this.businessName,
    this.testingCustomer,
    this.whoDidYouMeetWith,
    this.mail,
    this.september,
    this.test1,
    this.phoneNumber,
    this.test5,
    this.test2,
    this.testingAugust,
    this.aungSoeOo,
    this.test4,
    this.testingSsso,
    this.test65,
    this.test7,
    this.testSoe,
    this.testtt88,
  });

  factory CustomFieldsByLabel.fromJson(Map<String, dynamic> json) => CustomFieldsByLabel(
    the8: json["8"],
    the9: json["9"],
    the10: json["10"],
    businessName: json["Business Name"],
    testingCustomer: json["Testing customer"],
    whoDidYouMeetWith: json["Who did you meet with?"],
    mail: json["mail"],
    september: json["September"],
    test1: json["Test 1"],
    phoneNumber: json["Phone Number"],
    test5: json["test 5"],
    test2: json["test 2"],
    testingAugust: json["testing august"],
    aungSoeOo: json["Aung Soe Oo"],
    test4: json["test 4"],
    testingSsso: json["testing ssso"],
    test65: json["test 65"],
    test7: json["test 7"],
    testSoe: json["Test soe"],
    testtt88: json["Testtt88"],
  );

  Map<String, dynamic> toJson() => {
    "8": the8,
    "9": the9,
    "10": the10,
    "Business Name": businessName,
    "Testing customer": testingCustomer,
    "Who did you meet with?": whoDidYouMeetWith,
    "mail": mail,
    "September": september,
    "Test 1": test1,
    "Phone Number": phoneNumber,
    "test 5": test5,
    "test 2": test2,
    "testing august": testingAugust,
    "Aung Soe Oo": aungSoeOo,
    "test 4": test4,
    "testing ssso": testingSsso,
    "test 65": test65,
    "test 7": test7,
    "Test soe": testSoe,
    "Testtt88": testtt88,
  };
}

class FieldsByLabel {
  dynamic the8;
  dynamic the9;
  dynamic the10;
  String? companyName;
  String? campaign;
  String? customerName;
  String? contactEmail;
  dynamic phoneNumber;
  String? title;
  String? type;
  String? funnelStage;
  String? channel;
  String? country;
  String? address;
  String? paymentStage;
  String? currency;
  String? estimatedRevenue;
  dynamic estimatedProbability;
  String? note;
  String? status;
  String? meetingType;
  dynamic meetingDue;
  DateTime? proposalDue;
  DateTime? startDate;
  DateTime? endDate;
  dynamic closedDate;
  String? meetingNoteParticipantList;
  String? nextStep;
  dynamic businessName;
  dynamic testingCustomer;
  dynamic whoDidYouMeetWith;
  dynamic mail;
  dynamic september;
  dynamic test1;
  dynamic test5;
  dynamic test2;
  dynamic testingAugust;
  dynamic aungSoeOo;
  dynamic test4;
  dynamic testingSsso;
  dynamic test65;
  dynamic test7;
  dynamic testSoe;
  dynamic testtt88;

  FieldsByLabel({
    this.the8,
    this.the9,
    this.the10,
    this.companyName,
    this.campaign,
    this.customerName,
    this.contactEmail,
    this.phoneNumber,
    this.title,
    this.type,
    this.funnelStage,
    this.channel,
    this.country,
    this.address,
    this.paymentStage,
    this.currency,
    this.estimatedRevenue,
    this.estimatedProbability,
    this.note,
    this.status,
    this.meetingType,
    this.meetingDue,
    this.proposalDue,
    this.startDate,
    this.endDate,
    this.closedDate,
    this.meetingNoteParticipantList,
    this.nextStep,
    this.businessName,
    this.testingCustomer,
    this.whoDidYouMeetWith,
    this.mail,
    this.september,
    this.test1,
    this.test5,
    this.test2,
    this.testingAugust,
    this.aungSoeOo,
    this.test4,
    this.testingSsso,
    this.test65,
    this.test7,
    this.testSoe,
    this.testtt88,
  });

  factory FieldsByLabel.fromJson(Map<String, dynamic> json) => FieldsByLabel(
    the8: json["8"],
    the9: json["9"],
    the10: json["10"],
    companyName: json["Company Name"],
    campaign: json["Campaign"],
    customerName: json["Customer Name"],
    contactEmail: json["Contact Email"],
    phoneNumber: json["Phone Number"],
    title: json["Title"],
    type: json["Type"],
    funnelStage: json["Funnel Stage"],
    channel: json["Channel"],
    country: json["Country"],
    address: json["Address"],
    paymentStage: json["Payment Stage"],
    currency: json["Currency"],
    estimatedRevenue: json["Estimated Revenue"],
    estimatedProbability: json["Estimated Probability"],
    note: json["Note"],
    status: json["Status"],
    meetingType: json["Meeting Type"],
    meetingDue: json["Meeting Due"],
    proposalDue: json["Proposal Due"] == null ? null : DateTime.parse(json["Proposal Due"]),
    startDate: json["Start Date"] == null ? null : DateTime.parse(json["Start Date"]),
    endDate: json["End Date"] == null ? null : DateTime.parse(json["End Date"]),
    closedDate: json["Closed Date"],
    meetingNoteParticipantList: json["Meeting Note / Participant List"],
    nextStep: json["Next Step"],
    businessName: json["Business Name"],
    testingCustomer: json["Testing customer"],
    whoDidYouMeetWith: json["Who did you meet with?"],
    mail: json["mail"],
    september: json["September"],
    test1: json["Test 1"],
    test5: json["test 5"],
    test2: json["test 2"],
    testingAugust: json["testing august"],
    aungSoeOo: json["Aung Soe Oo"],
    test4: json["test 4"],
    testingSsso: json["testing ssso"],
    test65: json["test 65"],
    test7: json["test 7"],
    testSoe: json["Test soe"],
    testtt88: json["Testtt88"],
  );

  Map<String, dynamic> toJson() => {
    "8": the8,
    "9": the9,
    "10": the10,
    "Company Name": companyName,
    "Campaign": campaign,
    "Customer Name": customerName,
    "Contact Email": contactEmail,
    "Phone Number": phoneNumber,
    "Title": title,
    "Type": type,
    "Funnel Stage": funnelStage,
    "Channel": channel,
    "Country": country,
    "Address": address,
    "Payment Stage": paymentStage,
    "Currency": currency,
    "Estimated Revenue": estimatedRevenue,
    "Estimated Probability": estimatedProbability,
    "Note": note,
    "Status": status,
    "Meeting Type": meetingType,
    "Meeting Due": meetingDue,
    "Proposal Due": proposalDue == null ? null : "${proposalDue!.year.toString().padLeft(4, '0')}-${proposalDue!.month.toString().padLeft(2, '0')}-${proposalDue!.day.toString().padLeft(2, '0')}",
    "Start Date": startDate == null ? null : "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "End Date": endDate == null ? null : "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "Closed Date": closedDate,
    "Meeting Note / Participant List": meetingNoteParticipantList,
    "Next Step": nextStep,
    "Business Name": businessName,
    "Testing customer": testingCustomer,
    "Who did you meet with?": whoDidYouMeetWith,
    "mail": mail,
    "September": september,
    "Test 1": test1,
    "test 5": test5,
    "test 2": test2,
    "testing august": testingAugust,
    "Aung Soe Oo": aungSoeOo,
    "test 4": test4,
    "testing ssso": testingSsso,
    "test 65": test65,
    "test 7": test7,
    "Test soe": testSoe,
    "Testtt88": testtt88,
  };
}

class LabeledField {
  String? key;
  String? label;
  String? value;
  String? selectedValue;
  List<String>? options;
  String? type;

  LabeledField({
    this.key,
    this.label,
    this.value,
    this.selectedValue,
    this.options,
    this.type,
  });

  factory LabeledField.fromJson(Map<String, dynamic> json) => LabeledField(
    key: json["key"],
    label: json["label"],
    value: json["value"],
    selectedValue: json["selected_value"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "label": label,
    "value": value,
    "selected_value": selectedValue,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "type": type,
  };
}

class Section {
  String? key;
  String? title;
  List<Field>? fields;

  Section({
    this.key,
    this.title,
    this.fields,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    key: json["key"],
    title: json["title"],
    fields: json["fields"] == null ? [] : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "title": title,
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
  };
}

class Field {
  String? key;
  String? label;
  String? type;
  String? value;
  String? display;

  Field({
    this.key,
    this.label,
    this.type,
    this.value,
    this.display,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    key: json["key"],
    label: json["label"],
    type: json["type"],
    value: json["value"],
    display: json["display"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "label": label,
    "type": type,
    "value": value,
    "display": display,
  };
}
