class FavouriteResponse {
  final List<FavList> favlist;

  FavouriteResponse({required this.favlist});

  factory FavouriteResponse.fromJson(List<dynamic> json) {
    return FavouriteResponse(
      favlist: json
          .map((item) => FavList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FavList {
  int? farmlandId;
  String? farmlandCode;
  String? farmlandStatus;
  String? createdOn;
  int? landCost;
  String? landLatitude;
  String? landLongitude;
  String? stateName;
  String? regionName;
  bool? isFavorite;
  String? thumbnailImage;

  FavList(
      {this.farmlandId,
      this.farmlandCode,
      this.farmlandStatus,
      this.createdOn,
      this.landCost,
      this.landLatitude,
      this.landLongitude,
      this.stateName,
      this.regionName,
      this.isFavorite,
      this.thumbnailImage});

  FavList.fromJson(Map<String, dynamic> json) {
    farmlandId = json['farmlandId'];
    farmlandCode = json['farmlandCode'];
    farmlandStatus = json['farmlandStatus'];
    createdOn = json['createdOn'];
    landCost = json['landCost'];
    landLatitude = json['landLatitude'];
    landLongitude = json['landLongitude'];
    stateName = json['stateName'];
    regionName = json['regionName'];
    isFavorite = json['isFavorite'];
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
    data['isFavorite'] = isFavorite;
    data['thumbnailImage'] = thumbnailImage;
    return data;
  }
}
