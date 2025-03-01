class BottomList {
  final List<BottomResponse> bottomlist;

  BottomList({required this.bottomlist});

  factory BottomList.fromJson(List<dynamic> json) {
    return BottomList(
      bottomlist: json
          .map((item) => BottomResponse.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BottomResponse {
  int? id;
  String? menuTitle;
  String? menuIcon;
  String? selectedIcon;

  BottomResponse({this.id, this.menuTitle, this.menuIcon, this.selectedIcon});

  BottomResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuTitle = json['menuTitle'];
    menuIcon = json['menuIcon'];
    selectedIcon = json['selectedIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menuTitle'] = this.menuTitle;
    data['menuIcon'] = this.menuIcon;
    data['selectedIcon'] = this.selectedIcon;
    return data;
  }
}
