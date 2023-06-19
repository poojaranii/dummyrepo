import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../demo.dart';
import '../navigation_screen/profile/kyc_detail/kyc_pojo.dart';
import 'installation_screen/DocumentPojo.dart';

class DemoClass extends StatefulWidget {
  const DemoClass({Key? key}) : super(key: key);

  @override
  _DemoClassState createState() => _DemoClassState();
}

class _DemoClassState extends State<DemoClass> {
  AsyncMemoizer? _memoizer;
  AsyncMemoizer? _memoizer1;
  AsyncMemoizer? _memoizer2;
  String token = "";
  File? imageFile ;
  bool condition = true;
  var isPreview = false;
  String name = "";
  String memeType = "";
  var isBlank = true;
  var  documentId;
  var documentIdUpload;
  var delete;
  String? currentItem;
  var tcVisibility=false;
  var block = false;
  var pos;
  var docuentTypeID;
  late List<DocumentTypes> list;
  var kycBool = true;
   Future<void>? fetchData;

  _openGalery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path.toString());
        getUploadDocumentFirst();
       // isBlank=false;
       // isPreview=true;
      });

    }
  }

  @override
  void initState() {
    _memoizer = AsyncMemoizer();
    _memoizer1 = AsyncMemoizer();
    _memoizer2 = AsyncMemoizer();
    fetchData = getUploadType();
    super.initState();

    Future.delayed(const Duration(seconds: 5), () => condition = false);
    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      getUploadDocument();
      this.getUploadType();

    });
    getToken();
  }

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
        docuentTypeID = sharedPreferences.getInt('documentTypeId');
        //simID = sharedPreferences.getInt('simID');
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

            centerTitle: true,
            backgroundColor: Color(0xffFFFFFF),
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  'images/forgot_back.svg',
                  width: 8.0,
                  height: 14.0,
                ),
              ),
            ),
            actions: [


              // Image.asset('images/notification_appbar.png'),
            ],
            elevation: 0.1,
          ),
        ),
      ),

      body: Container(
        child: Column(
          children: [
            Visibility(
              visible: kycBool,
              child: Column(
                children: [

                    Visibility(
                      visible:isBlank,
                      child: Container(
                        child: FutureBuilder<DocumentPojo>(
                            future:getUploadType(),
                            builder: (context ,snapshot){
                              if (snapshot.hasData) {
                                 list = snapshot.data!.documentTypes!;
                                return  list == null
                                    ? Container() : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: list?.length ,
                                    itemBuilder: (context, index) {

                                      DocumentTypes upLoad = list[index];
                                      name=list[index].name.toString();
                                      documentId=list[index].documentTypeID;
                                      memeType=list[index].mimeTypes.toString();
                                      pos=list[index].maxSize;

                                      return  Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 9.0,
                                                left: 15.0,
                                                right: 15.0,
                                                bottom: 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 7.0, left: 15.0),
                                                  child: Text(
                                                    upLoad.name.toString(),
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
                                                              if(index == 0){
                                                                setState(() {
                                                                  //  getUploadDocumentFirst();
                                                                  // getUploadDocument();
                                                                });
                                                                print('editImage' + index.toString());
                                                                //   getUploadDocumentFirst();
                                                                _openGalery(context);
                                                              }

                                                              if(index == 1){
                                                                setState(() {
                                                                  //   getUploadDocumentFirst();
                                                                  //  getUploadDocument();
                                                                });
                                                                print('editImage' + index.toString());
                                                                //   getUploadDocumentFirst();
                                                                _openGalery(context);
                                                              }
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
                                                child:Column(
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
                                                            upLoad.mimeTypes.toString(),
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

                                                           // _openGalery(context);
                                                       //     print('positionNumber' + index.toString());
                                                            setState(() {
                                                              print('browsedocumentflutter' +   [index].toString());
                                                            //  getUploadDocument();
                                                            //  tcVisibility = true;
                                                            //  isPreview=true;
                                                             // isBlank=false;
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
                                                              color: Color(0xff2B2B2B),
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
                                                                SizedBox(
                                                                  width: 7.0,
                                                                ),
                                                                Text(
                                                                  'Browse Document',
                                                                  style: TextStyle(
                                                                      color: Color(0xffFFFFFF),
                                                                      fontSize: 12.0,
                                                                      fontFamily: 'Inter',
                                                                      fontWeight: FontWeight.w500),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),),
                                            ),
                                          ),

                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                              //  tcVisibility = true;
                                             //   getUploadDocument();
                                             //   print('tcVisibility' + index.toString());
                                             //   block=true;
                                             //   kycBool=false;
                                              });
                                            },
                                            child: Visibility(
                                              visible: tcVisibility,
                                              child: Container(
                                                margin: EdgeInsets.only(top: 5.0,bottom: 10.0),
                                                child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Container(
                                                    width: 165.0,
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
                                                        SizedBox(
                                                          width: 7.0,
                                                        ),
                                                        Text('Upload Document!!',
                                                          style: TextStyle(
                                                              color: Color(0xffFFFFFF),
                                                              fontSize: 12.0,
                                                              fontFamily: 'Inter',
                                                              fontWeight: FontWeight.w500),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),


                                        ],
                                      );
                                    }
                                );
                              }else {
                                return Center(child: CircularProgressIndicator());
                              }
                            }
                        ),



                      ),
                    ),

                    Visibility(
                      visible: isPreview,
                      child:   Container(
                        child:Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 9.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(top: 7.0, left: 15.0),
                                    child: Text(
                                      name,
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
                                      margin: EdgeInsets.only(top: 6,
                                          left: 15.0, right: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  ),


                                ],
                              ),),

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
                                    child: imageFile != null ? Image.file(File(imageFile!.path).absolute,width: MediaQuery.of(context).size.width * 0.95,fit: BoxFit.fill,):
                                    Column(
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
                                                memeType,
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
                                                  color: Color(0xff2B2B2B),
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                setState(() {
                                //  tcVisibility = true;
                                  getUploadDocument();
                                //  block=true;
                                //  kycBool=false;

                                });
                              },
                              child: Visibility(
                                visible: tcVisibility,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5.0,bottom: 10.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: 165.0,
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
                                          SizedBox(width: 7.0,
                                          ),
                                          Text('Browse Document',
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
                            ),
                          ],
                        ),



                      ),
                    ),

                ],
              ),
            ),
            Visibility(
              visible: block,
              child: Container(
                child: FutureBuilder<KycDocumentPojo?>(
                    future:getUploadDocument(),
                    builder: (context ,snapshot){
                      if (snapshot.hasData) {
                        List<UploadedDocuments> list = snapshot.data!.uploadedDocuments!.toList();
                        return list == null ? SizedBox(): ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              UploadedDocuments upLoad = list[index];
                              documentId=upLoad.documentTypeID;
                              delete=upLoad.docID;
                              // docuentTypeName=upLoad.documentTypeName;
                              return Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.99,
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

                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10.0, left: 15.0, right: 15.0),
                                            child:  InkWell(
                                              onTap: (){
                                                setState(() {
                                                  if (index == 0) {
                                                    getDelete();
                                                   /* block =
                                                    false;
                                                    kycBool =
                                                    true;
                                                    isBlank =
                                                    true;
                                                    isPreview =
                                                    false;
                                                    tcVisibility =
                                                    false;*/
                                                    print('block' + index.toString());
                                                  } else if(index ==1){
                                                  /*  getDelete();
                                                    block =
                                                    false;
                                                    kycBool =
                                                    true;
                                                    isBlank =
                                                    true;
                                                    isPreview =
                                                    false;
                                                    tcVisibility =
                                                    false;*/
                                                    print('block' + index.toString());
                                                  }
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
                                                  child: SvgPicture.asset(
                                                    "images/cross.svg",
                                                    color: Colors.black26,
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.1,
                                        //width: 345,
                                        color: Color(0xffFCFCFC),
                                        margin: const EdgeInsets.only(
                                            top: 10.0,
                                            left: 15.0,
                                            right: 15.0,
                                            bottom: 20
                                        ),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(6),
                                          color: Color(0xffDFE0E6),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                            child: Container(
                                              height: 159.0,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.85,
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
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                ),
              ),
            ) ,

          ],
        ),
      ),
    );
  }

  Future<DocumentPojo> getUploadType() async {
    return  await this._memoizer?.runOnce(() async {
      await Future.delayed(Duration(seconds: 1));
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
          var res = response.body;
          print(res);
          DocumentPojo kycDocumentPojo = DocumentPojo.fromJson(json.decode(res));
          return kycDocumentPojo;
        } else {
          print("failed uploadtype data");
        }
      }
    });
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
      request.fields['documentTypeID'] = 1.toString();//docuentTypeID.toString();
      request.fields['type'] = 'SIM';
      request.fields['value'] ='3';
      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          imageFile!.readAsBytesSync(),
          filename: "test.${imageFile?.path.split(".").last}",
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
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getUploadedDocuments"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"type": 'SIM', "value": '3'}),
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

  Future<String?> getDelete() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/deleteKyc"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token,
          "platform": 'mobile_application'
        },
        body: jsonEncode({"docID": delete}),
      );
      if (response.statusCode == 200) {
        var responseJson =
        jsonDecode(response.body.toString()) as Map<String, dynamic>;
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        await sharedPreferences.setString(
            'response1', responseJson['apiResponseMsg']);
        print(responseJson);
        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed uploadtype data");
      }
      return value;
    }
  }

}



