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
  String? farmlandCode;
  String? farmlandCreatedOn;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alertId'] = alertId;
    data['alertCode'] = alertCode;
    data['alertStatus'] = alertStatus;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['contactNumber'] = contactNumber;
    data['contactEmail'] = contactEmail;
    data['dob'] = dob;
    data['religion'] = religion;
    data['gender'] = gender;
    data['landCost'] = landCost;
    data['landLatitude'] = landLatitude;
    data['landLongitude'] = landLongitude;
    data['stateName'] = stateName;
    data['regionName'] = regionName;
    data['areaName'] = areaName;
    data['agentName'] = agentName;
    data['created_on'] = createdOn;
    data['farmlandCode'] = farmlandCode;
    data['farmlandCreatedOn'] = farmlandCreatedOn;
    data['thumbnailImage'] = thumbnailImage;
    return data;
  }
}
