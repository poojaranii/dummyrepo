import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'kyc_pojo.dart';
class KycAdhaarScrren extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<KycAdhaarScrren> {
  String name = "";
  String memeType = "";
  var documentId ;
  String token = "";
  String accountId = "";
  int _radioValue = 0;
  bool condition = true;
  var docuentTypeID ;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => condition = false);
    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      this.getUploadType();
      //this.getUploadDocument();
      this.getUploadDocumentFirst();
    });
    getToken();
    // this.getAssatType();
    // getUploadType();
    // this.getUploadType();

    // Timer.periodic(Duration(seconds: 1), (_) => getAssatType());
  }

  @override
  void didChangeDependencies() {
    getToken();
    getUploadDocument();
    getUploadType();
    getUploadDocumentFirst();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    getUploadType();
    getUploadDocument();
    getUploadDocumentFirst();
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

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
        accountId = sharedPreferences.getString('accountId')!;
        //deviceUniqueId = sharedPreferences.getString('deviceUniqueID');
        //deviceModel = sharedPreferences.getString('deviceModel');
        //deviceType = sharedPreferences.getString('deviceType');
        //assetType = sharedPreferences.getString('assetType');
        //assetUniqueID = sharedPreferences.getString('assetUniqueID');
        //assetModelName = sharedPreferences.getString('assetModelName');
        //ownerName = sharedPreferences.getString('ownerName');
        docuentTypeID = sharedPreferences.getInt('documentTypeId');
        //simID = sharedPreferences.getInt('simID');
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = MediaQuery.of(context).textScaleFactor;
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),

        child: Scaffold(
            // backgroundColor: Color(0xffE5E5E5),
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
                 ],
                ),
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
                    ),),
                actions: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 20, 8),
                    child:SvgPicture.asset('images/bell_icon.svg',height: 21.0,width: 16.0,),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 15, 8),
                    child: SvgPicture.asset('images/message.svg',height: 20.0,width: 20.0,),
                  ),

                  // Image.asset('images/notification_appbar.png'),
                ],
                elevation: 0.1,
              ),
             ),
            ),
            body:Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 18.0),
                      height: 225.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //border: Border.all(color: Color(0xffACABB3)),
                        borderRadius: BorderRadius.circular(
                          6.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x51beccda),
                            offset: const Offset(
                              0.0,
                              2.0,
                            ),
                            blurRadius: 9.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Column(
                        children: [

                        ],
                      )
                    ),








                  ],
                ),
            ),
            ),

    );
  }

  Future<String?> getUploadType() async {
    String? value;
    if(value==null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getDocumentTypes"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({
          "type":'SIM',
        }),
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString()) as Map<String,dynamic>;

        if (['documentTypes'].any((item) => ['uploadedDocuments'].contains(item))) {

        } else {
        }

        if(mounted==true) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setInt('documentTypeId',int.parse(responseJson['documentTypes'][0]['documentTypeID'].toString()));
          setState(() {
            name = responseJson['documentTypes'][0]['name'];
            memeType = responseJson['documentTypes'][0]['mimeTypes'];
            documentId = responseJson['documentTypes'][0]['documentTypeID'];
            // documentId = int.parse(responseJson['documentTypes'][0]['documentTypeID']);
          });
        }
        print(responseJson);
        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed uploadtype data");
      }
      return value;
    }
  }

  Future<KycDocumentPojo?> getUploadDocument() async {
    String? value;
    if(value==null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getUploadedDocuments"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({
          "type":'SIM',
          "value":accountId
        }),
      );
      if (response.statusCode == 200) {
        var res = response.body;
        print(res);
        KycDocumentPojo kycDocumentPojo = KycDocumentPojo.fromJson(json.decode(res));
        return kycDocumentPojo;

       // var responseJson = jsonDecode(response.body.toString()) as Map<String,dynamic>;
        //print(responseJson);
        final stringRes = JsonEncoder.withIndent('').convert(res);
        print(stringRes);
      } else {
        print("failed uploadtype document");
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

      request.fields['documentTypeID'] = docuentTypeID.toString();
      request.fields['type'] = 'SIM';
      request.fields['value'] = accountId;//"3";

      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          imageFile!.readAsBytesSync(),
          filename: "test.${imageFile?.path.split(".").last}",
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
        print("failed uploaddocument");
      }
    }
  }
}
