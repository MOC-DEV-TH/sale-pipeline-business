///Base Url
const String kLoginBaseUrl = "https://staging.pipeline.mocinteractive.com/api";

const String kImageBaseUrlHttp = "";


///Error image string
const String kErrorImageUrl =
    "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=";

///Test event image url
const String kTestImageUrl = "https://plus.unsplash.com/premium_photo-1725408127758-fb45b0f11ad9?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2Nob29sJTIwZXZlbnR8ZW58MHx8MHx8fDA%3D";

///End points
const String kEndPointLogin = "/login";
const String kEndPointStudentAttendance = "/student/attendance";
const String kEndPointGetSaleDdlData = "/get_sale_ddl_data";
const String kEndPointSubmitLead = "/leads";
const String kEndPointUpdateLead = "/post_lead_form_data";
const String kEndPointLeadListByUid ="/get_lead_list_by_uid?";
const String kEndPointLeadDetailByLeadId = "/get_activity_detail?";
const String kEndPointContractedLeadListByUid = "/get_contracted_lead_lists_by_uid?";
const String kEndPointContractedLeadByProfileId = "/get_contracted_detail?";
const String kEndPointUpdateContractedLead ="/post_contracted_data";
const String kEndPointGetActivityOverview ="/get_activity_overview_by_uid?";

const String kEndPointGetOrganizations = "/organizations";
const String kEndPointGetReportSummaryByOrganizationID = "/reports/summary";
const String kEndPointGetLeadFormConfigByOrganizationID = "/leads/form-config";
const String kEndPointGetLeadsByOrganizationID = "/leads";




///Parameters
const String kParamApiKey = "api_key";
const kParamUid = '&uid=';
const kParamAppVersion = '&app_version=';
const kParamLeadId = '&leadId=';
const kParamBusinessName = '&business_name=';
const kParamEstContractDate = '&est_contract_date=';
const kParamContactNumber = '&contact_number=';
const kParamStatus = '&status=';
const kParamOrganizationID = "organization_id";
const kParamPage = "page";

///Constant Values
const String kApiKey = "3495fbca2612a77c31afe40405a6a4c4";
const String kLanguageENUS = "en-US";
const String kTypeWfh = "work_from_home";
const String kTypeOffice = "office";
const String kLeaveStatusReject ="reject";
const String kLeaveStatusRejected ="rejected";
const String kLeaveStatusApproved="approved";

const Duration kApiDeadline = Duration(minutes: 1);
const Duration kRetryDelay = Duration(seconds: 3);
