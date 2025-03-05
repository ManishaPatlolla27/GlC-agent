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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farmlandId'] = this.farmlandId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contactNumber'] = this.contactNumber;
    data['contactMail'] = this.contactMail;
    data['dob'] = this.dob;
    data['religion'] = this.religion;
    data['gender'] = this.gender;
    data['landCost'] = this.landCost;
    data['landLatitude'] = this.landLatitude;
    data['landLongitude'] = this.landLongitude;
    return data;
  }
}
