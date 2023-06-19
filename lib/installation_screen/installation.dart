
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../Democlass.dart';
import '../demo.dart';
import '../navigation_screen/kyc_screen/kyc_pojo.dart';
import '../navigation_screen/profile/kyc_detail/kyc_pojo.dart';
import 'DocumentPojo.dart';
import 'upload_document.dart';
import 'upload_documents_pojo.dart';

class InstallationScreen extends StatefulWidget {
  var deviceUnaId;
  var assetUniqueId;
  var ownerMobile;
  bool isKyc;
  var imageFile;
  var assetModel;
  String? selectionType;
  File? image;
  bool? typeUpload;
  InventoryDetails? list;
  bool? type, typeKyc;
  var sim;

  InstallationScreen(
      {this.imageFile,
      this.deviceUnaId,
      this.assetUniqueId,
      this.ownerMobile,
      required this.isKyc,
      this.list,
      this.image,
      this.type,
      this.selectionType,
      this.typeUpload,
      this.typeKyc,
      this.sim});

  @override
  _Page2State createState() => _Page2State(
      deviceUnaId,
      assetUniqueId,
      ownerMobile,
      imageFile,
      isKyc,
      list!,
      image!,
      type!,
      selectionType!,
      typeUpload!,
      typeKyc!,
      sim);
}

class _Page2State extends State<InstallationScreen> {
  _Page2State(
      this.deviceUnaId,
      this.imageFile,
      this.ownerMobile,
      this.assetModel,
      this.isKyc,
      this.list,
      this.image,
      this.type,
      this.selectionType,
      this.typeUpload,
      this.typeKyc,
      this.sim);
  bool _expanded = false;
  var _test = "Full Screen";
  var sim;
  var assetUniqueId;
  var imageFile;
  bool type, typeKyc;
  File image;
  String selectionType = "";
  List<Documents> documentList = [];
  List<UploadedDocuments> listDocument=[];
  AsyncMemoizer? _memoizer;
  AsyncMemoizer? _memoizer1;
  AsyncMemoizer? _memoizer2;
  var pos;
  var assetModel;
  var documentIdUpload,id;
  var deviceUniqurId;
  bool? flag;
  var ownerMobile;
  var tcVisibility = false;
  var block = false;
  var kycBool = true;
  var isBlank = true;
  var isPreview = false;
  bool isKyc = false;
  InventoryDetails list;
  var count;
  var deviceUnaId;
  bool isEnabled = false;
  Color btnColor = Color(0xffD8C3F1);
  String token = "";
  var docuentTypeID;
  var docuentTypeName;
  String deviceUniqueId = "";
  var delete;
  //var  assetModel;
  bool typeUpload;
  String ownerMobileNo = "";
  var assetType;
  var deviceModel;
  String name = "";
  String memeType = "";
  var documentId;
  String? currentItem;
  String? countryname, message;
  var assetUniqueID;
  late String error;
  String? _mySelection;
  var ownerName;
  var deviceType;
  Timer? _everySecond;
  List data = [];
  bool condition = true;
  Timer? _time;
  //var ownerMobileNo;

  //File imageFile;

