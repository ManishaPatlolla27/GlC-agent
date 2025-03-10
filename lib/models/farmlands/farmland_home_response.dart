class FarmLandHomeResponse {
  final List<FarmLandHomeList> farmlandlist;

  FarmLandHomeResponse({required this.farmlandlist});

  factory FarmLandHomeResponse.fromJson(List<dynamic> json) {
    return FarmLandHomeResponse(
      farmlandlist: json
          .map(
              (item) => FarmLandHomeList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FarmLandHomeList {
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

  FarmLandHomeList(
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

  FarmLandHomeList.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farmlandId'] = this.farmlandId;
    data['farmlandCode'] = this.farmlandCode;
    data['farmlandStatus'] = this.farmlandStatus;
    data['createdOn'] = this.createdOn;
    data['landCost'] = this.landCost;
    data['landLatitude'] = this.landLatitude;
    data['landLongitude'] = this.landLongitude;
    data['stateName'] = this.stateName;
    data['regionName'] = this.regionName;
    data['areaName'] = this.areaName;
    data['agentName'] = this.agentName;
    data['thumbnailImage'] = this.thumbnailImage;
    return data;
  }
}
