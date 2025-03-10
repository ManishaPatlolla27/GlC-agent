class NotificationResponse {
  final List<NotificationList> notificationlist;

  NotificationResponse({required this.notificationlist});

  factory NotificationResponse.fromJson(List<dynamic> json) {
    return NotificationResponse(
      notificationlist: json
          .map(
              (item) => NotificationList.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class NotificationList {
  String? title;
  String? message;
  String? notifiedOn;
  String? imageUrl;

  NotificationList({this.title, this.message, this.notifiedOn, this.imageUrl});

  NotificationList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    notifiedOn = json['notifiedOn'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    data['notifiedOn'] = notifiedOn;
    data['image_url'] = imageUrl;
    return data;
  }
}
