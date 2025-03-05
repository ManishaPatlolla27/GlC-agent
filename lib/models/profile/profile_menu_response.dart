class Profilemenuresponse {
  final List<ProfileMenuList> bottomlist;

  Profilemenuresponse({required this.bottomlist});

  factory Profilemenuresponse.fromJson(List<dynamic> json) {
    return Profilemenuresponse(
      bottomlist: json
          .map((item) => ProfileMenuList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProfileMenuList {
  int? id;
  String? menuTitle;
  String? menuIcon;
  String? selectedIcon;

  ProfileMenuList({this.id, this.menuTitle, this.menuIcon, this.selectedIcon});

  ProfileMenuList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuTitle = json['menuTitle'];
    menuIcon = json['menuIcon'];
    selectedIcon = json['selectedIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['menuTitle'] = menuTitle;
    data['menuIcon'] = menuIcon;
    data['selectedIcon'] = selectedIcon;
    return data;
  }
}
