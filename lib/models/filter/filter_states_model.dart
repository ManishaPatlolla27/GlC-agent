class FilterStateResponse {
  List<FilterStateModel>? stateList;

  FilterStateResponse({this.stateList});

  FilterStateResponse.fromJson(List<dynamic> jsonList) {
    stateList =
        jsonList.map((json) => FilterStateModel.fromJson(json)).toList();
  }

  List<Map<String, dynamic>> toJson() {
    return stateList?.map((item) => item.toJson()).toList() ?? [];
  }
}

class FilterStateModel {
  String? id;
  String? label;
  String? code;

  FilterStateModel({this.id, this.label, this.code});

  FilterStateModel.fromJson(Map<String, dynamic> json) {
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
