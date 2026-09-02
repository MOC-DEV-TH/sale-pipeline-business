import 'dart:convert';

import 'package:sale_pipeline_business/features/choose_task_page/model/organizations_response.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? status;
  String? message;
  LoginResponseVO? data;

  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : LoginResponseVO.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LoginResponseVO {
  String? token;
  UserVO? user;
  List<OrganizationVO>? organizations;
  int? organizationId;
  String? subdomain;
  String? workspaceUrl;

  LoginResponseVO({
    this.token,
    this.user,
    this.organizations,
    this.organizationId,
    this.subdomain,
    this.workspaceUrl
  });

  factory LoginResponseVO.fromJson(Map<String, dynamic> json) => LoginResponseVO(
    token: json["token"],
    user: json["user"] == null ? null : UserVO.fromJson(json["user"]),
    organizations: json["organizations"] == null ? [] : List<OrganizationVO>.from(json["organizations"]!.map((x) => OrganizationVO.fromJson(x))),
    organizationId: json["organization_id"],
    subdomain: json["subdomain"],
    workspaceUrl: json["workspace_url"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user?.toJson(),
    "organizations": organizations == null ? [] : List<dynamic>.from(organizations!.map((x) => x.toJson())),
    "organization_id": organizationId,
    "subdomain": subdomain,
    "workspace_url": workspaceUrl,
  };
}



class UserVO {
  int? id;
  String? name;
  String? email;
  String? role;
  String? tenantId;

  UserVO({
    this.id,
    this.name,
    this.email,
    this.role,
    this.tenantId,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => UserVO(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    tenantId: json["tenant_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "tenant_id": tenantId,
  };
}