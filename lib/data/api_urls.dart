class ApiConstants {
  ApiConstants._();
  static const String baseUrl = "https://devapis.glctesting.com";
  static const String imageurl = "http://13.233.95.196:3000";
  static const String loginUrl = "/api/glc-auth/loginWithPassword";
  static const String forgotpassword =
      "/api/glc-auth/generateAndSendUserOTP?loginId=";
  static const String validateotp = "/api/glc-auth/verifyOTP";
  static const String changepassword =
      "/api/glc-auth/updateUserPasswordWithOTP";
  static const String profile = "/lms-api/agent/getMyProfileDetails";
  static const String dashboard = "/lms-api/agent/getMyAnalytics";
  static const String bottom = "/lms-api/agent/getBottomBarMenu";
  static const String welcome = "/api/glc-utils/getWelcomeScreens";
  static const String profilemenu = "/lms-api/agent/getProfileMenu";
  static const String alerts = "/lms-api/agent-farmland/getMyFarmlandAlerts";
  static const String configApi = "/api/glc-utils/getAppResources";
  static const String getEndPoints = "/api/glc-utils/getApiEndpoints";
  static const String createAlert =
      "/lms-api/agent-farmland/createFarmlandAlert";
  static const String similar = "/lms-api/agent-farmland/similarFarmlands";
  static const String fav = "/lms-api/agent-farmland/getMyFavoriteFarmlands";

  static const String createBuyerAlert =
      "lms-api/agent-farmland/sendFarmlandLeads";
  static const String filterStateApi = "/mdm-api/filters/states";
}
