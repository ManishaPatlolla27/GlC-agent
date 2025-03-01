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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userEmail'] = userEmail;
    data['mobileNumber'] = mobileNumber;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['tokenType'] = tokenType;
    data['addressId'] = addressId;
    data['areaId'] = areaId;
    data['regionId'] = regionId;
    data['stateId'] = stateId;
    data['primaryRoleId'] = primaryRoleId;
    data['message'] = message;
    return data;
  }
}
