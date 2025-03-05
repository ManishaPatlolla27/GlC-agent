class AlertsResponse {
  final List<AlertsList> alertlist;

  AlertsResponse({required this.alertlist});

  factory AlertsResponse.fromJson(List<dynamic> json) {
    return AlertsResponse(
      alertlist: json
          .map((item) => AlertsList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AlertsList {
  int? alertId;
  String? alertCode;
  String? alertStatus;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? contactEmail;
  String? dob;
  String? religion;
  String? gender;
  int? landCost;
  String? landLatitude;
  String? landLongitude;
  String? stateName;
  String? regionName;
  String? areaName;
  String? agentName;
  String? createdOn;
  Null? farmlandCode;
  Null? farmlandCreatedOn;
  String? thumbnailImage;

  AlertsList(
      {this.alertId,
      this.alertCode,
      this.alertStatus,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.contactEmail,
      this.dob,
      this.religion,
      this.gender,
      this.landCost,
      this.landLatitude,
      this.landLongitude,
      this.stateName,
      this.regionName,
      this.areaName,
      this.agentName,
      this.createdOn,
      this.farmlandCode,
      this.farmlandCreatedOn,
      this.thumbnailImage});

  AlertsList.fromJson(Map<String, dynamic> json) {
    alertId = json['alertId'];
    alertCode = json['alertCode'];
    alertStatus = json['alertStatus'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contactNumber = json['contactNumber'];
    contactEmail = json['contactEmail'];
    dob = json['dob'];
    religion = json['religion'];
    gender = json['gender'];
    landCost = json['landCost'];
    landLatitude = json['landLatitude'];
    landLongitude = json['landLongitude'];
    stateName = json['stateName'];
    regionName = json['regionName'];
    areaName = json['areaName'];
    agentName = json['agentName'];
    createdOn = json['created_on'];
    farmlandCode = json['farmlandCode'];
    farmlandCreatedOn = json['farmlandCreatedOn'];
    thumbnailImage = json['thumbnailImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alertId'] = this.alertId;
    data['alertCode'] = this.alertCode;
    data['alertStatus'] = this.alertStatus;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contactNumber'] = this.contactNumber;
    data['contactEmail'] = this.contactEmail;
    data['dob'] = this.dob;
    data['religion'] = this.religion;
    data['gender'] = this.gender;
    data['landCost'] = this.landCost;
    data['landLatitude'] = this.landLatitude;
    data['landLongitude'] = this.landLongitude;
    data['stateName'] = this.stateName;
    data['regionName'] = this.regionName;
    data['areaName'] = this.areaName;
    data['agentName'] = this.agentName;
    data['created_on'] = this.createdOn;
    data['farmlandCode'] = this.farmlandCode;
    data['farmlandCreatedOn'] = this.farmlandCreatedOn;
    data['thumbnailImage'] = this.thumbnailImage;
    return data;
  }
}
