class SimilarRequest {
  int? farmlandId;
  int? regionId;
  int? areaId;
  int? priceRangeFrom;
  int? priceRangeTo;

  SimilarRequest(
      {this.farmlandId,
      this.regionId,
      this.areaId,
      this.priceRangeFrom,
      this.priceRangeTo});

  SimilarRequest.fromJson(Map<String, dynamic> json) {
    farmlandId = json['farmlandId'];
    regionId = json['regionId'];
    areaId = json['areaId'];
    priceRangeFrom = json['priceRangeFrom'];
    priceRangeTo = json['priceRangeTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farmlandId'] = this.farmlandId;
    data['regionId'] = this.regionId;
    data['areaId'] = this.areaId;
    data['priceRangeFrom'] = this.priceRangeFrom;
    data['priceRangeTo'] = this.priceRangeTo;
    return data;
  }
}
