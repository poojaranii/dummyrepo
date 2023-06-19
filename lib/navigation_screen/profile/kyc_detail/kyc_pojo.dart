

class KycDocumentPojo {
  String? apiResponseCode;
  String? apiResponseMsg;
  List<UploadedDocuments>? uploadedDocuments;

  KycDocumentPojo({required this.apiResponseCode, required this.apiResponseMsg, required this.uploadedDocuments});

  KycDocumentPojo.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    if (json['uploadedDocuments'] != null) {
      uploadedDocuments = <UploadedDocuments>[];
      json['uploadedDocuments'].forEach((v) {
        uploadedDocuments?.add(new UploadedDocuments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    final uploadedDocuments = this.uploadedDocuments;
    if (uploadedDocuments != null) {
      data['uploadedDocuments'] =
          uploadedDocuments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UploadedDocuments {
  String? docID;
  int? documentTypeID;
  String? documentTypeName;
  String? docUrl;
  Null description;

  UploadedDocuments(
      {required this.docID,
        required this.documentTypeID,
        required this.documentTypeName,
        required this.docUrl,
        required this.description});

  UploadedDocuments.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    documentTypeID = json['documentTypeID'];
    documentTypeName = json['documentTypeName'];
    docUrl = json['docUrl'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = this.docID;
    data['documentTypeID'] = this.documentTypeID;
    data['documentTypeName'] = this.documentTypeName;
    data['docUrl'] = this.docUrl;
    data['description'] = this.description;
    return data;
  }
}