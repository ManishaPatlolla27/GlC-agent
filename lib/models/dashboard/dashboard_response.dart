class DashboardResponse {
  int? userId;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? userEmail;
  int? totalEarnings;
  int? totalCredits;
  int? agentRank;
  List<FarmlandAnalytics>? farmlandAnalytics;

  DashboardResponse(
      {this.userId,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.userEmail,
      this.totalEarnings,
      this.totalCredits,
      this.agentRank,
      this.farmlandAnalytics});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    userEmail = json['userEmail'];
    totalEarnings = json['totalEarnings'];
    totalCredits = json['totalCredits'];
    agentRank = json['agentRank'];
    if (json['farmlandAnalytics'] != null) {
      farmlandAnalytics = <FarmlandAnalytics>[];
      json['farmlandAnalytics'].forEach((v) {
        farmlandAnalytics!.add(FarmlandAnalytics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobileNumber'] = mobileNumber;
    data['userEmail'] = userEmail;
    data['totalEarnings'] = totalEarnings;
    data['totalCredits'] = totalCredits;
    data['agentRank'] = agentRank;
    if (farmlandAnalytics != null) {
      data['farmlandAnalytics'] =
          farmlandAnalytics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmlandAnalytics {
  int? id;
  String? title;
  int? count;
  String? status;
  String? icon;

  FarmlandAnalytics({this.id, this.title, this.count, this.status, this.icon});

  FarmlandAnalytics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    count = json['count'];
    status = json['status'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['count'] = count;
    data['status'] = status;
    data['icon'] = icon;
    return data;
  }
}
