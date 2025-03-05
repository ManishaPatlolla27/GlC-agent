class FarmLandLeadsResponse {
  final List<FarmLandLeadList> farmlandleadslist;

  FarmLandLeadsResponse({required this.farmlandleadslist});

  factory FarmLandLeadsResponse.fromJson(List<dynamic> json) {
    return FarmLandLeadsResponse(
      farmlandleadslist: json
          .map(
              (item) => FarmLandLeadList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FarmLandLeadList {
  int? leadId;
  String? leadCode;
  String? leadStatus;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? contactEmail;
  String? religion;
  String? gender;
  int? landCost;
  int? farmlandId;
  String? createdOn;
  String? stateName;
  String? regionName;
  String? areaName;
  Null? agentName;
  bool? isFavorite;
  String? thumbnailImage;

  FarmLandLeadList(
      {this.leadId,
      this.leadCode,
      this.leadStatus,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.contactEmail,
      this.religion,
      this.gender,
      this.landCost,
      this.farmlandId,
      this.createdOn,
      this.stateName,
      this.regionName,
      this.areaName,
      this.agentName,
      this.isFavorite,
      this.thumbnailImage});

  FarmLandLeadList.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    leadCode = json['leadCode'];
    leadStatus = json['leadStatus'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contactNumber = json['contactNumber'];
    contactEmail = json['contactEmail'];
    religion = json['religion'];
    gender = json['gender'];
    landCost = json['landCost'];
    farmlandId = json['farmlandId'];
    createdOn = json['createdOn'];
    stateName = json['stateName'];
    regionName = json['regionName'];
    areaName = json['areaName'];
    agentName = json['agentName'];
    isFavorite = json['isFavorite'];
    thumbnailImage = json['thumbnailImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leadId'] = this.leadId;
    data['leadCode'] = this.leadCode;
    data['leadStatus'] = this.leadStatus;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contactNumber'] = this.contactNumber;
    data['contactEmail'] = this.contactEmail;
    data['religion'] = this.religion;
    data['gender'] = this.gender;
    data['landCost'] = this.landCost;
    data['farmlandId'] = this.farmlandId;
    data['createdOn'] = this.createdOn;
    data['stateName'] = this.stateName;
    data['regionName'] = this.regionName;
    data['areaName'] = this.areaName;
    data['agentName'] = this.agentName;
    data['isFavorite'] = this.isFavorite;
    data['thumbnailImage'] = this.thumbnailImage;
    return data;
  }
}
