class LoginRequest {
  String? loginId;
  String? passCode;

  LoginRequest({this.loginId, this.passCode});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    passCode = json['passCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginId'] = loginId;
    data['passCode'] = passCode;
    return data;
  }
}
