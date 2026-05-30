///Base Url
// const String kBaseUrl = "https://hrapp.mocinteractive.com/api/v1";
// const String kV2BaseUrl = "https://hrapp.mocinteractive.com/api/v2";

const String kBaseUrl = "https://pipeline.pnpmyanmar.com/api";

const String kImageBaseUrlHttp = "";


///Error image string
const String kErrorImageUrl =
    "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=";

///Test event image url
const String kTestImageUrl = "https://plus.unsplash.com/premium_photo-1725408127758-fb45b0f11ad9?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2Nob29sJTIwZXZlbnR8ZW58MHx8MHx8fDA%3D";

///End points
const String kEndPointLogin = "/sale_admin_login";
const String kEndPointStudentAttendance = "/student/attendance";
const String kEndPointGetParentInfo = "/get-info";
const String kEndPointGetExamDetails = "/exam";
const String kEndPointGetExamList = "/exam";
const String kEndPointStudentReportCardDetail = "/student/report-card";
const String kEndPointGetEventList = "/event";
const String kEndPointGetEventDetail = "/event/";
const String kEndPointSetFcmToken = "/set-fcm-token";
const String kEndPointGetAnnouncements = "/announcement";
const String kEndPointGetSchoolFees = "/fees";
const String kEndPointGetLessonPlans= "/lesson-plan";


///Parameters
const String kParamApiKey = "api_key";
const String kParamLanguage = "language";
const String kParamPage = "page";

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
