

class TicketPojo {
  String? apiResponseCode;
  String? apiResponseMsg;
  List<String>? ticketTypes;

  TicketPojo({ this.apiResponseCode, this.apiResponseMsg, this.ticketTypes});

  TicketPojo.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    ticketTypes = json['ticketTypes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    data['ticketTypes'] = this.ticketTypes;
    return data;
  }
}