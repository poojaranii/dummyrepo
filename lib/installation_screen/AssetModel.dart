
class AssetsDetails {
  String? apiResponseCode;
  String? apiResponseMsg;
  int? totalRecords;
  int? pageLimit;
  List<AssetTypes>? assetTypes;

  AssetsDetails(
      {this.apiResponseCode,
        this.apiResponseMsg,
        this.totalRecords,
        this.pageLimit,
        this.assetTypes});

  AssetsDetails.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    totalRecords = json['totalRecords'];
    pageLimit = json['pageLimit'];
    if (json['assetTypes'] != null) {
      assetTypes = <AssetTypes>[];
      json['assetTypes'].forEach((v) {
        assetTypes?.add(new AssetTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    data['totalRecords'] = this.totalRecords;
    data['pageLimit'] = this.pageLimit;
    final assetTypes = this.assetTypes;
    if (assetTypes != null) {
      data['assetTypes'] = assetTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssetTypes {
  int? assetTypeID;
  String? name;
  String? shortCode;
  Description? description;
  String? createdAt;
  Description? updatedAt;
  String? status;

  AssetTypes(
      {this.assetTypeID,
        this.name,
        this.shortCode,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.status});

  AssetTypes.fromJson(Map<String, dynamic> json) {
    assetTypeID = json['assetTypeID'];
    name = json['name'];
    shortCode = json['shortCode'];
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'] != null
        ? new Description.fromJson(json['updatedAt'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetTypeID'] = this.assetTypeID;
    data['name'] = this.name;
    data['shortCode'] = this.shortCode;
    final description = this.description;
    if (description != null) {
      data['description'] = description.toJson();
    }
    data['createdAt'] = this.createdAt;
    final updatedAt = this.updatedAt;
    if (updatedAt != null) {
      data['updatedAt'] = updatedAt.toJson();
    }
    data['status'] = this.status;
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