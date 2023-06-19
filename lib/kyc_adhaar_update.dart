import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'demo.dart';
import 'installation_screen/upload_document.dart';
import 'installation_screen/upload_documents_pojo.dart';
import 'navigation_screen/profile/kyc_detail/kyc_pojo.dart';
import 'navigation_screen/profile/kyc_detail/rendor_update.dart';

class KycAdhaar extends StatefulWidget {

   KycAdhaar({Key? key}) : super(key: key);

  @override
  _KycAdhaarState createState() => _KycAdhaarState();
}

class _KycAdhaarState extends State<KycAdhaar> {

  var tcVisibility = false;
  String name = "";
  String apiResponce = "";
  String memeType = "";
  String docID = "";
  var documentId ,id;
  var documentIdUpload ;
  var documentIdArr ;
  File? image;
  List<Documents>? documentList;
  List<UploadedDocuments>? listDocument;
  var response ;
  var delete;
  var isVerified;
  String token = "";
  String accountId = "";
  bool condition = true;
  var documentTypeId ;
  final _picker = ImagePicker();
  var count;
  var account;
  var nam;
  bool _progressBarActive = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () => condition = false);
    Stream.periodic(Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      getUploadType();
      getUploadDocument();
      getUploadDocumentFirst();
      getNotification();
    });
    getToken();
  }

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
        accountId = sharedPreferences.getString('accountId')!;
        response = sharedPreferences.getString('response1');
        docID = sharedPreferences.getString('docId')!;
        isVerified = sharedPreferences.getInt('isVerified');
      });
      return;
    }
  }

  @override
  void didChangeDependencies() {
    getToken();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  //  getUploadType();
  //  getUploadDocument();

  }

  File? imageFile ;
  _openGalery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child:Container(
          decoration: BoxDecoration( boxShadow: [
            BoxShadow(
              color: Color(0x2A000000),
              offset: const Offset(
                0.0,
                1.0,
              ),
              blurRadius: 16.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],),
          child: AppBar(
            title: Text(
              'KYC Detail',
              style: TextStyle(
                  color: Color(0xff2B2B2B),
                  fontSize: 18.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child:  Padding(
                padding: EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  'images/forgot_back.svg',
                  width: 8.0,
                  height: 14.0,
                ),
              ),
            ),
            actions: [
              InkWell (
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Hello()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 18, 5, 8),
                  width: 30,
                  height: 30,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'images/bell_icon.svg',
                        height: 21.0,
                        width: 16.0,
                      ),

                      Container(
                        width: 30,
                        height: 40,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 0,right: 3,bottom: 3),
                        child: Container(
                          width: 20,
                          height: 16,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffff5252),
                              border: Border.all(color: Color(0xffff5252), width: 0)),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Center(
                              child: Text(
                                count.toString(),
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Image.asset('images/notification_appbar.png'),
            ],
            elevation: 0.1,
          ),
        ),
      ),
      body:  Container(
        child: Column(
          children: [
            if (isVerified == 0)...[
              Container(
                child: FutureBuilder<KycDocumentPojo?>(
                    future: getUploadDocument(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<UploadedDocuments>? list =
                            snapshot.data!.uploadedDocuments;
                        return list == null
                            ? SizedBox()
                            : ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              UploadedDocuments upLoad = list[index];
                              documentId = list[index].documentTypeID;
                              delete = list[index].docID;
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
                                height: 260.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0, left: 15.0),
                                          child: Text(
                                            upLoad.documentTypeName.toString(),
                                            style: TextStyle(
                                                color: Color(0xff767D88),
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Inter'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        //width: 345,
                                        color: Color(0xffFCFCFC),
                                        margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 20),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(6),
                                          color: Color(0xffDFE0E6),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(6)),
                                              child: Container(
                                                height: 159.0,
                                                width: MediaQuery.of(context).size.width * 0.85,
                                                margin: EdgeInsets.all(10.0),
                                                child: Image.network(
                                                  upLoad.docUrl.toString(),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Center(
                            child: CircularProgressIndicator());
                      }
                    }),
              ),
            ] else if (isVerified == 1)...[
              Column(
                children: [
                  Container(
                    child: FutureBuilder<UploadDocuments?>(
                        future: getUploadType(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            documentList = snapshot.data?.documents;
                            return documentList == null ? Container()
                                : ListView.builder(
                                shrinkWrap: true,
                                itemCount: documentList?.length,
                                itemBuilder: (context, index) {
                                  Documents documentUpload = documentList![index];
                                  name = documentUpload.documentTypeName.toString();
                                  memeType = documentUpload.mimeTypes.toString();
                                  documentId =documentUpload.documentTypeID;

                                  return imageFile != null ? Image.file(File(imageFile!.path).absolute,
                                    width: MediaQuery.of(context).size.width * 0.95,
                                    fit: BoxFit.fill,
                                    ) : Column(
                                      children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 9.0, left: 15.0, right: 15.0,bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 7.0, left: 15.0),
                                              child: Text(name,
                                                style: TextStyle(
                                                    color: Color(0xff767D88),
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Inter'),
                                              ),
                                            ),
                                            Visibility(
                                              visible: tcVisibility,
                                              child: Container(
                                                margin: EdgeInsets.only(top: 6, left: 15.0, right: 15.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      decoration: new BoxDecoration(
                                                        color: Color(0xffEFF0F2),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(5.0),
                                                        child: SvgPicture.asset(
                                                          "images/edit_icon.svg",
                                                          color: Colors.black26,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.24,
                                        color: Color(0xffFCFCFC),
                                        margin: EdgeInsets.only(top: 00.0, left: 15.0, right: 15.0, bottom: 10.0),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(6),
                                          color: Color(0xffDFE0E6),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                image != null ? Image.file(File(image?.path??"").absolute, width: MediaQuery.of(context).size.width * 0.95,
                                                  fit: BoxFit.fill,) : Container(
                                                  margin: EdgeInsets.only(top: 20.0),
                                                  child: Align(alignment: Alignment.bottomCenter, child: Image.asset('images/earth_aadharr.png')),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 9.0),
                                                  child: Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Text("No document found!", style: TextStyle(color: Color(0xff767D88), fontSize: 15.0, fontFamily: 'Inter', fontWeight: FontWeight.w500),
                                                      )),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 6.0),
                                                  child: Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Text("jpg,jpeg,png",
                                                        style: TextStyle(color: Color(0xff989EA8), fontSize: 11.0, fontFamily: 'Inter', fontWeight: FontWeight.w400),
                                                      )),
                                                ),

                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UploadProfileKyc(account : accountId,nam : name,documentTypeId : documentId)));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(top: 10.0),
                                                    child: Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Container(
                                                        width: 150.0,
                                                        margin: EdgeInsets.only(left: 24.0, right: 24.0),
                                                        height: 32,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xff2B2B2B),
                                                          // border: Border.all(color: Color(0xffACABB3)),
                                                          borderRadius: BorderRadius.circular(
                                                            5.0,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset('images/upload_icon.svg'),
                                                            SizedBox(width: 7.0,),
                                                            Text('Browse Document', style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12.0, fontFamily: 'Inter', fontWeight: FontWeight.w500),),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),


                                      InkWell(
                                        onTap: () {
                                        },
                                        child: Visibility(
                                          visible: tcVisibility,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                                            child: Align(alignment: Alignment.bottomCenter,
                                              child: Container(
                                                width: 165.0,
                                                margin: EdgeInsets.only(left: 24.0, right: 24.0),
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff2B2B2B),
                                                  // border: Border.all(color: Color(0xffACABB3)),
                                                  borderRadius: BorderRadius.circular(5.0,),),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset('images/upload_icon.svg'),
                                                    SizedBox(width: 7.0,),
                                                    Text('Upload Document', style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12.0, fontFamily: 'Inter', fontWeight: FontWeight.w500),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            return Center(
                                child: CircularProgressIndicator(color: Color(0xffFF3E3E3E),));
                          }
                        }),
                  ),

                  Container(
                    child: FutureBuilder<KycDocumentPojo?>(
                        future: getUploadDocument(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            listDocument = snapshot.data?.uploadedDocuments;
                            return listDocument == null ? SizedBox() : ListView.builder(
                              shrinkWrap: true,
                              itemCount: listDocument?.length,
                              itemBuilder: (context, index) {
                                UploadedDocuments upLoad = listDocument![index];
                                id = upLoad.documentTypeID;
                                delete = upLoad.docID;
                                // docuentTypeName=upLoad.documentTypeName;
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.99,
                                  margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
                                  height: 260.0,
                                  child: Column(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0,left: 15.0),
                                            child: Text(
                                              upLoad.documentTypeName.toString(),
                                              style: TextStyle(
                                                  color: Color(0xff767D88),
                                                  fontSize:13.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:10.0,left:15.0,right:15.0),
                                            child: InkWell(
                                              onTap: () {

                                                setState(() {
                                                  getDelete();
                                                });
                                              },
                                              child: Container(
                                                width: 24.0,
                                                height: 24.0,
                                                decoration: new BoxDecoration(
                                                  color: Color(0xffEFF0F2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset("images/cross.svg", color: Colors.black26,),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          //width: 345,
                                          color: Color(0xffFCFCFC),
                                          margin:  EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 20),
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(6),
                                            color: Color(0xffDFE0E6),
                                            child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(6)),
                                                child: Container(
                                                  height: 159.0,
                                                  width: MediaQuery.of(context).size.width * 0.85,
                                                  margin: EdgeInsets.all(10.0),
                                                  child: Image.network(
                                                    upLoad.docUrl.toString(),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),


                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<KycDocumentPojo?> getUploadDocument() async {

    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getUploadedDocuments"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"type": 'DLR', "value": accountId}),
      );
      if (response.statusCode == 200) {
        var res = response.body;
        print(res);
        KycDocumentPojo kycDocumentPojo = KycDocumentPojo.fromJson(json.decode(res));
        return kycDocumentPojo;
      } else {
        print("failed uploadtype data");
      }
    }
  }

  Future<void> getUploadDocumentFirst() async {
    String? value;
    if (value == null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.20.94:8081/Api/uploadDocument'));
      request.headers.addAll({"content-type": "multipart/form_data",
        "accept-encoding": "gzip",
        "Authorization": token,
        "platform": 'mobile_application'});

      request.fields['documentTypeID'] = documentId.toString();
      request.fields['type'] = 'DLR';
      request.fields['value'] = accountId;//"3";

      request.files.add(
        http.MultipartFile.fromBytes("file",
          imageFile!.readAsBytesSync(),
          filename: "test.${imageFile!.path.split(".").last}",
        ),
      );
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final decodedMap = json.decode(responseString);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString('docId',decodedMap['docID']);
          await sharedPreferences.setString('upload',decodedMap['apiResponseMsg']);
        print(decodedMap);

        final stringRes = JsonEncoder.withIndent('').convert(decodedMap);
        print(stringRes);
      } else {
        print("failed uploaddocument");
      }
    }
  }

  Future<UploadDocuments?> getUploadType() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getUnuploadedDocuments"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"type": 'DLR', "value": accountId}),
      );
      if (response.statusCode == 200) {
        var res = response.body;
        print(res);
        UploadDocuments kycDocumentPojo =
        UploadDocuments.fromJson(json.decode(res));
        return kycDocumentPojo;
      } else {
        print("failed uploadtype data");
      }
    }
  }

  Future<String?> getDelete() async {
    String? value;
    if(value==null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/deleteKyc"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token,
          "platform": 'mobile_application'
        },
        body: jsonEncode({
          "docID":delete
        }),
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString()) as Map<String,dynamic>;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString('response1',responseJson['apiResponseMsg']);
        print(responseJson);
        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed uploadtype data");
      }
      return value;
    }
  }


  Future<String?> getNotification() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getNotifications"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"isRead": 'false'
        }),
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);

        setState(() {
          count = int.parse(responseJson['totalRecords'].toString());

        });

        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed");
      }
      return value;
    }
  }
}


