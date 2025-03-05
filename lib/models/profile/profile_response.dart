class ProfileResponse {
  int? userId;
  String? userCode;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? userEmail;
  String? profileImage;
  int? totalEarnings;
  int? totalCredits;
  int? agentRank;

  ProfileResponse(
      {this.userId,
      this.userCode,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.userEmail,
      this.profileImage,
      this.totalEarnings,
      this.totalCredits,
      this.agentRank});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userCode = json['userCode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    userEmail = json['userEmail'];
    profileImage = json['profileImage'];
    totalEarnings = json['totalEarnings'];
    totalCredits = json['totalCredits'];
    agentRank = json['agentRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userCode'] = userCode;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobileNumber'] = mobileNumber;
    data['userEmail'] = userEmail;
    data['profileImage'] = profileImage;
    data['totalEarnings'] = totalEarnings;
    data['totalCredits'] = totalCredits;
    data['agentRank'] = agentRank;
    return data;
  }
}
