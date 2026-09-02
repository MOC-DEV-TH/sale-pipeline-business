import 'dart:convert';

LeadFormConfigResponse leadFormConfigResponseFromJson(String str) =>
    LeadFormConfigResponse.fromJson(json.decode(str));

String leadFormConfigResponseToJson(LeadFormConfigResponse data) =>
    json.encode(data.toJson());

class LeadFormConfigResponse {
  String? status;
  String? message;
  LeadFormConfigDataVO? data;

  LeadFormConfigResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LeadFormConfigResponse.fromJson(
      Map<String, dynamic> json,
      ) =>
      LeadFormConfigResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : LeadFormConfigDataVO.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LeadFormConfigDataVO {
  List<LeadFormStepVO>? steps;

  LeadFormConfigDataVO({
    this.steps,
  });

  factory LeadFormConfigDataVO.fromJson(
      Map<String, dynamic> json,
      ) =>
      LeadFormConfigDataVO(
        steps: json["steps"] == null
            ? []
            : List<LeadFormStepVO>.from(
          json["steps"].map(
                (x) => LeadFormStepVO.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
    "steps": steps == null
        ? []
        : List<dynamic>.from(
      steps!.map((x) => x.toJson()),
    ),
  };
}

class LeadFormStepVO {
  String? key;
  String? title;
  String? type;
  bool? showSkip;
  List<dynamic>? options;
  List<LeadFormFieldVO>? fields;

  LeadFormStepVO({
    this.key,
    this.title,
    this.type,
    this.showSkip,
    this.options,
    this.fields,
  });

  factory LeadFormStepVO.fromJson(
      Map<String, dynamic> json,
      ) =>
      LeadFormStepVO(
        key: json["key"],
        title: json["title"],
        type: json["type"],
        showSkip: json["show_skip"],
        options: json["options"] == null
            ? []
            : List<dynamic>.from(json["options"]),
        fields: json["fields"] == null
            ? []
            : List<LeadFormFieldVO>.from(
          json["fields"].map(
                (x) => LeadFormFieldVO.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
    "key": key,
    "title": title,
    "type": type,
    "show_skip": showSkip,
    "options": options ?? [],
    "fields": fields == null
        ? []
        : List<dynamic>.from(
      fields!.map((x) => x.toJson()),
    ),
  };
}

class LeadFormFieldVO {
  String? key;
  String? label;
  String? type;
  bool? required;
  bool? multiple;

  /// Can contain:
  /// ["App", "Event", "Website"]
  ///
  /// OR
  ///
  /// [
  ///   {"id": 19, "label": "Allison"},
  ///   {"id": 11, "label": "Anna Myat"}
  /// ]
  List<dynamic>? options;

  LeadFormFieldVO({
    this.key,
    this.label,
    this.type,
    this.required,
    this.multiple,
    this.options,
  });

  factory LeadFormFieldVO.fromJson(
      Map<String, dynamic> json,
      ) =>
      LeadFormFieldVO(
        key: json["key"],
        label: json["label"],
        type: json["type"],
        required: json["required"],
        multiple: json["multiple"],
        options: json["options"] == null
            ? []
            : List<dynamic>.from(json["options"]),
      );

  Map<String, dynamic> toJson() => {
    "key": key,
    "label": label,
    "type": type,
    "required": required,
    "multiple": multiple,
    "options": options ?? [],
  };

  /// Returns dropdown options in a consistent format.
  List<LeadFormOptionVO> get normalizedOptions {
    if (options == null) {
      return [];
    }

    return options!.map((option) {
      /// Example:
      /// "Thailand"
      if (option is String) {
        return LeadFormOptionVO(
          value: option,
          label: option,
        );
      }

      /// Example:
      /// {
      ///   "id": 19,
      ///   "label": "Allison"
      /// }
      if (option is Map) {
        return LeadFormOptionVO(
          id: option["id"],
          value: option["id"]?.toString(),
          label: option["label"]?.toString(),
        );
      }

      return LeadFormOptionVO(
        value: option.toString(),
        label: option.toString(),
      );
    }).toList();
  }
}

class LeadFormOptionVO {
  int? id;
  String? value;
  String? label;

  LeadFormOptionVO({
    this.id,
    this.value,
    this.label,
  });
}