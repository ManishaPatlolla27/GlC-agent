class BuyerAlertRequest {
  int? farmlandId;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? contactMail;
  String? religion;
  String? gender;
  int? landCost;

  BuyerAlertRequest(
      {this.farmlandId,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.contactMail,
      this.religion,
      this.gender,
      this.landCost});

  BuyerAlertRequest.fromJson(Map<String, dynamic> json) {
    farmlandId = json['farmlandId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contactNumber = json['contactNumber'];
    contactMail = json['contactMail'];
    religion = json['religion'];
    gender = json['gender'];
    landCost = json['landCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farmlandId'] = farmlandId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['contactNumber'] = contactNumber;
    data['contactMail'] = contactMail;
    data['religion'] = religion;
    data['gender'] = gender;
    data['landCost'] = landCost;
    return data;
  }
}
