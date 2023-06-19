
class DocumentTypePojo {
  String? apiResponseCode;
  String? apiResponseMsg;
  List<DocumentTypes>? documentTypes;

  DocumentTypePojo(
      {required this.apiResponseCode, required this.apiResponseMsg, required this.documentTypes});

  DocumentTypePojo.fromJson(Map<String, dynamic> json) {
    apiResponseCode = json['apiResponseCode'];
    apiResponseMsg = json['apiResponseMsg'];
    if (json['documentTypes'] != null) {
      documentTypes = <DocumentTypes>[];
      json['documentTypes'].forEach((v) {
        documentTypes?.add(new DocumentTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiResponseCode'] = this.apiResponseCode;
    data['apiResponseMsg'] = this.apiResponseMsg;
    final documentTypes = this.documentTypes;
    if (documentTypes != null) {
      data['documentTypes'] =
          documentTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentTypes {
  int? documentTypeID;
  String? name;
  String? mimeTypes;
  int? maxSize;
  bool? isRequired;

  DocumentTypes(
      {required this.documentTypeID,
        required this.name,
        required this.mimeTypes,
        required this.maxSize,
        required this.isRequired});

  DocumentTypes.fromJson(Map<String, dynamic> json) {
    documentTypeID = json['documentTypeID'];
    name = json['name'];
    mimeTypes = json['mimeTypes'];
    maxSize = json['maxSize'];
    isRequired = json['isRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentTypeID'] = this.documentTypeID;
    data['name'] = this.name;
    data['mimeTypes'] = this.mimeTypes;
    data['maxSize'] = this.maxSize;
    data['isRequired'] = this.isRequired;
    return data;
  }
}