class WelcomeScreenResponse {
  String? loginButtonLabel;
  String? guestButtonLabel;
  String? skipLabel;
  List<WelcomeScreens>? welcomeScreens;

  WelcomeScreenResponse(
      {this.loginButtonLabel,
      this.guestButtonLabel,
      this.skipLabel,
      this.welcomeScreens});

  WelcomeScreenResponse.fromJson(Map<String, dynamic> json) {
    loginButtonLabel = json['loginButtonLabel'];
    guestButtonLabel = json['guestButtonLabel'];
    skipLabel = json['skipLabel'];
    if (json['welcomeScreens'] != null) {
      welcomeScreens = <WelcomeScreens>[];
      json['welcomeScreens'].forEach((v) {
        welcomeScreens!.add(WelcomeScreens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginButtonLabel'] = loginButtonLabel;
    data['guestButtonLabel'] = guestButtonLabel;
    data['skipLabel'] = skipLabel;
    if (welcomeScreens != null) {
      data['welcomeScreens'] =
          welcomeScreens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WelcomeScreens {
  String? title;
  String? description;
  String? imageUrl;

  WelcomeScreens({this.title, this.description, this.imageUrl});

  WelcomeScreens.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
