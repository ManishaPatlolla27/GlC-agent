class StatesResponse {
  final List<StatesList> stateslist;

  StatesResponse({required this.stateslist});

  factory StatesResponse.fromJson(List<dynamic> json) {
    return StatesResponse(
      stateslist: json
          .map((item) => StatesList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class StatesList {
  String? id;
  String? label;
  String? code;

  StatesList({this.id, this.label, this.code});

  StatesList.fromJson(Map<String, dynamic> json) {
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
