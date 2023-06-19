

class UploadDocuments {
  String? apiResponseCode;
  String? apiResponseMsg;
  List<Documents>? documents;

  UploadDocuments({required this.apiResponseCode, required this.apiResponseMsg, required this.documents});

  UploadDocuments.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents?.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    final documents = this.documents;
    if (documents != null) {
      data['documents'] = documents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  int? documentTypeID;
  String? documentTypeName;
  String? mimeTypes;
  int? maxSize;
  bool? isRequired;

  Documents(
      {required this.documentTypeID,
        required this.documentTypeName,
        required this.mimeTypes,
        required this.maxSize,
        required this.isRequired});

  Documents.fromJson(Map<String, dynamic> json) {
    documentTypeID = json['documentTypeID'];
    documentTypeName = json['documentTypeName'];
    mimeTypes = json['mimeTypes'];
    maxSize = json['maxSize'];
    isRequired = json['isRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentTypeID'] = this.documentTypeID;
    data['documentTypeName'] = this.documentTypeName;
    data['mimeTypes'] = this.mimeTypes;
    data['maxSize'] = this.maxSize;
    data['isRequired'] = this.isRequired;
    return data;
  }
}