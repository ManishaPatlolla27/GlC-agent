class TrackFarmlandResponse {
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
  List<String>? farmlandImages;
  bool? liveInWebSite;
  List<StatusTrack>? statusTrack;

  TrackFarmlandResponse(
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
      this.thumbnailImage,
      this.farmlandImages,
      this.liveInWebSite,
      this.statusTrack});

  TrackFarmlandResponse.fromJson(Map<String, dynamic> json) {
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
    farmlandImages = json['farmlandImages'].cast<String>();
    liveInWebSite = json['liveInWebSite'];
    if (json['statusTrack'] != null) {
      statusTrack = <StatusTrack>[];
      json['statusTrack'].forEach((v) {
        statusTrack!.add(StatusTrack.fromJson(v));
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
    data['thumbnailImage'] = thumbnailImage;
    data['farmlandImages'] = farmlandImages;
    data['liveInWebSite'] = liveInWebSite;
    if (statusTrack != null) {
      data['statusTrack'] = statusTrack!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusTrack {
  String? title;
  String? status;
  String? statusColorCode;

  StatusTrack({this.title, this.status, this.statusColorCode});

  StatusTrack.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    status = json['status'];
    statusColorCode = json['statusColorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['status'] = status;
    data['statusColorCode'] = statusColorCode;
    return data;
  }
}
