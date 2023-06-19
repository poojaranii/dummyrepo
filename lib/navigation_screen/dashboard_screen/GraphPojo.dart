import 'package:flutter/foundation.dart';

class DashBoardModel {
  String? apiResponseCode;
  String? apiResponseMsg;
  List<int>? orders;
  List<int>? installations;
  List<int>? verifiedInstallations;
  List<int>? customers;
  List<int>? expired;
  List<int>? renewals;

  DashBoardModel(
      { this.apiResponseCode,
        this.apiResponseMsg,
        this.orders,
        this.installations,
        this.verifiedInstallations,
        this.customers,
        this.expired,
        this.renewals});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    orders = json['orders'].cast<int>();
    installations = json['installations'].cast<int>();
    verifiedInstallations = json['verifiedInstallations'].cast<int>();
    customers = json['customers'].cast<int>();
    expired = json['expired'].cast<int>();
    renewals = json['renewals'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    data['orders'] = this.orders;
    data['installations'] = this.installations;
    data['verifiedInstallations'] = this.verifiedInstallations;
    data['customers'] = this.customers;
    data['expired'] = this.expired;
    data['renewals'] = this.renewals;
    return data;
  }
}


