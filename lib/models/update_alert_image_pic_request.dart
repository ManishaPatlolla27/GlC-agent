class UpdateAlertPicRequest {
  final int alertId;
  final String imageFile;
  UpdateAlertPicRequest({required this.alertId, required this.imageFile});
  factory UpdateAlertPicRequest.fromJson(Map<String, dynamic> json) {
    return UpdateAlertPicRequest(
      alertId: json['alert_id'],
      imageFile: json['file'], // Convert path back to File
    );
  }

  /// Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      "alert_id": alertId,
      "file": imageFile, // Store only the file path
    };
  }
}
