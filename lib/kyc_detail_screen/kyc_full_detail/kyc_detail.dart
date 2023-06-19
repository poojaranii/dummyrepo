import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ich/installation_screen/upload_document.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../demo.dart';
import '../../installation_screen/upload_documents_pojo.dart';
import '../../navigation_screen/kyc_screen/kyc_pojo.dart';
import '../../navigation_screen/profile/kyc_detail/kyc_pojo.dart';

class KycDetail extends StatefulWidget {

  var deviceUnaId;
  var assetUniqueId;
  bool isKyc = false;
  var ownerMobile;
  var assetModel;
  InventoryDetails list;
  KycDetail({this.deviceUnaId,this.assetUniqueId,this.ownerMobile,this.assetModel,required this.isKyc,required this.list});

  @override
  _Page2State createState() => _Page2State(deviceUnaId,assetUniqueId,ownerMobile,assetModel,isKyc,list);
}

class _Page2State extends State<KycDetail> {
  var simID;

  _Page2State(this.deviceUnaId,this.assetUniqueId,this.ownerMobile,this.assetModel,this.isKyc,this.list);
  var deviceUnaId;
  late String error;
  var assetUniqueId;
  InventoryDetails list;
  var ownerMobile;
  var assetModel;
  bool _expanded = false;
  var _test = "Full Screen";
  var documentIdUpload,id ;
  bool condition = true;
  File? imageFile ;
  File? image;
  String token = "";
  var docuentTypeID ;
  bool isKyc;
  var tcVisibility = false;
  var block =false ;
  var kycBool=true;
  var isBlank=false;
  var isPreview=true;
  var delete;
  List<Documents>? documentList;
  List<UploadedDocuments>? listDocument;
  String assetUniqueID = "";
  String assetModelName = "";
  var sim;
  var count ;
  String? ownerMobileNo = "";
  String? name = "";
  String? memeType = "";
  var documentId ;
  String? currentItem;
  String? countryname, message;
  String? _mySelection;



