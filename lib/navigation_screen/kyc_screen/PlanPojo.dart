

class PlanPojo {
  String? apiResponseCode;
  String? apiResponseMsg;
  ImsiDetail? imsiDetail;

  PlanPojo({required this.apiResponseCode, required this.apiResponseMsg, required this.imsiDetail});

  PlanPojo.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    imsiDetail = (json['imsiDetail'] != null
        ? new ImsiDetail.fromJson(json['imsiDetail'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    final imsiDetail = this.imsiDetail;
    if (imsiDetail != null) {
      data['imsiDetail'] = imsiDetail.toJson();
    }
    return data;
  }
}

class ImsiDetail {
  int? networkID;
  String? networkName;
  String? iccid;
  String? msisdn;
  int? packageID;
  String? packageName;
  ActivationDate? activationDate;
  ActivationDate? expiryDate;
  ActivationDate? description;
  int? billingCycle;
  int? amount;

  ImsiDetail(
      {this.networkID,
        this.networkName,
        this.iccid,
        this.msisdn,
        this.packageID,
        this.packageName,
        this.activationDate,
        this.expiryDate,
        this.description,
        this.billingCycle,
        this.amount});

  ImsiDetail.fromJson(Map<String, dynamic> json) {
    networkID = json['networkID'];
    networkName = json['networkName'];
    iccid = json['iccid'];
    msisdn = json['msisdn'];
    packageID = json['packageID'];
    packageName = json['packageName'];
    activationDate = json['activationDate'] != null
        ? new ActivationDate.fromJson(json['activationDate'])
        : null;
    expiryDate = json['expiryDate'] != null
        ? new ActivationDate.fromJson(json['expiryDate'])
        : null;
    description = json['description'] != null
        ? new ActivationDate.fromJson(json['description'])
        : null;
    billingCycle = json['billingCycle'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['networkID'] = this.networkID;
    data['networkName'] = this.networkName;
    data['iccid'] = this.iccid;
    data['msisdn'] = this.msisdn;
    data['packageID'] = this.packageID;
    data['packageName'] = this.packageName;
    final activationDate = this.activationDate;
    if (activationDate != null) {
      data['activationDate'] = activationDate.toJson();
    }
    final expiryDate = this.expiryDate;
    if (expiryDate != null) {
      data['expiryDate'] = expiryDate.toJson();
    }
    final description = this.description;
    if (description != null) {
      data['description'] = description.toJson();
    }
    data['billingCycle'] = this.billingCycle;
    data['amount'] = this.amount;
    return data;
  }
}

class ActivationDate {
  String? string;
  bool? valid;

  ActivationDate({this.string, this.valid});

  ActivationDate.fromJson(Map<String, dynamic> json) {
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