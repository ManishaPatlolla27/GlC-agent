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
        welcomeScreens!.add(new WelcomeScreens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginButtonLabel'] = this.loginButtonLabel;
    data['guestButtonLabel'] = this.guestButtonLabel;
    data['skipLabel'] = this.skipLabel;
    if (this.welcomeScreens != null) {
      data['welcomeScreens'] =
          this.welcomeScreens!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
