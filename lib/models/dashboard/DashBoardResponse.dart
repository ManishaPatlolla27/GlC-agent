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
        farmlandAnalytics!.add(new FarmlandAnalytics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['userEmail'] = this.userEmail;
    data['totalEarnings'] = this.totalEarnings;
    data['totalCredits'] = this.totalCredits;
    data['agentRank'] = this.agentRank;
    if (this.farmlandAnalytics != null) {
      data['farmlandAnalytics'] =
          this.farmlandAnalytics!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['count'] = this.count;
    data['status'] = this.status;
    data['icon'] = this.icon;
    return data;
  }
}