  _openGalery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path.toString());
        getUploadDocumentFirst();
        isBlank = false;
        isPreview = true;
      });

    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => condition = false);
    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      this.getUploadType();
      this.getNotification();
      this.getUploadDocument();
      this.getUploadDocumentFirst();
    });
   // _startTimer();
    getToken();
    // this.getAssatType();
    // getUploadType();
    // this.getUploadType();
    // this.getUploadDocument();
    // Timer.periodic(Duration(seconds: 1), (_) => getAssatType());
  }

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
        assetUniqueID = sharedPreferences.getString('assetUniqueID')!;
        assetModelName = sharedPreferences.getString('assetModelName')!;
        docuentTypeID = sharedPreferences.getInt('documentTypeId');
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

     var deviceUniqurId =  list.deviceUniqueID!.valid==true
        ? list.deviceUniqueID?.string
        : "";

     var deviceModel = list.deviceModel?.valid==true
      ? list.deviceModel?.string
      : "";

     var  deviceType = list.deviceType?.valid==true
      ? list.deviceType?.string
      : "";

     var assetType = list.assetType?.valid==true
      ? list.assetType?.string
      : "";

     var assetUniqueID = list.assetUniqueID!.valid==true
      ? list.assetUniqueID?.string
      : "";

     var  assetModel = list.assetModelName!.valid==true
      ? list.assetModelName?.string
      : "";

     var ownerMobileNo = list.ownerMobileNo!.valid==true
      ? list.ownerMobileNo?.string
      : "";

     var ownerName = list.ownerName!.valid==true
      ? list.ownerName?.string
      : "";

     sim = list.simID.toString();

     isKyc = false;

     final mediaQueryData = MediaQuery.of(context);
     return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
            title: InkWell(
              onTap: (){
              //  getUploadType();
              //  getUploadDocumentFirst();
                getUploadDocument();
              },
              child: Text('KYC Detail',style: TextStyle(color: Color(0xff2B2B2B),fontSize: 18.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600),),
            ),centerTitle: true,
            backgroundColor: Color(0xffFFFFFF),
            leading: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  'images/forgot_back.svg',
                  width: 8.0,
                  height: 14.0,
                ),
              ),),
            actions: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Hello()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 18, 5, 8),
                  width: 30,
                  height: 30,
                  child: Stack(
                    children: [
                      SvgPicture.asset('images/bell_icon.svg', height: 21.0, width: 16.0,
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
                              border: Border.all(color:  Color(0xffff5252), width: 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: Text(count.toString(), style: TextStyle(
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
            ],
            elevation: 0.1,
          ),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.99,
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 18.0),
                height: 95.0,
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
                        5.0,
                        5.0,
                      ),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow

                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.0, left: 15.0),
                          child: Text(
                            "DEVICE DETAIL" ,
                            style: TextStyle(
                                color: Color(0xff565E6B),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                          child: Text(
                            "Unique ID",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 6.0, left: 15.0, right: 15.0),
                          child: Text(

                            deviceUniqurId != null ? deviceUniqurId :'',
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 48.0, left: 15.0),
                          child: Text(
                            "Model",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0, left: 15.0),
                          child: Text(deviceModel !=null ?deviceModel :'',
                            style: TextStyle(color: Color(0xff2B2B2B), fontSize: 12.0, fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 48.0, left: 35.0, right: 15.0),
                          child: Text("Type", style: TextStyle(color: Color(0xff788395), fontSize: 12.0, fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 6.0, left: 35.0, right: 15.0),
                          child: Text(
                            deviceType !=null ? deviceType :"",
                            style: TextStyle(color: Color(0xff2B2B2B), fontSize: 12.0, fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.99,
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 18.0),
                height: 96.0,
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
                        5.0,
                        5.0,
                      ),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.0, left: 15.0),
                          child: Text(
                            "ASSET DETAIL",
                            style: TextStyle(
                                color: Color(0xff565E6B),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.0, left: 15.0),
                          child: Text(
                            "Asset Type",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0, left: 15.0),
                          child: Text(assetType !=null ?assetType :'',
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 48.0, left: 35),
                          child: Text(
                            "Unique ID", style: TextStyle(color: Color(0xff788395), fontSize: 12.0, fontWeight: FontWeight.w500,fontFamily:'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0, left: 35),
                          child: Text(assetUniqueID !=null ?assetUniqueID :"",
                            style: TextStyle(color: Color(0xff2B2B2B), fontSize: 12.0,fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 48.0, left: 35.0, right: 15.0),
                          child: Text("Make Model",
                            style: TextStyle(color: Color(0xff788395), fontSize: 12.0, fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0, left: 35.0, right: 15.0),
                          child: Text(assetModel !=null ? assetModel :"", style: TextStyle(color: Color(0xff2B2B2B), fontSize: 12.0, fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.99,
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 18.0),
                height: 170.0,
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    6.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x51beccda),
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                    /*  BoxShadow(
                    color: Color(0xffFFFFFF),
                    offset: const Offset(1.0, 1.0),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  ),*/ //BoxShadow
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.0, left: 15.0),
                          child: Text(
                            "OWNER INFO",
                            style: TextStyle(
                                color: Color(0xff565E6B),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.0, left: 15.0),
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0, left: 15.0),
                          child: Text(
                            ownerName !=null ? ownerName : '',
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.0, left: 15.0),
                          child: Text(
                            "Phone No",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.0, left: 15.0),
                          child: Text(
                            ownerMobileNo !=null ? ownerMobileNo : "",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            margin: EdgeInsets.only(top: 15.0, left: 15.0),
                            child: Text(
                              "Pin Code",
                              style: TextStyle(
                                  color: Color(0xff788395),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                            ),
                          ),
                        ),

                      ],
                    ),
                    Visibility(
                      visible: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50.0, right: 178.0),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Color(0xff788395),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6.0, right: 15.0),
                            child: Text(
                              "KshitizKanwar33@gmail.com",
                              style: TextStyle(
                                  color: Color(0xff2B2B2B),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15.0, right: 15.0),
                            child: Text(
                              "Addres",
                              style: TextStyle(
                                  color: Color(0xff788395),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6.0, right: 15.0),
                            child: Text(
                              "SCO 191-92-93 Sector 34A",
                              style: TextStyle(
                                  color: Color(0xff2B2B2B),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,fontFamily: 'Inter'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.99,
                margin: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 18.0, bottom: 18.0),
               // height: 350.0,
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
                        5.0,
                        5.0,
                      ),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow

                  ],
                ),

                  child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 15.0),
                            child: Text(
                              "INSTALLATION DOCUMENT",
                              style: TextStyle(
                                  color: Color(0xff565E6B),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,fontFamily: 'Inter'),
                            ),
                          ),

                          if (isKyc == true)...[

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
                                            UploadedDocuments upLoad =
                                            list[index];
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
                                                        margin:
                                                        EdgeInsets.only(top: 10.0, left: 15.0),
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
                                                      color: Color(0xffFCFCFC),
                                                      margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 20),
                                                      child: DottedBorder(
                                                        borderType: BorderType.RRect,
                                                        radius: Radius.circular(6),
                                                        color: Color(0xffDFE0E6),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                6)),
                                                            child: Container(
                                                              height: 159.0,
                                                              width: MediaQuery.of(context).size.width * 0.85,
                                                              margin: EdgeInsets.all(10.0),
                                                              child: Image.network(
                                                                upLoad.docUrl.toString(),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            )),
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
                          ] else if (isKyc == false)...[

                            Column(
                              children: [
                                Container(
                                  child: FutureBuilder<UploadDocuments?>(
                                      future: getUploadType() ,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          //listDocument = snapshot.data.uploadedDocuments;
                                          documentList = snapshot.data?.documents;
                                          return documentList == null ? Container()
                                              : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: documentList!.length,
                                              itemBuilder: (context, index) {
                                                Documents documentUpload = documentList![index];
                                                name = documentUpload.documentTypeName;
                                                memeType = documentUpload.mimeTypes;
                                                documentId =documentUpload.documentTypeID;

                                                return imageFile != null ? Image.file(File(imageFile!.path).absolute,
                                                  width: MediaQuery.of(context).size.width * 0.95,
                                                  fit: BoxFit.fill,
                                                ) : Column(
                                                  children: [
                                                    Container(
                                                      margin:  EdgeInsets.only(top: 9.0, left: 15.0, right: 15.0, bottom: 10.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top: 7.0,
                                                                left: 15.0),
                                                            child:
                                                            Text(
                                                              name.toString(),
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
                                                              margin: EdgeInsets.only(
                                                                  top: 6,
                                                                  left: 15.0,
                                                                  right: 15.0),
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
                                                      // width: 318.0,
                                                      color: Color(0xffFCFCFC),
                                                      margin: const EdgeInsets.only(top: 00.0, left: 15.0, right: 15.0,bottom: 10.0),
                                                      child: DottedBorder(
                                                        borderType: BorderType.RRect,
                                                        radius: Radius.circular(6),
                                                        color: Color(0xffDFE0E6),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.all(Radius.circular(6)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            children: [
                                                              image != null
                                                                  ? Image.file(
                                                                File(image!.path).absolute,
                                                                width: MediaQuery.of(context).size.width * 0.95,
                                                                fit: BoxFit.fill,
                                                              )
                                                                  : Container(
                                                                margin: EdgeInsets.only(top: 20.0),
                                                                child: Align(alignment: Alignment.bottomCenter, child: Image.asset('images/earth_aadharr.png')),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(top: 9.0),
                                                                child: Align(
                                                                    alignment: Alignment.bottomCenter,
                                                                    child: Text(
                                                                      "No document found!",
                                                                      style: TextStyle(color: Color(0xff767D88), fontSize: 15.0, fontFamily: 'Inter', fontWeight: FontWeight.w500),
                                                                    )),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(top: 6.0),
                                                                child: Align(
                                                                    alignment: Alignment.bottomCenter,
                                                                    child: Text("jpg,jpeg,png", style: TextStyle(color: Color(0xff989EA8), fontSize: 11.0, fontFamily: 'Inter', fontWeight: FontWeight.w400),
                                                                    )),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UploadFile(list: documentUpload, sim: sim)));
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
                                                                        borderRadius: BorderRadius.circular(5.0,),),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          SvgPicture.asset('images/upload_icon.svg'),
                                                                          SizedBox(width: 7.0,),
                                                                          Text(
                                                                            'Browse Document',
                                                                            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12.0, fontFamily: 'Inter', fontWeight: FontWeight.w500),
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
                                                    InkWell(
                                                      onTap: () {

                                                      },
                                                      child:
                                                      Visibility(
                                                        visible: tcVisibility,
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                                                          child: Align(
                                                            alignment:
                                                            Alignment.bottomCenter,
                                                            child:
                                                            Container(
                                                              width: 165.0,
                                                              margin: EdgeInsets.only(left: 24.0, right: 24.0),
                                                              height: 32,
                                                              decoration: BoxDecoration(
                                                                color: Color(0xff2B2B2B),
                                                                borderRadius: BorderRadius.circular(
                                                                  5.0,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  SvgPicture.asset('images/upload_icon.svg'),
                                                                  SizedBox(
                                                                    width: 7.0,
                                                                  ),
                                                                  Text(
                                                                    'Upload Document',
                                                                    style: TextStyle(color: Color(0xffFFFFFF), fontSize: 12.0, fontFamily: 'Inter', fontWeight: FontWeight.w500),
                                                                  ),
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
                                              child: CircularProgressIndicator());
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
                                                            child:
                                                            Container(
                                                              width: 24.0,
                                                              height:
                                                              24.0,
                                                              decoration:
                                                              new BoxDecoration(
                                                                color: Color(
                                                                    0xffEFF0F2),
                                                                shape: BoxShape
                                                                    .circle,
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
                                                              )),
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



                                // campare()
                              ],
                            ),
                          ],

                        ],
                      ),


              ),





            ],
          ),
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
      request.fields['value'] =simID;

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
        body: jsonEncode({"type": 'SIM', "value": sim}),
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
}
