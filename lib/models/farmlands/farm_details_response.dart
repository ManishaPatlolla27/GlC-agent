class FarmDetailsResponse {
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
  String? thumbnailImage;
  List<String>? farmlandImages;
  List<Features>? features;

  FarmDetailsResponse(
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
      this.thumbnailImage,
      this.farmlandImages,
      this.features});

  FarmDetailsResponse.fromJson(Map<String, dynamic> json) {
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
    thumbnailImage = json['thumbnailImage'];
    farmlandImages = json['farmlandImages'].cast<String>();
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
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
    data['isFavorite'] = isFavorite;
    data['thumbnailImage'] = thumbnailImage;
    data['farmlandImages'] = farmlandImages;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? title;
  List<Details>? details;

  Features({this.title, this.details});

  Features.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? title;
  String? value;

  Details({this.title, this.value});

  Details.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}
