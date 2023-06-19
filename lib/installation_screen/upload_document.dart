import 'package:flutter/material.dart';
import 'package:ich/installation_screen/installation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../navigation_screen/profile/kyc_detail/kyc_pojo.dart';
import 'DocumentPojo.dart';
import 'dart:async' show Future;

import 'upload_documents_pojo.dart';

// ignore: must_be_immutable
class UploadFile extends StatefulWidget {
  var documentId;
  Documents list;
  var sim;
   UploadFile({required this.list,this.sim });

  @override
  _UploadFileState createState() => _UploadFileState(list,sim);
}

class _UploadFileState extends State<UploadFile> {
  _UploadFileState(this.list,this.sim);
  Documents list;
  File? imageFile ;
  String token = "";
  var sim;
  String? type;
  String selectionType = '';
  bool typeUpload=true;

  _openGalery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path.toString());
       // getUploadDocumentFirst();
      });
    }
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x2A000000),
                offset: const Offset(
                  0.0,
                  1.0,
                ),
                blurRadius: 16.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: AppBar(
            title: InkWell(
              onTap: () {
               // getUploadDocument();
              },
              child: Text(
              'Upload',
                style: TextStyle(
                    color: Color(0xff2B2B2B),
                    fontSize: 18.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600),
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xffFFFFFF),
            actions: [

              Container(
                margin: EdgeInsets.fromLTRB(0, 18, 12, 0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      getUploadDocumentFirst();
                      getUploadDocument();
                     /* Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InstallationScreen(typeUpload: true,sim: sim)));*/
                      Navigator.pop(context, true);
                     /* Navigator.of(context).push(new MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) {
                          return  InstallationScreen(typeUpload: true,sim: sim);
                        },
                      ));*/
                    // Navigator.pop(context,imageFile);
                      //Navigator.of(context).pop({selectionType:'Hello'});
                     /* Map results = await Navigator.of(context).push(new MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) {
                          return InstallationScreen();
                        },
                      )) as Map;

                      if (results != null && results.containsKey('imageFile')) {
                        setState(() {
                          _selection = results['imageFile'];
                          print('minzo' +_selection);
                        });
                      }*/
                      //Navigator.of(context).pop(imageFile);

                    });
                  },
                  child:Text(
                    "Save",
                    style: TextStyle(
                        color: Color(0xff2B2B2B),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0),
                  ),
                ),
              ), // Image.asset('images/notification_appbar.png'),
            ],
            elevation: 0.1,
          ),
        ),
      ),

      body: Column(
        children: [
            Container(
              child:Column(
                children: [
                  Container(
                    margin:  EdgeInsets.only(
                        top: 9.0,
                        left: 15.0,
                        right: 15.0,
                        bottom: 10.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 7.0, left: 15.0),
                          child: Text(
                           list.documentTypeName.toString(),
                            style: TextStyle(
                                color: Color(0xff767D88),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter'),
                          ),
                        ),

                          Container(
                            margin: EdgeInsets.only(top: 6,
                                left: 15.0, right: 15.0),
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: new BoxDecoration(
                                    color: Color(0xffEFF0F2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        //  getUploadDocumentFirst();
                                        // getUploadDocument();
                                      });
                                      //   getUploadDocumentFirst();
                                      _openGalery(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: SvgPicture.asset(
                                        "images/edit_icon.svg",
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    // width: 318.0,
                    color: Color(0xffFCFCFC),
                    margin: const EdgeInsets.only(
                        top: 00.0,
                        left: 15.0,
                        right: 15.0,
                        bottom: 10.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(6),
                      color: Color(0xffDFE0E6),
                      child:ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                      child: imageFile != null
                          ? Image.file(
                              File(imageFile!.path).absolute,
                              width: MediaQuery.of(context).size.width * 0.95,
                              fit: BoxFit.fill,
                            )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20.0),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Image.asset('images/earth_aadharr.png')),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 9.0),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "No document found!",
                                      style: TextStyle(
                                          color: Color(0xff767D88),
                                          fontSize: 15.0,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 6.0),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                     list.mimeTypes.toString(),
                                      style: TextStyle(
                                          color: Color(0xff989EA8),
                                          fontSize: 11.0,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),

                              InkWell(
                                onTap: (){
                                  setState(() {
                                    _openGalery(context);
                                    setState(() {
                                      //      tcVisibility = true;
                                    });
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: 150.0,
                                      margin: EdgeInsets.only(
                                          left: 24.0, right: 24.0),
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xff420098),
                                        // border: Border.all(color: Color(0xffACABB3)),
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('images/upload_icon.svg'),
                                          SizedBox(width: 7.0,),
                                          Text(
                                            'Upload Document',
                                            style: TextStyle(
                                                color: Color(0xffFFFFFF),
                                                fontSize: 12.0,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500),
                                          ),
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
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> getUploadDocumentFirst() async {
    String? value;
    if (value == null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.20.94:8081/Api/uploadDocument'));
      request.headers.addAll({
        "content-type": "multipart/form_data",
        "accept-encoding": "gzip",
        "Authorization": token,
        "platform": 'mobile_application'
      });
      request.fields['documentTypeID'] = list.documentTypeID.toString();//docuentTypeID.toString();
      request.fields['type'] = 'SIM';
      request.fields['value'] =sim;
      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          imageFile!.readAsBytesSync(),
          filename: "test.${imageFile!.path.split(".").last}",
          // contentType: MediaType(
          //     "image", "${image.path.split(".").last}"),
        ),
      );
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final decodedMap = json.decode(responseString);
        print(decodedMap);
        final stringRes = JsonEncoder.withIndent('').convert(decodedMap);
        print(stringRes);
      } else {
        print("failed");
      }
    }
  }

  Future<KycDocumentPojo?> getUploadDocument() async {
    // return  await this._memoizer1.runOnce(() async {
    //  await Future.delayed(Duration(seconds: 1));
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getUploadedDocuments"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"type": 'SIM', "value": sim}),
      );
      if (response.statusCode == 200) {
        var res = response.body;
        print(res);
        KycDocumentPojo kycDocumentPojo =
        KycDocumentPojo.fromJson(json.decode(res));
        return kycDocumentPojo;
      } else {
        print("failed uploadtype data");
      }
    }
  }

}
