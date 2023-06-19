
class ComplaintPojo {
  String? apiResponseCode;
  String? apiResponseMsg;
  int? totalRecords;
  int? pageLimit;
  List<Tickets>? tickets;

  ComplaintPojo(
      {this.apiResponseCode,
        this.apiResponseMsg,
        this.totalRecords,
        this.pageLimit,
        this.tickets});

  ComplaintPojo.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    totalRecords = json['totalRecords'];
    pageLimit = json['pageLimit'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets?.add(new Tickets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    data['totalRecords'] = this.totalRecords;
    data['pageLimit'] = this.pageLimit;
    final tickets = this.tickets;
    if (tickets != null) {
      data['tickets'] = tickets.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tickets {
  int? ticketID;
  String? ticketNumber;
  String? ticketType;
  String? title;
  Description? description;
  Description? feedback;
  String? accountName;
  Description? assignTo;
  Description? assignToName;
  String? createdBy;
  String? createdByName;
  String? createdByImage;
  String? createdAt;
  Description? updatedAt;
  String? status;
  String? currentStatus;
  String? priority;
  String? attachments;

  Tickets(
      {this.ticketID,
        this.ticketNumber,
        this.ticketType,
        this.title,
        this.description,
        this.feedback,
        this.accountName,
        this.assignTo,
        this.assignToName,
        this.createdBy,
        this.createdByName,
        this.createdByImage,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.currentStatus,
        this.priority,
        this.attachments});

  Tickets.fromJson(Map<String, dynamic> json) {
    ticketID = json['ticketID'];
    ticketNumber = json['ticketNumber'];
    ticketType = json['ticketType'];
    title = json['title'];
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    feedback = json['feedback'] != null
        ? new Description.fromJson(json['feedback'])
        : null;
    accountName = json['accountName'];
    assignTo = json['assignTo'] != null
        ? new Description.fromJson(json['assignTo'])
        : null;
    assignToName = json['assignToName'] != null
        ? new Description.fromJson(json['assignToName'])
        : null;
    createdBy = json['createdBy'];
    createdByName = json['createdByName'];
    createdByImage = json['createdByImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'] != null
        ? new Description.fromJson(json['updatedAt'])
        : null;
    status = json['status'];
    currentStatus = json['currentStatus'];
    priority = json['priority'];
    attachments = json['attachments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketID'] = this.ticketID;
    data['ticketNumber'] = this.ticketNumber;
    data['ticketType'] = this.ticketType;
    data['title'] = this.title;
    final description = this.description;
    if (description != null) {
      data['description'] = description.toJson();
    }
    final feedback = this.feedback;
    if (feedback != null) {
      data['feedback'] = feedback.toJson();
    }
    data['accountName'] = this.accountName;
    final assignTo = this.assignTo;
    if (assignTo != null) {
      data['assignTo'] = assignTo.toJson();
    }
    final assignToName = this.assignToName;
    if (assignToName != null) {
      data['assignToName'] = assignToName.toJson();
    }
    data['createdBy'] = this.createdBy;
    data['createdByName'] = this.createdByName;
    data['createdByImage'] = this.createdByImage;
    data['createdAt'] = this.createdAt;
    final updatedAt = this.updatedAt;
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt.toJson();
    }
    data['status'] = this.status;
    data['currentStatus'] = this.currentStatus;
    data['priority'] = this.priority;
    data['attachments'] = this.attachments;
    return data;
  }
}

class Description {
  String? string;
  bool? valid;

  Description({this.string, this.valid});

  Description.fromJson(Map<String, dynamic> json) {
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