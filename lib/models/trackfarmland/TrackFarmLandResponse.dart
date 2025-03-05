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
        statusTrack!.add(new StatusTrack.fromJson(v));
      });
    }
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
    data['farmlandImages'] = this.farmlandImages;
    data['liveInWebSite'] = this.liveInWebSite;
    if (this.statusTrack != null) {
      data['statusTrack'] = this.statusTrack!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['status'] = this.status;
    data['statusColorCode'] = this.statusColorCode;
    return data;
  }
}
