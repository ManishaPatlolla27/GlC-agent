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
  Null? code;

  StatesList({this.id, this.label, this.code});

  StatesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['code'] = this.code;
    return data;
  }
}
