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
  String? id;
  String? label;
  String? code;

  CityList({this.id, this.label, this.code});

  CityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['code'] = code;
    return data;
  }
}
