

class KycPojo {
  String? apiResponseCode;
  String? apiResponseMsg;
  int? totalRecords;
  int? pageLimit;
  List<InventoryDetails>? inventoryDetails;

  KycPojo(
      {this.apiResponseCode,
        this.apiResponseMsg,
        this.totalRecords,
        this.pageLimit,
        this.inventoryDetails});

  KycPojo.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    totalRecords = json['totalRecords'];
    pageLimit = json['pageLimit'];
    if (json['inventoryDetails'] != null) {
      inventoryDetails = <InventoryDetails>[];
      json['inventoryDetails'].forEach((v) {
        inventoryDetails?.add(new InventoryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    data['totalRecords'] = this.totalRecords;
    data['pageLimit'] = this.pageLimit;
    final inventoryDetails = this.inventoryDetails;
    if (inventoryDetails != null) {
      data['inventoryDetails'] =
          inventoryDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InventoryDetails {
  int? simID;
  int? orderID;
  String? orderNumber;
  int? simTypeID;
  AccountID? accountID;
  String? simTypeName;
  int? serviceScopeID;
  String? serviceScopeName;
  int? networkBandID;
  String? networkBandName;
  int? simProfileID;
  String? simProfileName;
  int? primaryNetworkID;
  String? primaryNetworkName;
  AccountID? currentHolder;
  AccountID? currentHolderType;
  AccountID? currentHolderMobileNo;
  SecondaryNetworkID? secondaryNetworkID;
  AccountID? secondaryNetworkName;
  String? currentStatus;
  String? iccidNo;
  AccountID? iccid1;
  AccountID? iccid2;
  AccountID? msisdn1;
  AccountID? msisdn2;
  String? imsi1No;
  AccountID? imsi2No;
  AccountID? rfcBusinessName;
  AccountID? rfcMobileNo;
  SecondaryNetworkID? currentNWID;
  AccountID? currentNetworkName;
  AccountID? pn1ActivationDate;
  AccountID? pn2ActivationDate;
  AccountID? pn1CurrentPackageID;
  AccountID? pn2CurrentPackageID;
  AccountID? pn1ExpireDate;
  AccountID? pn2ExpireDate;
  bool? isSafeCustody;
  AccountID? oemID;
  AccountID? deviceUniqueID;
  AccountID? assetType;
  AccountID? assetUniqueID;
  AccountID? assetValidity;
  AccountID? deviceType;
  AccountID? deviceModel;
  AccountID? ownerName;
  AccountID? ownerMobileNo;
  AccountID? assetModelName;
  AccountID? safeCustodyActivationDate;
  AccountID? installedAt;
  bool? isKyc;
  String? createdAt;
  AccountID? updatedAt;
  String? status;

  InventoryDetails(
      {this.simID,
        this.orderID,
        this.orderNumber,
        this.simTypeID,
        this.accountID,
        this.simTypeName,
        this.serviceScopeID,
        this.serviceScopeName,
        this.networkBandID,
        this.networkBandName,
        this.simProfileID,
        this.simProfileName,
        this.primaryNetworkID,
        this.primaryNetworkName,
        this.currentHolder,
        this.currentHolderType,
        this.currentHolderMobileNo,
        this.secondaryNetworkID,
        this.secondaryNetworkName,
        this.currentStatus,
        this.iccidNo,
        this.iccid1,
        this.iccid2,
        this.msisdn1,
        this.msisdn2,
        this.imsi1No,
        this.imsi2No,
        this.rfcBusinessName,
        this.rfcMobileNo,
        this.currentNWID,
        this.currentNetworkName,
        this.pn1ActivationDate,
        this.pn2ActivationDate,
        this.pn1CurrentPackageID,
        this.pn2CurrentPackageID,
        this.pn1ExpireDate,
        this.pn2ExpireDate,
        this.isSafeCustody,
        this.oemID,
        this.deviceUniqueID,
        this.assetType,
        this.assetUniqueID,
        this.assetValidity,
        this.deviceType,
        this.deviceModel,
        this.ownerName,
        this.ownerMobileNo,
        this.assetModelName,
        this.safeCustodyActivationDate,
        this.installedAt,
        this.isKyc,
        this.createdAt,
        this.updatedAt,
        this.status});

  InventoryDetails.fromJson(Map<String, dynamic> json) {
    simID = json['simID'];
    orderID = json['orderID'];
    orderNumber = json['orderNumber'];
    simTypeID = json['simTypeID'];
    accountID = json['accountID'] != null
        ? new AccountID.fromJson(json['accountID'])
        : null;
    simTypeName = json['simTypeName'];
    serviceScopeID = json['serviceScopeID'];
    serviceScopeName = json['serviceScopeName'];
    networkBandID = json['networkBandID'];
    networkBandName = json['networkBandName'];
    simProfileID = json['simProfileID'];
    simProfileName = json['simProfileName'];
    primaryNetworkID = json['primaryNetworkID'];
    primaryNetworkName = json['primaryNetworkName'];
    currentHolder = json['currentHolder'] != null
        ? new AccountID.fromJson(json['currentHolder'])
        : null;
    currentHolderType = json['currentHolderType'] != null
        ? new AccountID.fromJson(json['currentHolderType'])
        : null;
    currentHolderMobileNo = json['currentHolderMobileNo'] != null
        ? new AccountID.fromJson(json['currentHolderMobileNo'])
        : null;
    secondaryNetworkID = json['secondaryNetworkID'] != null
        ? new SecondaryNetworkID.fromJson(json['secondaryNetworkID'])
        : null;
    secondaryNetworkName = json['secondaryNetworkName'] != null
        ? new AccountID.fromJson(json['secondaryNetworkName'])
        : null;
    currentStatus = json['currentStatus'];
    iccidNo = json['iccidNo'];
    iccid1 = json['iccid_1'] != null
        ? new AccountID.fromJson(json['iccid_1'])
        : null;
    iccid2 = json['iccid_2'] != null
        ? new AccountID.fromJson(json['iccid_2'])
        : null;
    msisdn1 = json['msisdn_1'] != null
        ? new AccountID.fromJson(json['msisdn_1'])
        : null;
    msisdn2 = json['msisdn_2'] != null
        ? new AccountID.fromJson(json['msisdn_2'])
        : null;
    imsi1No = json['imsi1No'];
    imsi2No = json['imsi2No'] != null
        ? new AccountID.fromJson(json['imsi2No'])
        : null;
    rfcBusinessName = json['rfcBusinessName'] != null
        ? new AccountID.fromJson(json['rfcBusinessName'])
        : null;
    rfcMobileNo = json['rfcMobileNo'] != null
        ? new AccountID.fromJson(json['rfcMobileNo'])
        : null;
    currentNWID = json['currentNWID'] != null
        ? new SecondaryNetworkID.fromJson(json['currentNWID'])
        : null;
    currentNetworkName = json['currentNetworkName'] != null
        ? new AccountID.fromJson(json['currentNetworkName'])
        : null;
    pn1ActivationDate = json['pn1ActivationDate'] != null
        ? new AccountID.fromJson(json['pn1ActivationDate'])
        : null;
    pn2ActivationDate = json['pn2ActivationDate'] != null
        ? new AccountID.fromJson(json['pn2ActivationDate'])
        : null;
    pn1CurrentPackageID = (json['pn1CurrentPackageID'] != null
        ? new SecondaryNetworkID.fromJson(json['pn1CurrentPackageID'])
        : null) as AccountID?;
    pn2CurrentPackageID = (json['pn2CurrentPackageID'] != null
        ? new SecondaryNetworkID.fromJson(json['pn2CurrentPackageID'])
        : null) as AccountID?;
    pn1ExpireDate = json['pn1ExpireDate'] != null
        ? new AccountID.fromJson(json['pn1ExpireDate'])
        : null;
    pn2ExpireDate = json['pn2ExpireDate'] != null
        ? new AccountID.fromJson(json['pn2ExpireDate'])
        : null;
    isSafeCustody = json['isSafeCustody'];
    oemID =
    json['oemID'] != null ? new AccountID.fromJson(json['oemID']) : null;
    deviceUniqueID = json['deviceUniqueID'] != null
        ? new AccountID.fromJson(json['deviceUniqueID'])
        : null;
    assetType = json['assetType'] != null
        ? new AccountID.fromJson(json['assetType'])
        : null;
    assetUniqueID = json['assetUniqueID'] != null
        ? new AccountID.fromJson(json['assetUniqueID'])
        : null;
    assetValidity = json['assetValidity'] != null
        ? new AccountID.fromJson(json['assetValidity'])
        : null;
    deviceType = json['deviceType'] != null
        ? new AccountID.fromJson(json['deviceType'])
        : null;
    deviceModel = json['deviceModel'] != null
        ? new AccountID.fromJson(json['deviceModel'])
        : null;
    ownerName = json['ownerName'] != null
        ? new AccountID.fromJson(json['ownerName'])
        : null;
    ownerMobileNo = json['ownerMobileNo'] != null
        ? new AccountID.fromJson(json['ownerMobileNo'])
        : null;
    assetModelName = json['assetModelName'] != null
        ? new AccountID.fromJson(json['assetModelName'])
        : null;
    safeCustodyActivationDate = json['safeCustodyActivationDate'] != null
        ? new AccountID.fromJson(json['safeCustodyActivationDate'])
        : null;
    installedAt = json['installedAt'] != null
        ? new AccountID.fromJson(json['installedAt'])
        : null;
    isKyc = json['isKyc'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'] != null
        ? new AccountID.fromJson(json['updatedAt'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['simID'] = this.simID;
    data['orderID'] = this.orderID;
    data['orderNumber'] = this.orderNumber;
    data['simTypeID'] = this.simTypeID;
    final accountID = this.accountID;
    if (accountID != null) {
      data['accountID'] = accountID.toJson();
    }
    data['simTypeName'] = this.simTypeName;
    data['serviceScopeID'] = this.serviceScopeID;
    data['serviceScopeName'] = this.serviceScopeName;
    data['networkBandID'] = this.networkBandID;
    data['networkBandName'] = this.networkBandName;
    data['simProfileID'] = this.simProfileID;
    data['simProfileName'] = this.simProfileName;
    data['primaryNetworkID'] = this.primaryNetworkID;
    data['primaryNetworkName'] = this.primaryNetworkName;
    final currentHolder = this.currentHolder;
    if (currentHolder != null) {
      data['currentHolder'] = currentHolder.toJson();
    }
    final currentHolderType = this.currentHolderType;
    if (currentHolderType != null) {
      data['currentHolderType'] = currentHolderType.toJson();
    }
    final currentHolderMobileNo = this.currentHolderMobileNo;
    if (currentHolderMobileNo != null) {
      data['currentHolderMobileNo'] = currentHolderMobileNo.toJson();
    }
    final secondaryNetworkID = this.secondaryNetworkID;
    if (secondaryNetworkID != null) {
      data['secondaryNetworkID'] = secondaryNetworkID.toJson();
    }
    final secondaryNetworkName = this.secondaryNetworkName;
    if (secondaryNetworkName != null) {
      data['secondaryNetworkName'] = secondaryNetworkName.toJson();
    }
    data['currentStatus'] = this.currentStatus;
    data['iccidNo'] = this.iccidNo;
    final iccid1 = this.iccid1;
    if (iccid1 != null) {
      data['iccid_1'] = iccid1.toJson();
    }
    final iccid2 = this.iccid2;
    if (iccid2 != null) {
      data['iccid_2'] = iccid2.toJson();
    }
    final msisdn1 = this.msisdn1;
    if (msisdn1 != null) {
      data['msisdn_1'] = msisdn1.toJson();
    }
    final msisdn2 = this.msisdn2;
    if (msisdn2 != null) {
      data['msisdn_2'] = msisdn2.toJson();
    }
    data['imsi1No'] = this.imsi1No;
    final imsi2No = this.imsi2No;
    if (imsi2No != null) {
      data['imsi2No'] = imsi2No.toJson();
    }
    final rfcBusinessName = this.rfcBusinessName;
    if (rfcBusinessName != null) {
      data['rfcBusinessName'] = rfcBusinessName.toJson();
    }
    final rfcMobileNo = this.rfcMobileNo;
    if (rfcMobileNo != null) {
      data['rfcMobileNo'] = rfcMobileNo.toJson();
    }
    final currentNWID = this.currentNWID;
    if (currentNWID != null) {
      data['currentNWID'] = currentNWID.toJson();
    }
    final currentNetworkName = this.currentNetworkName;
    if (currentNetworkName != null) {
      data['currentNetworkName'] = currentNetworkName.toJson();
    }
    final pn1ActivationDate = this.pn1ActivationDate;
    if (pn1ActivationDate != null) {
      data['pn1ActivationDate'] = pn1ActivationDate.toJson();
    }
    final pn2ActivationDate = this.pn2ActivationDate;
    if (pn2ActivationDate != null) {
      data['pn2ActivationDate'] = pn2ActivationDate.toJson();
    }
    final pn1CurrentPackageID = this.pn1CurrentPackageID;
    if (pn1CurrentPackageID != null) {
      data['pn1CurrentPackageID'] = pn1CurrentPackageID.toJson();
    }
    final pn2CurrentPackageID = this.pn2CurrentPackageID;
    if (pn2CurrentPackageID != null) {
      data['pn2CurrentPackageID'] = pn2CurrentPackageID.toJson();
    }
    final pn1ExpireDate = this.pn1ExpireDate;
    if (pn1ExpireDate != null) {
      data['pn1ExpireDate'] = pn1ExpireDate.toJson();
    }
    final pn2ExpireDate = this.pn2ExpireDate;
    if (pn2ExpireDate != null) {
      data['pn2ExpireDate'] = pn2ExpireDate.toJson();
    }
    data['isSafeCustody'] = this.isSafeCustody;
    final oemID = this.oemID;
    if (oemID != null) {
      data['oemID'] = oemID.toJson();
    }
    final deviceUniqueID = this.deviceUniqueID;
    if (deviceUniqueID != null) {
      data['deviceUniqueID'] = deviceUniqueID.toJson();
    }
    final assetType = this.assetType;
    if (assetType != null) {
      data['assetType'] = assetType.toJson();
    }
    final assetUniqueID = this.assetUniqueID;
    if (assetUniqueID != null) {
      data['assetUniqueID'] = assetUniqueID.toJson();
    }
    final assetValidity = this.assetValidity;
    if (assetValidity != null) {
      data['assetValidity'] = assetValidity.toJson();
    }
    final deviceType = this.deviceType;
    if (deviceType != null) {
      data['deviceType'] = deviceType.toJson();
    }
    final deviceModel = this.deviceModel;
    if (deviceModel != null) {
      data['deviceModel'] = deviceModel.toJson();
    }
    final ownerName = this.ownerName;
    if (ownerName != null) {
      data['ownerName'] = ownerName.toJson();
    }
    final ownerMobileNo = this.ownerMobileNo;
    if (ownerMobileNo != null) {
      data['ownerMobileNo'] = ownerMobileNo.toJson();
    }
    final assetModelName = this.assetModelName;
    if (assetModelName != null) {
      data['assetModelName'] = assetModelName.toJson();
    }
    final safeCustodyActivationDate = this.safeCustodyActivationDate;
    if (safeCustodyActivationDate != null) {
      data['safeCustodyActivationDate'] =
          safeCustodyActivationDate.toJson();
    }
    final installedAt = this.installedAt;
    if (installedAt != null) {
      data['installedAt'] = installedAt.toJson();
    }
    data['isKyc'] = this.isKyc;
    data['createdAt'] = this.createdAt;
    final updatedAt = this.updatedAt;
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class AccountID {
  String? string;
  bool? valid;

  AccountID({this.string, this.valid});

  AccountID.fromJson(Map<String, dynamic> json) {
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

class SecondaryNetworkID {
  int? int64;
  bool? valid;

  SecondaryNetworkID({this.int64, this.valid});

  SecondaryNetworkID.fromJson(Map<String, dynamic> json) {
    int64 = json['Int64'];
    valid = json['Valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Int64'] = this.int64;
    data['Valid'] = this.valid;
    return data;
  }
}