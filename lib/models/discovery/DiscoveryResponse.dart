class DiscoveryResponse {
  final List<DiscoveryList> bottomlist;

  DiscoveryResponse({required this.bottomlist});

  factory DiscoveryResponse.fromJson(List<dynamic> json) {
    return DiscoveryResponse(
      bottomlist: json
          .map((item) => DiscoveryList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DiscoveryList {
  String? title;
  String? code;
  String? label;
  List<FarmlandsList2>? farmlands;

  DiscoveryList({this.title, this.code, this.label, this.farmlands});

  DiscoveryList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    code = json['code'];
    label = json['label'];
    if (json['farmlands'] != null) {
      farmlands = <FarmlandsList2>[];
      json['farmlands'].forEach((v) {
        farmlands!.add(new FarmlandsList2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['code'] = this.code;
    data['label'] = this.label;
    if (this.farmlands != null) {
      data['farmlands'] = this.farmlands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmlandsList2 {
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
  bool? isFavorite;
  List<String>? cropTypes;
  String? promotionLabel;
  String? thumbnailImage;

  FarmlandsList2(
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
      this.isFavorite,
      this.cropTypes,
      this.promotionLabel,
      this.thumbnailImage});

  FarmlandsList2.fromJson(Map<String, dynamic> json) {
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
    isFavorite = json['isFavorite'];
    cropTypes = json['cropTypes'].cast<String>();
    promotionLabel = json['promotionLabel'];
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
    data['isFavorite'] = this.isFavorite;
    data['cropTypes'] = this.cropTypes;
    data['promotionLabel'] = this.promotionLabel;
    data['thumbnailImage'] = this.thumbnailImage;
    return data;
  }
}
