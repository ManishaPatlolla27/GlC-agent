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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userCode'] = this.userCode;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['userEmail'] = this.userEmail;
    data['profileImage'] = this.profileImage;
    data['totalEarnings'] = this.totalEarnings;
    data['totalCredits'] = this.totalCredits;
    data['agentRank'] = this.agentRank;
    return data;
  }
}
