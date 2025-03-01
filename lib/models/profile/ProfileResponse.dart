class ProfileResponse {
  int? userId;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? userEmail;
  bool? isActive;
  int? stateId;
  int? areaId;
  int? regionId;
  String? dob;

  ProfileResponse(
      {this.userId,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.userEmail,
      this.isActive,
      this.stateId,
      this.areaId,
      this.regionId,
      this.dob});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    userEmail = json['userEmail'];
    isActive = json['isActive'];
    stateId = json['stateId'];
    areaId = json['areaId'];
    regionId = json['regionId'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['userEmail'] = this.userEmail;
    data['isActive'] = this.isActive;
    data['stateId'] = this.stateId;
    data['areaId'] = this.areaId;
    data['regionId'] = this.regionId;
    data['dob'] = this.dob;
    return data;
  }
}
