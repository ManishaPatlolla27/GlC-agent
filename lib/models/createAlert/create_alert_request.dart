class CreateAlertRequest {
  String? farmlandId;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? contactMail;
  String? dob;
  String? religion;
  String? gender;
  String? landCost;
  String? landLatitude;
  String? landLongitude;

  CreateAlertRequest(
      {this.farmlandId,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.contactMail,
      this.dob,
      this.religion,
      this.gender,
      this.landCost,
      this.landLatitude,
      this.landLongitude});

  CreateAlertRequest.fromJson(Map<String, dynamic> json) {
    farmlandId = json['farmlandId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contactNumber = json['contactNumber'];
    contactMail = json['contactMail'];
    dob = json['dob'];
    religion = json['religion'];
    gender = json['gender'];
    landCost = json['landCost'];
    landLatitude = json['landLatitude'];
    landLongitude = json['landLongitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farmlandId'] = farmlandId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['contactNumber'] = contactNumber;
    data['contactMail'] = contactMail;
    data['dob'] = dob;
    data['religion'] = religion;
    data['gender'] = gender;
    data['landCost'] = landCost;
    data['landLatitude'] = landLatitude;
    data['landLongitude'] = landLongitude;
    return data;
  }
}
