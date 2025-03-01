class LoginResponse {
  int? userId;
  String? userName;
  String? firstName;
  String? lastName;
  String? userEmail;
  String? mobileNumber;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  int? addressId;
  int? areaId;
  int? regionId;
  int? stateId;
  int? primaryRoleId;
  String? message;

  LoginResponse(
      {this.userId,
      this.userName,
      this.firstName,
      this.lastName,
      this.userEmail,
      this.mobileNumber,
      this.accessToken,
      this.refreshToken,
      this.tokenType,
      this.addressId,
      this.areaId,
      this.regionId,
      this.stateId,
      this.primaryRoleId,
      this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userEmail = json['userEmail'];
    mobileNumber = json['mobileNumber'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    tokenType = json['tokenType'];
    addressId = json['addressId'];
    areaId = json['areaId'];
    regionId = json['regionId'];
    stateId = json['stateId'];
    primaryRoleId = json['primaryRoleId'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userEmail'] = this.userEmail;
    data['mobileNumber'] = this.mobileNumber;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['tokenType'] = this.tokenType;
    data['addressId'] = this.addressId;
    data['areaId'] = this.areaId;
    data['regionId'] = this.regionId;
    data['stateId'] = this.stateId;
    data['primaryRoleId'] = this.primaryRoleId;
    data['message'] = this.message;
    return data;
  }
}
