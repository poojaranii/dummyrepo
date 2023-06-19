

class UploadPojo {
  String? apiResponseCode;
  String? apiResponseMsg;
  UserDetail? userDetail;

  UploadPojo({required this.apiResponseCode, required this.apiResponseMsg,required this.userDetail});

  UploadPojo.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    userDetail = (json['userDetail'] != null
        ? new UserDetail.fromJson(json['userDetail'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    final userDetail = this.userDetail;
    if (userDetail != null) {
      data['userDetail'] = userDetail.toJson();
    }
    return data;
  }
}

class UserDetail {
  String? userID;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobileNumber;
  ProfileImageURL? profileImageURL;
  ProfileImageURL? userSuspendedTill;
  ProfileImageURL? userSuspendedReason;
  ProfileImageURL? ipList;
  int? isDefault;
  ProfileImageURL? lastLoginAt;
  ProfileImageURL? lastLoginIP;
  ProfileImageURL? deviceInfo;
  String? createdAt;
  ProfileImageURL? updatedAt;
  String? status;

  UserDetail(
      { required this.userID,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.mobileNumber,
        required this.profileImageURL,
        required this.userSuspendedTill,
        required this.userSuspendedReason,
        required this.ipList,
        required this.isDefault,
        required this.lastLoginAt,
        required this.lastLoginIP,
        required this.deviceInfo,
        required this.createdAt,
        required this.updatedAt,
        required this.status});

  UserDetail.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    profileImageURL = (json['profileImageURL'] != null
        ? new ProfileImageURL.fromJson(json['profileImageURL'])
        : null)!;
    userSuspendedTill = (json['userSuspendedTill'] != null
        ? new ProfileImageURL.fromJson(json['userSuspendedTill'])
        : null)!;
    userSuspendedReason = (json['userSuspendedReason'] != null
        ? new ProfileImageURL.fromJson(json['userSuspendedReason'])
        : null)!;
    ipList = (json['ipList'] != null
        ? new ProfileImageURL.fromJson(json['ipList'])
        : null)!;
    isDefault = json['isDefault'];
    lastLoginAt = (json['lastLoginAt'] != null
        ? new ProfileImageURL.fromJson(json['lastLoginAt'])
        : null)!;
    lastLoginIP = (json['lastLoginIP'] != null
        ? new ProfileImageURL.fromJson(json['lastLoginIP'])
        : null)!;
    deviceInfo = (json['deviceInfo'] != null
        ? new ProfileImageURL.fromJson(json['deviceInfo'])
        : null)!;
    createdAt = json['createdAt'];
    updatedAt = (json['updatedAt'] != null
        ? new ProfileImageURL.fromJson(json['updatedAt'])
        : null)!;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    final profileImageURL = this.profileImageURL;
    if (profileImageURL != null) {
      data['profileImageURL'] = profileImageURL.toJson();
    }
    final userSuspendedTill = this.userSuspendedTill;
    if (userSuspendedTill != null) {
      data['userSuspendedTill'] = userSuspendedTill.toJson();
    }
    final userSuspendedReason = this.userSuspendedReason;
    if (userSuspendedReason != null) {
      data['userSuspendedReason'] = userSuspendedReason.toJson();
    }
    final ipList = this.ipList;
    if (ipList != null) {
      data['ipList'] = ipList.toJson();
    }
    data['isDefault'] = this.isDefault;
    final lastLoginAt = this.lastLoginAt;
    if (lastLoginAt != null) {
      data['lastLoginAt'] = lastLoginAt.toJson();
    }
    final lastLoginIP = this.lastLoginIP;
    if (lastLoginIP != null) {
      data['lastLoginIP'] = lastLoginIP.toJson();
    }
    final deviceInfo = this.deviceInfo;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo.toJson();
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

class ProfileImageURL {
  String? string;
  bool? valid;

  ProfileImageURL({required this.string,required this.valid});

  ProfileImageURL.fromJson(Map<String, dynamic> json) {
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