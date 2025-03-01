class UpdatePasswordRequest {
  String? loginId;
  String? password;
  String? oldPassword;
  String? verificationCode;

  UpdatePasswordRequest(
      {this.loginId, this.password, this.oldPassword, this.verificationCode});

  UpdatePasswordRequest.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    password = json['password'];
    oldPassword = json['oldPassword'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginId'] = this.loginId;
    data['password'] = this.password;
    data['oldPassword'] = this.oldPassword;
    data['verificationCode'] = this.verificationCode;
    return data;
  }
}
