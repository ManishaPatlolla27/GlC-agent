class CityResponse {
  final List<CityList> citylist;

  CityResponse({required this.citylist});

  factory CityResponse.fromJson(List<dynamic> json) {
    return CityResponse(
      citylist: json
          .map((item) => CityList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CityList {
  String? regionName;
  String? regionStatus;
  String? subRegionTags;
  int? stateId;
  int? regionId;
  String? createdOn;
  String? stateName;

  CityList(
      {this.regionName,
      this.regionStatus,
      this.subRegionTags,
      this.stateId,
      this.regionId,
      this.createdOn,
      this.stateName});

  CityList.fromJson(Map<String, dynamic> json) {
    regionName = json['region_name'];
    regionStatus = json['region_status'];
    subRegionTags = json['sub_region_tags'];
    stateId = json['state_id'];
    regionId = json['region_id'];
    createdOn = json['created_on'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_name'] = this.regionName;
    data['region_status'] = this.regionStatus;
    data['sub_region_tags'] = this.subRegionTags;
    data['state_id'] = this.stateId;
    data['region_id'] = this.regionId;
    data['created_on'] = this.createdOn;
    data['state_name'] = this.stateName;
    return data;
  }
}
