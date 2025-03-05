class FarmLandResponse {
  final List<FarmLandList> farmlandlist;

  FarmLandResponse({required this.farmlandlist});

  factory FarmLandResponse.fromJson(List<dynamic> json) {
    return FarmLandResponse(
      farmlandlist: json
          .map((item) => FarmLandList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FarmLandList {
  int? farmlandId;
  String? farmlandCode;
  String? farmlandStatus;
  String? createdOn;
  int? landCost;
  String? landLatitude;
  String? landLongitude;
  String? stateName;
  String? regionName;
  String? areaName;
  String? agentName;
  String? thumbnailImage;

  FarmLandList(
      {this.farmlandId,
      this.farmlandCode,
      this.farmlandStatus,
      this.createdOn,
      this.landCost,
      this.landLatitude,
      this.landLongitude,
      this.stateName,
      this.regionName,
      this.areaName,
      this.agentName,
      this.thumbnailImage});

  FarmLandList.fromJson(Map<String, dynamic> json) {
    farmlandId = json['farmlandId'];
    farmlandCode = json['farmlandCode'];
    farmlandStatus = json['farmlandStatus'];
    createdOn = json['createdOn'];
    landCost = json['landCost'];
    landLatitude = json['landLatitude'];
    landLongitude = json['landLongitude'];
    stateName = json['stateName'];
    regionName = json['regionName'];
    areaName = json['areaName'];
    agentName = json['agentName'];
    thumbnailImage = json['thumbnailImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farmlandId'] = farmlandId;
    data['farmlandCode'] = farmlandCode;
    data['farmlandStatus'] = farmlandStatus;
    data['createdOn'] = createdOn;
    data['landCost'] = landCost;
    data['landLatitude'] = landLatitude;
    data['landLongitude'] = landLongitude;
    data['stateName'] = stateName;
    data['regionName'] = regionName;
    data['areaName'] = areaName;
    data['agentName'] = agentName;
    data['thumbnailImage'] = thumbnailImage;
    return data;
  }
}
