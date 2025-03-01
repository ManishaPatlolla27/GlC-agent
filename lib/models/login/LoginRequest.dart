class LoginRequest {
  String? loginId;
  String? passCode;

  LoginRequest({this.loginId, this.passCode});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    passCode = json['passCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginId'] = this.loginId;
    data['passCode'] = this.passCode;
    return data;
  }
}
