

class MessagePojo {
  String? apiResponseCode;
  String? apiResponseMsg;
  int? totalRecords;
  int? pageLimit;
  List<TicketActivities>? ticketActivities;

  MessagePojo(
      {this.apiResponseCode,
        this.apiResponseMsg,
        this.totalRecords,
        this.pageLimit,
        this.ticketActivities});

  MessagePojo.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    totalRecords = json['totalRecords'];
    pageLimit = json['pageLimit'];
    if (json['ticketActivities'] != null) {
      ticketActivities = <TicketActivities>[];
      json['ticketActivities'].forEach((v) {
        ticketActivities?.add(new TicketActivities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    data['totalRecords'] = this.totalRecords;
    data['pageLimit'] = this.pageLimit;
    final ticketActivities = this.ticketActivities;
    if (ticketActivities != null) {
      data['ticketActivities'] =
          ticketActivities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketActivities {
  int? ticketActivitiesID;
  int? ticketID;
  String? message;
  String? currentStatus;
  String? createdAt;
  String? createdBy;
  String? createdByName;
  String? createdByImage;
  UpdatedAt? updatedAt;
  String? status;
  UpdatedAt? attachment;

  TicketActivities(
      {this.ticketActivitiesID,
        this.ticketID,
        this.message,
        this.currentStatus,
        this.createdAt,
        this.createdBy,
        this.createdByName,
        this.createdByImage,
        this.updatedAt,
        this.status,
        this.attachment});

  TicketActivities.fromJson(Map<String, dynamic> json) {
    ticketActivitiesID = json['ticketActivitiesID'];
    ticketID = json['ticketID'];
    message = json['message'];
    currentStatus = json['currentStatus'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    createdByName = json['createdByName'];
    createdByImage = json['createdByImage'];
    updatedAt = json['updatedAt'] != null
        ? new UpdatedAt.fromJson(json['updatedAt'])
        : null;
    status = json['status'];
    attachment = json['attachment'] != null
        ? new UpdatedAt.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketActivitiesID'] = this.ticketActivitiesID;
    data['ticketID'] = this.ticketID;
    data['message'] = this.message;
    data['currentStatus'] = this.currentStatus;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['createdByName'] = this.createdByName;
    data['createdByImage'] = this.createdByImage;
    final updatedAt = this.updatedAt;
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt.toJson();
    }
    data['status'] = this.status;
    final attachment = this.attachment;
    if (attachment != null) {
      data['attachment'] = attachment.toJson();
    }
    return data;
  }
}

class UpdatedAt {
  String? string;
  bool? valid;

  UpdatedAt({this.string, this.valid});

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