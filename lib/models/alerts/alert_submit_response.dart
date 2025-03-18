class AlertSubmitResponse {
  int? alertId;
  String? alertCode;

  AlertSubmitResponse({this.alertId, this.alertCode});

  AlertSubmitResponse.fromJson(Map<String, dynamic> json) {
    alertId = json['alertId'];
    alertCode = json['alertCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alertId'] = this.alertId;
    data['alertCode'] = this.alertCode;
    return data;
  }
}
