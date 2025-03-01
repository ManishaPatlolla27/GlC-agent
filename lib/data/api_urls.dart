class ApiConstants {
  ApiConstants._();
  static const String baseUrl = "https://devapis.glctesting.com";
  static const String imageurl = "http://13.233.95.196:3000";
  static const String loginUrl = "/api/glc-auth/loginWithPassword";
  static const String forgotpassword =
      "/api/glc-auth/generateAndSendUserOTP?loginId=";
  static const String validateotp = "/api/glc-auth/updateUserPasswordWithOTP";
}
