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
  String? agentName;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leadId'] = leadId;
    data['leadCode'] = leadCode;
    data['leadStatus'] = leadStatus;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['contactNumber'] = contactNumber;
    data['contactEmail'] = contactEmail;
    data['religion'] = religion;
    data['gender'] = gender;
    data['landCost'] = landCost;
    data['farmlandId'] = farmlandId;
    data['createdOn'] = createdOn;
    data['stateName'] = stateName;
    data['regionName'] = regionName;
    data['areaName'] = areaName;
    data['agentName'] = agentName;
    data['isFavorite'] = isFavorite;
    data['thumbnailImage'] = thumbnailImage;
    return data;
  }
}
