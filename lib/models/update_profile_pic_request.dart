class UpdateProfilePicRequest {
  final int userId;
  final String imageFile;
  UpdateProfilePicRequest({required this.userId, required this.imageFile});
  factory UpdateProfilePicRequest.fromJson(Map<String, dynamic> json) {
    return UpdateProfilePicRequest(
      userId: json['user_id'],
      imageFile: json['image_file'], // Convert path back to File
    );
  }

  /// Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "image_file": imageFile, // Store only the file path
    };
  }
}
