
class NotificationData {
  String? apiResponseCode;
  String? apiResponseMsg;
  int? totalRecords;
  int? pageLimit;
  List<Notifications>? notifications;

  NotificationData(
      {required this.apiResponseCode,
        required this.apiResponseMsg,
        required this.totalRecords,
        required this.pageLimit,
        required this.notifications});

  NotificationData.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    totalRecords = json['totalRecords'];
    pageLimit = json['pageLimit'];
    if (json['Notifications'] != null) {
      notifications = <Notifications>[];
      json['Notifications'].forEach((v) {
        notifications?.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    data['totalRecords'] = this.totalRecords;
    data['pageLimit'] = this.pageLimit;
    final notifications = this.notifications;
    if (notifications != null) {
      data['Notifications'] =
          notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? logID;
  String? accountID;
  String? notificationType;
  String? typeValue;
  String? title;
  String? message;
  bool? isRead;
  String? duration;
  String? createdAt;
  UpdatedAt? updatedAt;
  String? status;

  Notifications(
      {required this.logID,
        required this.accountID,
        required this.notificationType,
        required this.typeValue,
        required this.title,
        required this.message,
        required this.isRead,
        required this.duration,
        required this.createdAt,
        required this.updatedAt,
        required this.status});

  Notifications.fromJson(Map<String, dynamic> json) {
    logID = json['logID'];
    accountID = json['accountID'];
    notificationType = json['notificationType'];
    typeValue = json['typeValue'];
    title = json['title'];
    message = json['message'];
    isRead = json['isRead'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = (json['updatedAt'] != null
        ? new UpdatedAt.fromJson(json['updatedAt'])
        : null)!;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logID'] = this.logID;
    data['accountID'] = this.accountID;
    data['notificationType'] = this.notificationType;
    data['typeValue'] = this.typeValue;
    data['title'] = this.title;
    data['message'] = this.message;
    data['isRead'] = this.isRead;
    data['duration'] = this.duration;
    data['createdAt'] = this.createdAt;
    final updatedAt = this.updatedAt;
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class UpdatedAt {
  String? string;
  bool? valid;

  UpdatedAt({required this.string, required this.valid});

  UpdatedAt.fromJson(Map<String, dynamic> json) {
    string = json['String'];
    valid = json['Valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['String'] = this.string;
    data['Valid'] = this.valid;
    return data;
  }
}