  _openGalery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        getUploadDocumentFirst();
      });
    }
  }

  void _startTimer() {
    _time = Timer.periodic(Duration(seconds: 5), (Timer t) {
      print('dhoni');
      t.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => condition = false);
    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      this.getAssatType();
      this.getUploadType();
      this.getUploadDocument();
      this.getUploadDocumentFirst();
      this.getNotification();
    });

    _startTimer();
    getToken();
    _memoizer = AsyncMemoizer();
    _memoizer1 = AsyncMemoizer();
    _memoizer2 = AsyncMemoizer();
  }

  @override
  void didChangeDependencies() {
    getToken();
    getUploadType();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant InstallationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    getUploadType();
    this.getAssatType();
  }

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
        deviceUniqueId = sharedPreferences.getString('deviceUniqueID')!;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    /*getUploadDocument();*/

    setState(() {
      if (typeUpload == true) {
        setState(() {
          print("helloDocumentUpload");
          getUploadDocument();
          getUploadType();
        });

      } else if (typeKyc == false) {

        print("helloInstallUpload");

        deviceUniqurId = list.deviceUniqueID!.valid==true ? list.deviceUniqueID.toString() : "";

        deviceModel = list.deviceModel!.valid==true ? list.deviceModel.toString() : "";

        deviceType = list.deviceType!.valid ==true? list.deviceType.toString() : "";

        assetType = list.assetType!.valid==true ? list.assetType.toString() : "";

        assetUniqueID = list.assetUniqueID!.valid==true ? list.assetUniqueID.toString() : "";

        assetModel = list.assetModelName!.valid==true ? list.assetModelName.toString() : "";

        ownerMobileNo = list.ownerMobileNo!.valid==true ? list.ownerMobileNo.toString() : "";

        ownerName = list.ownerName!.valid==true ? list.ownerName : "";

        sim = list.simID.toString();

        isKyc = false;
      }
    });


    //String selectionType='';

    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          backgroundColor: Color(0xffF8F8F8),
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
                title:
                   Text(
                    'Installation',
                    style: TextStyle(
                        color: Color(0xff2B2B2B),
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600),
                  ),

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
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Hello()));
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
                            margin:
                                EdgeInsets.only(top: 0, right: 3, bottom: 3),
                            child: Container(
                              width: 20,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffff5252),
                                  border: Border.all(
                                      color: Color(0xffff5252), width: 0)),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff2B2B2B),
                        ),
                        title: Container(
                          //   margin: EdgeInsets.only(right: .5.sw),
                          child: Text(
                            "Device Detail",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                          ),
                        ),
                        children: <Widget>[
                          Divider(
                            color: Color(0xffDFE0E6),
                            thickness: 1.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 9.0,
                                left: 15.0,
                                right: 10.0,
                                bottom: 10.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Unique ID",
                                style: TextStyle(
                                    color: Color(0xff767D88),
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                          ),
                          Container(
                              height: 42.0,
                              width: MediaQuery.of(context).size.width * 0.99,
                              margin: const EdgeInsets.only(
                                  top: 00.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0),
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                border: Border.all(
                                  color: Color(0xffDFE0E6),
                                ),
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(6.0)),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    deviceUniqurId != null &&
                                            deviceUniqurId.isNotEmpty
                                        ? deviceUniqurId
                                        : '',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(0xff999CAB),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 9.0,
                                  left: 15.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Model",
                                    style: TextStyle(
                                        color: Color(0xff767D88),
                                        fontSize: 13.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                              height: 42.0,
                              width: MediaQuery.of(context).size.width * 0.99,
                              margin: const EdgeInsets.only(
                                  top: 00.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0),
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                border: Border.all(
                                  color: Color(0xffDFE0E6),
                                ),
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(6.0)),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    deviceModel != null ? deviceModel : '',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(0xff999CAB),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 9.0,
                                  left: 15.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Type",
                                    style: TextStyle(
                                        color: Color(0xff767D88),
                                        fontSize: 13.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                              height: 42.0,
                              width: MediaQuery.of(context).size.width * 0.99,
                              margin: const EdgeInsets.only(
                                  top: 00.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 15.0),
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                border: Border.all(
                                  color: Color(0xffDFE0E6),
                                ),
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(6.0)),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    deviceType != null ? deviceType : '',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(0xff999CAB),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                        ],
                        backgroundColor: Colors.white,
                      )),
                ),
                Container(
                  //margin: EdgeInsets.only(top: 12.0),
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff2B2B2B),
                        ),
                        title: Container(
                          child: Text(
                            "Asset Detail",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                          ),
                        ),
                        children: <Widget>[
                          Divider(
                            color: Color(0xffDFE0E6),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 9.0,
                                  left: 15.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Asset Type",
                                    style: TextStyle(
                                        color: Color(0xff767D88),
                                        fontSize: 13.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            height: 42.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffDFE0E6)),
                              borderRadius: BorderRadius.circular(
                                6.0,
                              ),
                            ),
                            child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: _mySelection,
                                        hint: Text(
                                          assetType != null ? assetType : '',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xff999CAB),
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500),
                                        ),
                                        isExpanded: true,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color(0xff2B2B2B),
                                        ),
                                        items: data?.map((item) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              item['name'],
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Color(0xcc2b2b2b),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            value:
                                                item['assetTypeID'].toString(),
                                          );
                                        })?.toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _mySelection = value as String;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                )),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 9.0,
                                  left: 15.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Unique ID",
                                    style: TextStyle(
                                        color: Color(0xff767D88),
                                        fontSize: 13.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                            height: 42.0,
                            margin: const EdgeInsets.only(
                                top: 00.0,
                                left: 15.0,
                                right: 15.0,
                                bottom: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              border: Border.all(
                                color: Color(0xffDFE0E6),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: TextFormField(
                              cursorColor: Color(0xcc2b2b2b),
                              textAlignVertical: TextAlignVertical.bottom,
                              style: TextStyle(color: Color(0xcc2b2b2b)),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 18.0, left: 10.0),
                                  border: InputBorder.none,
                                  hintText: assetUniqueID != null
                                      ? assetUniqueID
                                      : '',
                                  hintStyle: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xff999CAB),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500)),
                              onChanged: (val) {
                                if (val.length > 0) {
                                  isEnabled = true;
                                  btnColor =
                                      Color(0xffD8C3F1); //update active colour
                                } else {
                                  isEnabled = false;
                                  btnColor = Colors.grey; //update active colour
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid emailid';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 9.0,
                                  left: 15.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Make Model",
                                    style: TextStyle(
                                        color: Color(0xff767D88),
                                        fontSize: 13.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                            height: 42.0,
                            margin: const EdgeInsets.only(
                                top: 00.0,
                                left: 15.0,
                                right: 15.0,
                                bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              border: Border.all(
                                color: Color(0xffDFE0E6),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: TextFormField(
                              cursorColor: Color(0xcc2b2b2b),
                              textAlignVertical: TextAlignVertical.bottom,
                              style: TextStyle(color: Color(0xcc2b2b2b)),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 18.0, left: 10.0),
                                  border: InputBorder.none,
                                  hintText:
                                      assetModel != null ? assetModel : '',
                                  hintStyle: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xff999CAB),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid emailid';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                        backgroundColor: Colors.white,
                      )),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff2B2B2B),
                        ),
                        title: Container(
                          child: Text(
                            "Owner Info",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter'),
                          ),
                        ),
                        children: <Widget>[
                          Divider(
                            color: Color(0xffDFE0E6),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 9.0,
                                  left: 15.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        color: Color(0xff767D88),
                                        fontSize: 13.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                            height: 42.0,
                            margin: const EdgeInsets.only(
                                top: 00.0,
                                left: 15.0,
                                right: 15.0,
                                bottom: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              border: Border.all(
                                color: Color(0xffDFE0E6),
                              ),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: TextFormField(
                              cursorColor: Color(0xcc2b2b2b),
                              textAlignVertical: TextAlignVertical.bottom,
                              style: TextStyle(color: Color(0xcc2b2b2b)),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 18.0, left: 10.0),
                                  border: InputBorder.none,
                                  hintText: ownerName != null ? ownerName : '',
                                  hintStyle: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xff999CAB),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid emailid';
                                }
                                return null;
                              },
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                                margin:  EdgeInsets.only(
                                    top: 9.0,
                                    left: 15.0,
                                    right: 10.0,
                                    bottom: 10.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                          color: Color(0xff767D88),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Inter'),
                                    ))),
                          ),
                          Visibility(
                            visible: false,
                            child: new Container(
                              height: 42.0,
                              margin: const EdgeInsets.only(
                                  top: 00.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 10.0),
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                border: Border.all(
                                  color: Color(0xffDFE0E6),
                                ),
                                borderRadius: new BorderRadius.all(Radius.circular(6.0)),
                              ),
                              child: TextFormField(
                                cursorColor: Color(0xcc2b2b2b),
                                textAlignVertical: TextAlignVertical.bottom,
                                style: TextStyle(color: Color(0xcc2b2b2b)),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        bottom: 18.0, left: 10.0),
                                    border: InputBorder.none,
                                    hintText: 'Enter email address',
                                    hintStyle: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(0xff999CAB),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter valid emailid';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 9.0,
                                  left: 15.0,
                                  right: 10.0,
                                  bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Phone No",
                                    style: TextStyle(
                                        color: Color(0xff767D88),
                                        fontSize: 13.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500),
                                  ))),
                          Container(
                            height: 42.0,
                            margin: EdgeInsets.only(
                                top: 00.0,
                                left: 15.0,
                                right: 15.0,
                                bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              border: Border.all(
                                color: Color(0xffDFE0E6),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: TextFormField(
                              cursorColor: Color(0xcc2b2b2b),
                              textAlignVertical: TextAlignVertical.bottom,
                              style: TextStyle(color: Color(0xcc2b2b2b)),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 18.0, left: 10.0),
                                  border: InputBorder.none,
                                  hintText: ownerMobileNo != null
                                      ? ownerMobileNo
                                      : '',
                                  hintStyle: TextStyle(
                                      fontSize: 13.0,
                                      color: Color(0xff999CAB),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter')),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid emailid';
                                }
                                return null;
                              },
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: 9.0,
                                    left: 15.0,
                                    right: 10.0,
                                    bottom: 10.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Address",
                                      style: TextStyle(
                                          color: Color(0xff767D88),
                                          fontSize: 13.0,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500),
                                    ))),
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                              height: 42.0,
                              margin: EdgeInsets.only(
                                  top: 00.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 15.0),
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                border: Border.all(
                                  color: Color(0xffDFE0E6),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              child: TextFormField(
                                cursorColor: Color(0xcc2b2b2b),
                                textAlignVertical: TextAlignVertical.bottom,
                                style: TextStyle(color: Color(0xcc2b2b2b)),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        bottom: 18.0, left: 10.0),
                                    border: InputBorder.none,
                                    hintText: 'Enter address',
                                    hintStyle: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(0xff999CAB),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter')),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter valid emailid';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                                margin: const EdgeInsets.only(
                                    top: 9.0,
                                    left: 15.0,
                                    right: 10.0,
                                    bottom: 10.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Pin Code",
                                      style: TextStyle(
                                          color: Color(0xff767D88),
                                          fontSize: 13.0,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500),
                                    ))),
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                              height: 42.0,
                              margin: EdgeInsets.only(
                                  top: 00.0,
                                  left: 15.0,
                                  right: 15.0,
                                  bottom: 15.0),
                              decoration: BoxDecoration(
                                color: Color(0xffFFFFFF),
                                border: Border.all(
                                  color: Color(0xffDFE0E6),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              child: TextFormField(
                                cursorColor: Color(0xcc2b2b2b),
                                textAlignVertical: TextAlignVertical.bottom,
                                style: TextStyle(color: Color(0xcc2b2b2b)),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        bottom: 18.0, left: 10.0),
                                    border: InputBorder.none,
                                    hintText: 'Enter pin code',
                                    hintStyle: TextStyle(
                                        fontSize: 13.0,
                                        color: Color(0xff999CAB),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter valid emailid';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                        backgroundColor: Colors.white,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ExpansionTile(
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff2B2B2B),
                        ),
                        title: Container(
                          child: Text(
                            "Installation Documents",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                          ),
                        ),
                        children: <Widget>[
                          Divider(color: Color(0xffDFE0E6),),

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
                                                documentId =
                                                    list[index].documentTypeID;
                                                delete = list[index].docID;
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.99,
                                                  margin: EdgeInsets.only(
                                                      left: 0.0,
                                                      right: 0.0,
                                                      top: 0.0),
                                                  height: 260.0,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10.0,
                                                                    left: 15.0),
                                                            child: Text(
                                                              upLoad
                                                                  .documentTypeName.toString(),
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff767D88),
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Inter'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.1,
                                                          //width: 345,
                                                          color:
                                                              Color(0xffFCFCFC),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10.0,
                                                                  left: 15.0,
                                                                  right: 15.0,
                                                                  bottom: 20),
                                                          child: DottedBorder(
                                                            borderType:
                                                                BorderType
                                                                    .RRect,
                                                            radius:
                                                                Radius.circular(
                                                                    6),
                                                            color: Color(
                                                                0xffDFE0E6),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                                child:
                                                                    Container(
                                                                  height: 159.0,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.85,
                                                                  margin: EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                                  child: Image
                                                                      .network(
                                                                    upLoad
                                                                        .docUrl.toString(),
                                                                    fit: BoxFit
                                                                        .fill,
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
                                              documentList = snapshot.data!.documents!;
                                              return documentList == null ? Container()
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: documentList.length,
                                                      itemBuilder: (context, index) {
                                                        Documents documentUpload = documentList[index];
                                                        name = documentUpload.documentTypeName!;
                                                        memeType = documentUpload.mimeTypes!;
                                                        documentId =documentUpload.documentTypeID;

                                                        return imageFile != null ? Image.file(File(imageFile.path).absolute,
                                                                width: MediaQuery.of(context).size.width * 0.95,
                                                                fit: BoxFit.fill,
                                                              ) : Column(
                                                                children: [
                                                                  Container(
                                                                    margin:  EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            9.0,
                                                                        left:
                                                                            15.0,
                                                                        right:
                                                                            15.0,
                                                                        bottom:
                                                                            10.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: 7.0,
                                                                              left: 15.0),
                                                                          child:
                                                                              Text(
                                                                            name,
                                                                            style: TextStyle(
                                                                                color: Color(0xff767D88),
                                                                                fontSize: 13.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Inter'),
                                                                          ),
                                                                        ),
                                                                        Visibility(
                                                                          visible:
                                                                              tcVisibility,
                                                                          child:
                                                                              Container(
                                                                            margin: EdgeInsets.only(
                                                                                top: 6,
                                                                                left: 15.0,
                                                                                right: 15.0),
                                                                            child:
                                                                                Row(
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
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.24,
                                                                    // width: 318.0,
                                                                    color: Color(
                                                                        0xffFCFCFC),
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            00.0,
                                                                        left:
                                                                            15.0,
                                                                        right:
                                                                            15.0,
                                                                        bottom:
                                                                            10.0),
                                                                    child:
                                                                        DottedBorder(
                                                                      borderType:
                                                                          BorderType
                                                                              .RRect,
                                                                      radius: Radius
                                                                          .circular(
                                                                              6),
                                                                      color: Color(
                                                                          0xffDFE0E6),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(6)),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            image != null
                                                                                ? Image.file(
                                                                                    File(image.path).absolute,
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
                                                                                  child: Text(
                                                                                    "jpg,jpeg,png",
                                                                                    style: TextStyle(color: Color(0xff989EA8), fontSize: 11.0, fontFamily: 'Inter', fontWeight: FontWeight.w400),
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
                                                                                      // border: Border.all(color: Color(0xffACABB3)),
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
                                                                      visible:
                                                                          tcVisibility,
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                5.0,
                                                                            bottom:
                                                                                10.0),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.bottomCenter,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                165.0,
                                                                            margin:
                                                                                EdgeInsets.only(left: 24.0, right: 24.0),
                                                                            height:
                                                                                32,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xff2B2B2B),
                                                                              // border: Border.all(color: Color(0xffACABB3)),
                                                                              borderRadius: BorderRadius.circular(
                                                                                5.0,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Row(
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
                                              listDocument = snapshot.data!.uploadedDocuments!;
                                              return listDocument == null ? SizedBox() : ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: listDocument.length,
                                                  itemBuilder: (context, index) {
                                                    UploadedDocuments upLoad = listDocument[index];
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
                      )),
                ),

                InkWell(
                  onTap: () {
                    //  getUploadDocument();
                    //getUploadDocumentFirst();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: true,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.99,
                            margin: EdgeInsets.only(
                                left: 15.0,
                                top: 30.0,
                                bottom: 30.0,
                                right: 15.0),
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: Color(0xffFFF5F3),
                              border: Border.all(color: Color(0xffFFF5F3)),
                              borderRadius: BorderRadius.circular(
                                6.0,
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Installation",
                                  style: TextStyle(
                                      color: Color(0xffFFCDC2),
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Text(documentId.toString()),
              ],
            ),
          )),
    );
  }

  Future<String?> getAssatType() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getAssetTypes"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body.toString());
        List<dynamic> mdata = map["assetTypes"];
        if (mounted == true) {
          setState(() {
            data = mdata;
          });
        }
        print('hello' + mdata[0]['name']);
        final stringRes = JsonEncoder.withIndent('').convert(mdata);
        print(stringRes);
      } else {
        print("failed responce data");
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
  //  });
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
      request.headers.addAll({
        "content-type": "multipart/form_data",
        "accept-encoding": "gzip",
        "Authorization": token,
        "platform": 'mobile_application'
      });

      request.fields['documentTypeID'] =
          documentId.toString(); //documentId.toString();
      request.fields['type'] = 'SIM';
      request.fields['value'] = sim;

      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          imageFile.readAsBytesSync(),
          filename: "test.${imageFile.path.split(".").last}",
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
        body: jsonEncode({"isRead": 'false'}),
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
