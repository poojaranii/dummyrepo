import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ich/installation_screen/installation.dart';
import 'package:ich/kyc_detail_screen/kyc_full_detail/kyc_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../demo.dart';
import '../../notification_screen/Notification.dart';
import 'PlanPojo.dart';
import 'kyc_pojo.dart';

class KycScreen extends StatefulWidget {
  @override
  _KycScreenState createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  String token = "";
  var simType;
  var simID;
  var deviceUniqeId;
  var hardWareBand;
  var profileSim;
  var deviceModel;
  var ownerMobileNo;
  var ownerName;
  var assetUniqueID;
  var assetModel;
  var assetType;
  var imsi;
  var imsi_second;
  var deviceType;
  var totalStock;
  var count;
  bool type=true;
  List<InventoryDetails>? list;
  var currentMonhStock;
  String? currentStatus;
  var totalAvailable;
  var currentAvailable;
  var totalAllocated;
  var currentAllocatd;
  var totalExired;
  var currentExpire;
  List inventaryData=[];
  var totalBootstrap;
  bool loading = true;
  var currentBootstrap;
  var totalDeactive;
  var currentDeactive;
  List data=[];
  List dataScope=[];
  List netwarkBand =[];
  List profil =[];
  List dataNetwark =[];
  var _mySelection;
  int? dataNew;
  String? _myNetworkSelection;
  String? _myScopeSelection;
  String? _myNetwarkBand;
  String? _myProifle;
  bool condition = true;
  String searchString = "";
  var simTypename;
  bool? isKyc;
  var serviceScopeName;
  var networkBandName;
  var simProfileName;
  bool first = true;
  bool second = false;
  var primaryNetworkType;
  var secondaryNetworkType;
  var iccid;
  var msisdn;
  var currentMobileNo;
  var uniqueIdDevice;
  bool typeKyc=false;
  List<Map<String, dynamic>> _foundUsers = [];
  String dropdownvalue = 'Item 1';
  String dropdownvalue1 = 'Item 1';
  TextEditingController _searchControl = TextEditingController();
  SharedPreferences? sharedPreferences;
  List<bool> showQty = [];
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var items1 = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  List<String> iccide =[];
  List<String> tempList=[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => condition = false);
    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      getSimType1();
      //getNetwarkBand();
      getNotification();
      geSubscription();
    });
    //_foundUsers=list.cast<Map<String, dynamic>>();
    getToken();
    getInventory();
   // getNetwarkBand();
    getInventoryData();
    getSimType();
    getNetworkType();
    getSimType1();

  }

  @override
  void didChangeDependencies() {
    getToken();
    getInventory();
    getInventoryData();
    getSimType();
    getNetworkType();

    getSimType1();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant KycScreen oldWidget) {
    getToken();
    getInventory();
    getInventoryData();
  //  getNetwarkBand();
    getSimType();
    getNetworkType();
    getSimType1();
    super.didUpdateWidget(oldWidget);
  }

  void getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences!.getString('login')!;
        simType = sharedPreferences!.getInt('simType').toString();
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              title: Text(
                'KYC Management',
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

                },
                child: Padding(
                    padding: EdgeInsets.all(18),
                    child: SvgPicture.asset('images/drower.svg')),
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
                          margin: EdgeInsets.only(top: 0, right: 3, bottom: 3),
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

                /*   InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Hello()));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 20, 8),
                    child: SvgPicture.asset(
                      'images/bell_icon.svg',
                      height: 21.0,
                      width: 16.0,
                    ),
                  ),
                ),*/
              ],
              elevation: 0.1,
              // shadowColor: Color(0x10000000),
            ),
          ),
        ),
        body: Container(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 294.0,
                        margin: EdgeInsets.only(left: 15.0, top: 22.0),
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffEBE5E5)),
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x4cbeccda),
                              offset: const Offset(
                                0.0,
                                1.0,
                              ),
                              blurRadius: 3.0,
                              spreadRadius: -3.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: TextFormField(
                          controller: _searchControl,
                          cursorColor: Color(0xcc2b2b2b),
                          style: TextStyle(color: Color(0xcc2b2b2b)),
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 16.0, right: 10,left: 15.0),
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(12),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      getInventoryData();
                                    });

                                  },
                                  child: SvgPicture.asset(
                                    "images/search_icons.svg",
                                    color: Color(0xff9F9F9F),
                                    width: 13.0,
                                    height: 14.0,
                                  ),
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'Search for ICCID,MSISDN',
                              hintStyle: TextStyle(
                                  fontSize: 11.0,
                                  color: Color(0xff9F9F9F),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400)),
                          onChanged: (value) {
                            getInventoryData();
                            //filterSearchResults(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid emailid';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 9.0,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            //height: 480.0,
                            height: MediaQuery.of(context).size.height * 0.60,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(12.0),
                                topRight: const Radius.circular(12.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 15.0, left: 15.0, right: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: new BoxDecoration(
                                          color: Color(0xffEFF0F2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              "images/cross.svg",
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                            child: Text(
                                          'Filter',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 18.0,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                              child: Text(
                                            'Clear',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: Color(0xffE13939),
                                                fontSize: 14.0,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Color(0xffECEDEF),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 8),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 15.0),
                                                child: Text(
                                                  "Hardware Type",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      color: Color(0xff2B2B2B),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.0),
                                                )),
                                            SizedBox(height: 10),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              height: 42.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Color(0xffDFE0E6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  6.0,
                                                ),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          value: _mySelection,
                                                          hint: Text(
                                                            " Choose hardware type",
                                                            style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Color(
                                                                    0xff999CAB),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          isExpanded: true,
                                                          icon: SvgPicture.asset(
                                                              'images/drop_png.svg',
                                                              color: Color(
                                                                  0xcc2b2b2b)),
                                                          items:
                                                              data?.map((item) {
                                                            return DropdownMenuItem(
                                                              child: Text(
                                                                item['name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.0,
                                                                    color: Color(
                                                                        0xcc2b2b2b),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              value: item[
                                                                      'simTypeID']
                                                                  .toString(),
                                                            );
                                                          })?.toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              getSimType();

                                                              _mySelection =
                                                                  value;

                                                              // ignore: unrelated_type_equality_checks
                                                              if (data ==
                                                                  'simTypeID') {
                                                                data = data;
                                                              }

                                                              dataNew = int.parse(
                                                                  _mySelection);
                                                              sharedPreferences?.setInt('simTypeID',int.parse(_mySelection.toString()));
                                                              print(
                                                                  'helloDropDown' +
                                                                      _mySelection);
                                                            });
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  )),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 15.0),
                                                child: Text(
                                                  "Service Scope",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      color: Color(0xff2B2B2B),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.0),
                                                )),
                                            SizedBox(height: 10),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              height: 42.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Color(0xffDFE0E6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  6.0,
                                                ),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          value: _mySelection,
                                                          hint: Text(
                                                            "Choose Scope type",
                                                            style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Color(
                                                                    0xff999CAB),
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          isExpanded: true,
                                                          icon: SvgPicture.asset(
                                                              'images/drop_png.svg',
                                                              color: Color(0xcc2b2b2b)),
                                                          items: data?.map((item) {
                                                            return DropdownMenuItem(
                                                              child: Text(
                                                                item['name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    13.0,
                                                                    color: Color(
                                                                        0xcc2b2b2b),
                                                                    fontFamily:
                                                                    'Inter',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                              value: item[
                                                              'simTypeID']
                                                                  .toString(),

                                                            );
                                                          })?.toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                             getSimType();

                                                              _mySelection =
                                                                  value;

                                                              // ignore: unrelated_type_equality_checks


                                                              dataNew = int.parse(
                                                                  _mySelection);
                                                              //sharedPreferences.setInt('simTypeID',int.parse(_mySelection.toString()));
                                                              print(
                                                                  'helloDropDownscope' +
                                                                      _mySelection);
                                                            });
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  )),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 15.0),
                                                child: Text(
                                                  "Network Band",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      color: Color(0xff2B2B2B),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.0),
                                                )),
                                            SizedBox(height: 10),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              height: 42.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Color(0xffDFE0E6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  6.0,
                                                ),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          value: _mySelection,
                                                          hint: Text(
                                                            " Choose hardware type",
                                                            style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Color(
                                                                    0xff999CAB),
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          isExpanded: true,
                                                          icon: SvgPicture.asset(
                                                              'images/drop_png.svg',
                                                              color: Color(
                                                                  0xcc2b2b2b)),
                                                          items:
                                                          data?.map((item) {
                                                            return DropdownMenuItem(
                                                              child: Text(
                                                                item['name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    13.0,
                                                                    color: Color(
                                                                        0xcc2b2b2b),
                                                                    fontFamily:
                                                                    'Inter',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                              value: item[
                                                              'simTypeID']
                                                                  .toString(),

                                                            );
                                                          })?.toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _mySelection =
                                                                  value;
                                                              getSimType();


                                                              // ignore: unrelated_type_equality_checks
                                                              if (data ==
                                                                  'simTypeID') {
                                                                data = data;
                                                              }

                                                              dataNew = int.parse(
                                                                  _mySelection);
                                                              //sharedPreferences.setInt('simTypeID',int.parse(_mySelection.toString()));
                                                              print(
                                                                  'helloDropDown' +
                                                                      _mySelection);
                                                            });
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  )),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 15.0),
                                                child: Text(
                                                  "Profile",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      color: Color(0xff2B2B2B),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.0),
                                                )),
                                            SizedBox(height: 10),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              height: 42.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Color(0xffDFE0E6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  6.0,
                                                ),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          value: _mySelection,
                                                          hint: Text(
                                                            " Choose hardware type",
                                                            style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Color(
                                                                    0xff999CAB),
                                                                fontFamily:
                                                                'Inter',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          isExpanded: true,
                                                          icon: SvgPicture.asset(
                                                              'images/drop_png.svg',
                                                              color: Color(
                                                                  0xcc2b2b2b)),
                                                          items:
                                                          data?.map((item) {
                                                            return DropdownMenuItem(
                                                              child: Text(
                                                                item['name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    13.0,
                                                                    color: Color(
                                                                        0xcc2b2b2b),
                                                                    fontFamily:
                                                                    'Inter',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                              value: item[
                                                              'simTypeID']
                                                                  .toString(),
                                                            );
                                                          })?.toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _mySelection =
                                                                  value;

                                                              // ignore: unrelated_type_equality_checks
                                                              if (data ==
                                                                  'simTypeID') {
                                                                data = data;
                                                              }

                                                              dataNew = int.parse(
                                                                  _mySelection);
                                                              //sharedPreferences.setInt('simTypeID',int.parse(_mySelection.toString()));
                                                              print(
                                                                  'helloDropDown' +
                                                                      _mySelection);
                                                            });
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  )),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 15.0),
                                                child: Text(
                                                  "Network Operator",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      color: Color(0xff2B2B2B),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13.0),
                                                )),
                                            SizedBox(height: 10),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              height: 42.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Color(0xffDFE0E6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  6.0,
                                                ),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                      return DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          value:
                                                          _myNetworkSelection,
                                                          hint: Text(
                                                            "Choose network operator",
                                                            style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Color(
                                                                    0xff999CAB),
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          isExpanded: true,
                                                          icon: SvgPicture.asset(
                                                              'images/drop_png.svg',
                                                              color: Color(
                                                                  0xcc2b2b2b)),
                                                          items: dataNetwark
                                                              ?.map((item) {
                                                            return DropdownMenuItem(
                                                              child: Text(
                                                                item['name'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.0,
                                                                    color: Color(
                                                                        0xcc2b2b2b),
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              value: item[
                                                                      'networkID']
                                                                  .toString(),
                                                            );
                                                          })?.toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              getSimType();
                                                              _myNetworkSelection =
                                                                  value as String?;

                                                            });
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  )),
                                            ),
                                            SizedBox(height: 15),

                                            InkWell(
                                              onTap: (){
                                                Navigator.pop(context,false);
                                              },
                                              child: Container(
                                                height: 52.0,
                                                margin: EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    bottom: 12.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xff420098),
                                                  // border: Border.all(color: Color(0xff420098)),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Apply filters",
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffFFFFFF),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15.0),
                                                    )),
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      },


                      child: Container(
                        width: 42.0,
                        margin: EdgeInsets.only(right: 15.0, top: 22.0),
                        height: 42.0,
                        decoration: BoxDecoration(
                          color: Color(0xffE4E4E4),
                          //border: Border.all(color: Color(0xffACABB3)),
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(11.0),
                            child: SvgPicture.asset(
                              "images/filter.svg",
                              width: 17.0,
                              height: 17.0,
                            )),
                      ),
                    ),
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        getInventoryData();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: EdgeInsets.only(left: 15.0, top: 12.0),
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff6309D9),
                              Color(0xff420098),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xC000000),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 6.0),
                              child: Text(
                                "TOTAL STOCK",
                                style: TextStyle(
                                    color: Color(0xc8ffffff),
                                    fontSize: 8.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                "$totalStock",
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 15.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 5.0),
                              child: Text(
                                "THIS MONTH: $currentMonhStock",
                                style: TextStyle(
                                    color: Color(0xc6ffffff),
                                    fontSize: 8.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      margin: EdgeInsets.only(top: 12.0),
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          6.0,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff0EA721),
                            Color(0xffA2C904),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xC000000),
                            offset: const Offset(
                              0.0,
                              4.0,
                            ),
                            blurRadius: 4.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 9.0, top: 6.0),
                            child: Text(
                              "AVAILABLE STOCK",
                              style: TextStyle(
                                  color: Color(0xc6ffffff),
                                  fontSize: 8.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Text(
                              "$totalAvailable",
                              style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 15.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 9.0, top: 5.0),
                            child: Text(
                              "THIS MONTH: $currentAvailable" ,
                              style: TextStyle(
                                  color: Color(0xc6ffffff),
                                  fontSize: 9.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: EdgeInsets.only(right: 15.0, top: 12),
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xffFF943C),
                              Color(0xffEF2A8A),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xC000000),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 6.0),
                              child: Text(
                                "ALLOCATED STOCK",
                                style: TextStyle(
                                    color: Color(0xc6ffffff),
                                    fontSize: 8.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                "$totalAllocated",
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 15.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 5.0),
                              child: Text(
                                "THIS MONTH: $currentAllocatd",
                                style: TextStyle(
                                    color: Color(0xc6ffffff),
                                    fontSize: 8.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: EdgeInsets.only(left: 15.0, top: 12.0),
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff2AC9EF),
                              Color(0xff773CFF),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xC000000),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 6.0),
                              child: Text(
                                "EXPIRED STOCK",
                                style: TextStyle(
                                    color: Color(0xc6ffffff),
                                    fontSize: 8.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                "$totalExired",
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 15.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 5.0),
                              child: Text(
                                "THIS MONTH: $currentExpire",
                                style: TextStyle(
                                    color: Color(0xc8ffffff),
                                    fontSize: 8.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: EdgeInsets.only(top: 12.0),
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff4374FF),
                              Color(0xff1A82DB),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xC000000),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 6.0),
                              child: Text(
                                "BOOTSTRAP STOCK",
                                style: TextStyle(
                                    color: Color(0xc8ffffff),
                                    fontSize: 8.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                "$totalBootstrap",
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 15.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 5.0),
                              child: Text(
                                "THIS MONTH: $currentBootstrap",
                                style: TextStyle(
                                    color: Color(0xc8ffffff),
                                    fontSize: 8.0,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          margin: EdgeInsets.only(right: 15.0, top: 12),
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              6.0,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xffEE5511),
                                Color(0xffF78B05),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xC000000),
                                offset: const Offset(
                                  0.0,
                                  4.0,
                                ),
                                blurRadius: 4.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 9.0, top: 6.0),
                                child: Text(
                                  "DEACTIVATED STOCK",
                                  style: TextStyle(
                                      color: Color(0xc6ffffff),
                                      fontSize: 8.0,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.0, top: 5.0),
                                child: Text(
                                  "$totalDeactive",
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 15.0,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 9.0, top: 5.0),
                                child: Text(
                                  "THIS MONTH: $currentDeactive",
                                  style: TextStyle(
                                      color: Color(0xc6ffffff),
                                      fontSize: 8.0,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              //  _widgetList(),
                Container(
                    child: Expanded(

                  child: FutureBuilder<KycPojo?>(

                      future: Future.delayed(Duration(seconds: 1)).then((value) => getInventoryData()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          list = snapshot.data!.inventoryDetails;
                          return list == null
                              ? Container()
                              : ListView.builder(
                                  itemCount: list?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    InventoryDetails detail = list![index];

                                    iccid=detail.iccid1.toString();

                                    isKyc = detail.isKyc;

                                    simTypename = detail.simTypeName;

                                    simID = detail.simID.toString();

                                    deviceUniqeId = detail.deviceUniqueID!.valid==true
                                        ? detail.deviceUniqueID.toString()
                                        : "";

                                    deviceModel = detail.deviceModel!.valid==true
                                        ? detail.deviceModel.toString()
                                        : "";

                                    deviceType = detail.deviceType!.valid==true
                                        ? detail.deviceType.toString()
                                        : "";

                                    assetType = detail.assetType!.valid==true
                                        ? detail.assetType.toString()
                                        : "";

                                    assetUniqueID = detail.assetUniqueID!.valid==true
                                        ? detail.assetUniqueID.toString()
                                        : "";

                                    assetModel = detail.assetModelName!.valid==true
                                        ? detail.assetModelName.toString()
                                        : "";

                                    ownerMobileNo = detail.ownerMobileNo!.valid==true
                                        ? detail.ownerMobileNo.toString()
                                        : "";

                                    ownerName = detail.ownerName!.valid==true
                                        ? detail.ownerName.toString()
                                        : "";

                                    imsi = detail
                                        .imsi1No; //?detail.imsi2No.valid :'';

                                    //  ownerName=detail.isKyc

                                    //simID=detail.isKyc;
                                    return Slidable(
                                      // actionExtentRatio: 0.99,
                                      // actionPane: SlidableDrawerActionPane(),
                                      key: UniqueKey(),
                                      // secondaryActions: <Widget>[
                                      //   Container(
                                      //     margin: EdgeInsets.only(
                                      //         left: 11.0,
                                      //         right: 15.0,
                                      //         top: 10.0,
                                      //         bottom: 3),
                                      //     height: 74.0,
                                      //     width: MediaQuery.of(context)
                                      //             .size
                                      //             .width *
                                      //         0.99,
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       borderRadius: BorderRadius.circular(
                                      //         6.0,
                                      //       ),
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //           color: Color(0xd000000),
                                      //           offset: const Offset(
                                      //             0.0,
                                      //             4.0,
                                      //           ),
                                      //           blurRadius: 4.0,
                                      //           spreadRadius: 0.0,
                                      //         ), //BoxShadow
                                      //       ],
                                      //     ),
                                      //     child: Row(
                                      //       children: [
                                      //         Expanded(
                                      //           child: Container(
                                      //             margin: EdgeInsets.only(
                                      //                 top: 8.0,
                                      //                 left: 10.0,
                                      //                 bottom: 8.0),
                                      //             height: 33,
                                      //             decoration: BoxDecoration(
                                      //               color: Color(0xff420098),
                                      //               // border: Border.all(color: Color(0xffFFF5F3)),
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                 5.0,
                                      //               ),
                                      //             ),
                                      //             child: InkWell(
                                      //               onTap: () {
                                      //                 if (detail
                                      //                         .currentStatus ==
                                      //                     "USED") {
                                      //                   Navigator.push(
                                      //                       context,
                                      //                       MaterialPageRoute(
                                      //                           builder: (context) => KycDetail(
                                      //                              list : detail, isKyc: null!,)));
                                      //                 } else {
                                      //                   Navigator.push(
                                      //                       context,
                                      //                       MaterialPageRoute(
                                      //                           builder: (context) => InstallationScreen(
                                      //                               list : detail,typeKyc: false, isKyc: null!,)));
                                      //                 }
                                      //               },
                                      //               child: Align(
                                      //                   alignment:
                                      //                       Alignment.center,
                                      //                   child: Text(
                                      //                     detail.currentStatus ==
                                      //                             "USED"
                                      //                         ? "Detail"
                                      //                         : "Installation",
                                      //                     style: TextStyle(
                                      //                         color: Color(
                                      //                             0xffFFFFFF),
                                      //                         fontFamily:
                                      //                             'Inter',
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .w600,
                                      //                         fontSize: 12.0),
                                      //                   )),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         Expanded(
                                      //           child: Container(
                                      //             margin: EdgeInsets.only(
                                      //                 top: 8.0,
                                      //                 left: 10.0,
                                      //                 bottom: 8.0,
                                      //                 right: 10.0),
                                      //             height: 33,
                                      //             decoration: BoxDecoration(
                                      //               color: Color(0xff2B2B2B),
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                 5.0,
                                      //               ),
                                      //             ),
                                      //             child: Container(
                                      //               child: FutureBuilder<PlanPojo?>(
                                      //                   future:
                                      //                       geSubscription(),
                                      //                   builder: (context, snapshot) {
                                      //                     if (snapshot.hasData) {
                                      //                       PlanPojo? planpojo = snapshot.data;
                                      //                       return InkWell(
                                      //                         onTap: () {
                                      //                           showModalBottomSheet(
                                      //                             context:
                                      //                                 context,
                                      //                             isScrollControlled:
                                      //                                 true,
                                      //                             backgroundColor:
                                      //                                 Colors
                                      //                                     .transparent,
                                      //                             builder:
                                      //                                 (context) =>
                                      //                                     Container(
                                      //                               height: MediaQuery.of(context)
                                      //                                       .size
                                      //                                       .height *
                                      //                                   0.47,
                                      //                               decoration:
                                      //                                   new BoxDecoration(
                                      //                                 color: Colors
                                      //                                     .white,
                                      //                                 borderRadius:
                                      //                                     new BorderRadius
                                      //                                         .only(
                                      //                                   topLeft:
                                      //                                       const Radius.circular(12.0),
                                      //                                   topRight:
                                      //                                       const Radius.circular(12.0),
                                      //                                 ),
                                      //                               ),
                                      //                               child:
                                      //                                   Column(
                                      //                                 mainAxisAlignment:
                                      //                                     MainAxisAlignment
                                      //                                         .start,
                                      //                                 crossAxisAlignment:
                                      //                                     CrossAxisAlignment
                                      //                                         .start,
                                      //                                 children: [
                                      //                                   Container(
                                      //                                     margin: EdgeInsets.only(
                                      //                                         top: 15.0,
                                      //                                         left: 15.0,
                                      //                                         right: 15.0),
                                      //                                     child:
                                      //                                         Row(
                                      //                                       children: [
                                      //                                         Container(
                                      //                                           width: 24.0,
                                      //                                           height: 24.0,
                                      //                                           decoration: new BoxDecoration(
                                      //                                             color: Color(0xffEFF0F2),
                                      //                                             shape: BoxShape.circle,
                                      //                                           ),
                                      //                                           child: InkWell(
                                      //                                             onTap: () {
                                      //                                               Navigator.pop(context);
                                      //                                             },
                                      //                                             child: Padding(
                                      //                                               padding: EdgeInsets.all(8.0),
                                      //                                               child: SvgPicture.asset(
                                      //                                                 "images/cross.svg",
                                      //                                                 color: Colors.black26,
                                      //                                               ),
                                      //                                             ),
                                      //                                           ),
                                      //                                         ),
                                      //                                         Spacer(flex: 2),
                                      //                                         Align(
                                      //                                           alignment: Alignment.center,
                                      //                                           child: Container(
                                      //                                               child: Text(
                                      //                                             'Subscription Plan',
                                      //                                             textScaleFactor: 1.0,
                                      //                                             style: TextStyle(color: Color(0xff2B2B2B), fontSize: 18.0, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                                      //                                           )),
                                      //                                         ),
                                      //                                         Spacer(flex: 2),
                                      //                                       ],
                                      //                                     ),
                                      //                                   ),
                                      //                                   SizedBox(
                                      //                                     height:
                                      //                                         14,
                                      //                                   ),
                                      //                                   Divider(
                                      //                                     thickness:
                                      //                                         1,
                                      //                                     color:
                                      //                                         Color(0xffECEDEF),
                                      //                                   ),
                                      //                                   Container(
                                      //                                     margin: EdgeInsets.only(
                                      //                                         left: 15.0,
                                      //                                         top: 10.0),
                                      //                                     child:
                                      //                                         Text(
                                      //                                       "CURRENT ACTIVE PLAN",
                                      //                                       textScaleFactor:
                                      //                                           1.0,
                                      //                                       style:
                                      //                                           TextStyle(
                                      //                                         color: Color(0xc0545468),
                                      //                                         fontSize: 11.0,
                                      //                                         fontFamily: 'Inter',
                                      //                                         fontWeight: FontWeight.w600,
                                      //                                       ),
                                      //                                     ),
                                      //                                   ),
                                      //                                   Container(
                                      //                                     margin: EdgeInsets.only(
                                      //                                         left: 15.0,
                                      //                                         right: 15.0,
                                      //                                         top: 15.0),
                                      //                                     height:
                                      //                                         MediaQuery.of(context).size.height * 0.30,
                                      //                                     decoration:
                                      //                                         BoxDecoration(
                                      //                                       color:
                                      //                                           Colors.white,
                                      //                                       border:
                                      //                                           Border.all(color: Color(0xffC8CEE4)),
                                      //                                       borderRadius:
                                      //                                           BorderRadius.circular(
                                      //                                         6.0,
                                      //                                       ),
                                      //                                     ),
                                      //                                     child:
                                      //                                         Column(
                                      //                                           mainAxisAlignment: MainAxisAlignment.start,
                                      //                                       crossAxisAlignment: CrossAxisAlignment.start,
                                      //                                       children: [
                                      //                                         Row(
                                      //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //                                           crossAxisAlignment: CrossAxisAlignment.start,
                                      //                                           children: [
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(left: 15.0, top: 18.0),
                                      //                                               child: Text(
                                      //                                                 'Basic',
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff313D4F),
                                      //                                                   fontSize: 16.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                             Column(
                                      //                                               children: [
                                      //                                                 Container(
                                      //                                                   margin: EdgeInsets.only(right: 15.0, top: 10.0),
                                      //                                                   child: Text(
                                      //                                                     planpojo?.imsiDetail!.amount.toString()??"" ,
                                      //                                                     style: TextStyle(
                                      //                                                       color: Color(0xff313D4F),
                                      //                                                       fontSize: 18.0,
                                      //                                                       fontFamily: 'Inter',
                                      //                                                       fontWeight: FontWeight.w600,
                                      //                                                     ),
                                      //                                                   ),
                                      //                                                 ),
                                      //                                                 Container(
                                      //                                                   margin: EdgeInsets.only(right: 15.0, bottom: 3.0),
                                      //                                                   child: Text(
                                      //                                                     'per month',
                                      //                                                     style: TextStyle(
                                      //                                                       color: Color(0xff8798B0),
                                      //                                                       fontSize: 11.0,
                                      //                                                       fontFamily: 'Inter',
                                      //                                                       fontWeight: FontWeight.w400,
                                      //                                                     ),
                                      //                                                   ),
                                      //                                                 ),
                                      //                                               ],
                                      //                                             )
                                      //                                           ],
                                      //                                         ),
                                      //                                         Divider(
                                      //                                           thickness: 1,
                                      //                                           color: Color(0xffC8CEE4),
                                      //                                         ),
                                      //
                                      //                                         Container(
                                      //                                           margin: EdgeInsets.only(left: 4.0, top: 12.0),
                                      //                                           child: Align(
                                      //                                             alignment: Alignment.center,
                                      //                                             child: Text(
                                      //                                               planpojo?.imsiDetail!.description!.string??"",
                                      //                                               style: TextStyle(
                                      //                                                 color: Color(0xff647389),
                                      //                                                 fontSize: 13.0,
                                      //                                                 fontFamily: 'Inter',
                                      //                                                 fontWeight: FontWeight.w500,
                                      //                                               ),
                                      //                                             ),
                                      //                                           ),
                                      //                                         ),
                                      //
                                      //                                         SizedBox(
                                      //                                           height: 10,
                                      //                                         ),
                                      //                                         Divider(
                                      //                                           thickness: 1,
                                      //                                           color: Color(0xffC8CEE4),
                                      //                                         ),
                                      //
                                      //
                                      //                                         Row(
                                      //                                           children: [
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(left: 10.0, top: 5.0),
                                      //                                               child: Text(
                                      //                                                 'Phone No :',
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff8798B0),
                                      //                                                   fontSize: 10.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(
                                      //                                                 left: 3.0,
                                      //                                                 top: 5.0,
                                      //                                               ),
                                      //                                               child: Text(
                                      //                                                 planpojo?.imsiDetail!.msisdn??"",
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff647389),
                                      //                                                   fontSize: 10.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                           ],
                                      //                                         ),
                                      //
                                      //                                         Row(
                                      //                                           children: [
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(left: 10.0, top: 8.0),
                                      //                                               child: Text(
                                      //                                                 'Netwark Operator :',
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff8798B0),
                                      //                                                   fontSize: 10.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(left: 3.0, top: 10.0, right: 10.0),
                                      //                                               child: Text(
                                      //                                                 planpojo?.imsiDetail!.networkName??"",
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff647389),
                                      //                                                   fontSize: 12.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                           ],
                                      //                                         ),
                                      //
                                      //                                         Row(
                                      //                                           children: [
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(left: 10.0, top: 8.0),
                                      //                                               child: Text(
                                      //                                                 'Plan Activation Date :',
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff8798B0),
                                      //                                                   fontSize: 10.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(left: 3.0, top: 10.0, right: 4),
                                      //                                               child: Text(
                                      //                                                 planpojo?.imsiDetail!.activationDate!.string??"",
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff647389),
                                      //                                                   fontSize: 10.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                           ],
                                      //                                         ),
                                      //
                                      //                                         Row(
                                      //                                           children: [
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(left: 10.0, top: 10.0),
                                      //                                               child: Text(
                                      //                                                 'Plan Expiry Date :',
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff8798B0),
                                      //                                                   fontSize: 10.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                             Container(
                                      //                                               margin: EdgeInsets.only(left: 3.0, top: 10.0, right: 10.0),
                                      //                                               child: Text(
                                      //                                                 planpojo?.imsiDetail!.expiryDate!.string??"",
                                      //                                                 style: TextStyle(
                                      //                                                   color: Color(0xff647389),
                                      //                                                   fontSize: 10.0,
                                      //                                                   fontFamily: 'Inter',
                                      //                                                   fontWeight: FontWeight.w500,
                                      //                                                 ),
                                      //                                               ),
                                      //                                             ),
                                      //                                           ],
                                      //                                         )
                                      //
                                      //                                       ],
                                      //                                     ),
                                      //                                   ),
                                      //                                 ],
                                      //                               ),
                                      //                             ),
                                      //                           );
                                      //                         },
                                      //                         child: Align(
                                      //                             alignment:
                                      //                                 Alignment
                                      //                                     .center,
                                      //                             child: Text(
                                      //                               "Plan",
                                      //                               style: TextStyle(
                                      //                                   color: Color(
                                      //                                       0xffFFFFFF),
                                      //                                   fontFamily:
                                      //                                       'Inter',
                                      //                                   fontWeight:
                                      //                                       FontWeight
                                      //                                           .w600,
                                      //                                   fontSize:
                                      //                                       12.0),
                                      //                             )),
                                      //                       );
                                      //                     } else {
                                      //                        return null!;
                                      //                     }
                                      //                   }),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ],
                                      child: InkWell(
                                        onTap: () {
                                          if (index == 1) {
                                            setState(() {
                                              //  first=false;
                                              //  second=true;
                                            });
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 10.0,
                                              bottom: 3),
                                          height: 74.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.99,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              6.0,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xd000000),
                                                offset: const Offset(
                                                  0.0,
                                                  4.0,
                                                ),
                                                blurRadius: 4.0,
                                                spreadRadius: 0.0,
                                              ), //BoxShadow
                                            ],
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              //  first=false;
                                              //   second=true;

                                              //  first=false;
                                              // second=true;
                                            },
                                            child: Row(
                                              children: [
                                                Visibility(
                                                  visible: first ? true : false,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 10.0,
                                                            bottom: 8.0),
                                                        child: SvgPicture.asset(
                                                            detail.currentStatus ==
                                                                    "USED"
                                                                ? 'images/sim_card.svg'
                                                                : 'images/new_sim_aloocated.svg'),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            14.0,
                                                                        left:
                                                                            10.0),
                                                                child: Text(
                                                                  'ICCID:',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0x7F050505),
                                                                      fontSize:
                                                                          10.0,
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            14.0,
                                                                        left:
                                                                            1.0),
                                                                child: Text(
                                                                  detail.iccidNo.toString()
                                                                      ,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0x7F050505),
                                                                      fontSize:
                                                                          10.0,
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: false,
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: 14.0,
                                                                      left:
                                                                          5.0),
                                                                  child: Text(
                                                                    'MSISDN:',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0x7F050505),
                                                                        fontSize:
                                                                            10.0,
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: false,
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: 14.0,
                                                                      left: 1.0,
                                                                      right:
                                                                          7.0),
                                                                  child: Text(
                                                                    '$msisdn',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0x7F050505),
                                                                        fontSize:
                                                                            10.0,
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 5.0,
                                                                    left: 10.0),
                                                            child: Text(
                                                              detail.simTypeName.toString() +
                                                                  "-" +
                                                                  detail
                                                                      .serviceScopeName.toString() +
                                                                  "-" +
                                                                  detail
                                                                      .networkBandName.toString() +
                                                                  "-" +
                                                                  detail
                                                                      .primaryNetworkName.toString(),
                                                              // "$simTypename-$serviceScopeName-$networkBandName-$simProfileName-$primaryNetworkType-$secondaryNetworkType",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xcd2b2b2b),
                                                                  fontSize:
                                                                      10.0,
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            5.0,
                                                                        left:
                                                                            10.0),
                                                                child: Text(
                                                                  'Sim 1 N0:',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0x80050505),
                                                                      fontSize:
                                                                          10.0,
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            5.0,
                                                                        left:
                                                                            1.0),
                                                                child: Text(
                                                                  '+91' +
                                                                      detail
                                                                          .msisdn1
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0x80050505),
                                                                      fontSize:
                                                                          10.0,
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            5.0,
                                                                        left:
                                                                            3.0),
                                                                child: Text(
                                                                  'Sim 2 No:',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0x80050505),
                                                                      fontSize:
                                                                          10.0,
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            5.0,
                                                                        left:
                                                                            1.0),
                                                                child: Text(
                                                                  '+91 7807309591',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0x80050505),
                                                                      fontSize:
                                                                          10.0,
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: first ? false : true,
                                                  child: Flexible(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8.0,
                                                                    left: 10.0,
                                                                    bottom:
                                                                        8.0),
                                                            height: 33,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff420098),
                                                              // border: Border.all(color: Color(0xffFFF5F3)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                5.0,
                                                              ),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () {
                                                                if (detail
                                                                        .currentStatus ==
                                                                    "USED") {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              KycDetail(isKyc: null!, list: null!,)));
                                                                } else {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              InstallationScreen(isKyc: null!,)));
                                                                }
                                                              },
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    detail.currentStatus ==
                                                                            "USED"
                                                                        ? "Detail"
                                                                        : "Installation",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xffFFFFFF),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            12.0),
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8.0,
                                                                    left: 10.0,
                                                                    bottom: 8.0,
                                                                    right:
                                                                        10.0),
                                                            height: 33,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff2B2B2B),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                5.0,
                                                              ),
                                                            ),
                                                            child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Plan",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffFFFFFF),
                                                                      fontFamily:
                                                                          'Inter',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12.0),
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> getInventory() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getInventoryStats"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString());

        print(responseJson);
        if (mounted == true) {
          setState(() {
            totalStock =
                int.parse(responseJson['stats']['totalStocks'].toString());
            currentMonhStock = int.parse(
                responseJson['stats']['currentMonthStocks'].toString());

            totalAvailable = int.parse(
                responseJson['stats']['totalAvailableStocks'].toString());
            currentAvailable = int.parse(responseJson['stats']
                    ['currentMonthAvailableStocks']
                .toString());

            totalAllocated = int.parse(
                responseJson['stats']['totalAllocatedStocks'].toString());
            currentAllocatd = int.parse(responseJson['stats']
                    ['currentMonthAllocatedStocks']
                .toString());

            totalExired = int.parse(
                responseJson['stats']['totalExpiredStocks'].toString());
            currentExpire = int.parse(
                responseJson['stats']['currentMonthExpiredStocks'].toString());

            totalBootstrap = int.parse(
                responseJson['stats']['totalBootstrapStocks'].toString());
            currentBootstrap = int.parse(responseJson['stats']
                    ['currentMonthBootstrapStocks']
                .toString());

            totalDeactive = int.parse(
                responseJson['stats']['totalDeactivatedStocks'].toString());
            currentDeactive = int.parse(responseJson['stats']
                    ['currentMonthDeactivatedStocks']
                .toString());
            return;
          });
        }
        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed");
      }
      return value;
    }
  }


  Future<KycPojo?> getInventoryData() async {
    String? searchControl = _searchControl.text.toString();
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getInventoryDetails"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body:jsonEncode({
          "searchText":searchControl,


        }),
      );
       print(searchControl);
      if (response.statusCode == 200) {
        var res = response.body;
       // print(searchControl);
        print(res);

          KycPojo kycPojo = KycPojo.fromJson(json.decode(res));
          return kycPojo;

      } else {
        print("failed");
      }
    }
  }

  Future<String?> getSimType() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getSimTypes"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({
          "isFilter": 1,
          "parentSimTypeID": _mySelection
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body.toString());
        List<dynamic> mdata = map["simTypes"];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setInt(
            'simType', int.parse(map['simTypes'][0]['simTypeID'].toString()));
        setState(() {
          data = mdata;
        });
        //print("value od" +_mySelection);
        print('hello' + mdata[0]['name']);
        final stringRes = JsonEncoder.withIndent('').convert(mdata);
        print(stringRes);
      } else {
        print("failed responce hydra data");
      }
      return value;
    }
  }

  Future<String?> getNetworkType() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getNetworkProviders"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"isFilter": 1}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body.toString());
        List<dynamic> mdata = map["networkProvider"];
        setState(() {
          dataNetwark = mdata;
        });
        print(mdata);
        final stringRes = JsonEncoder.withIndent('').convert(mdata);
        print(stringRes);
      } else {
        print("failed responce data");
      }
      return value;
    }
  }

  Future<String?> getSimType1() async {
    String? value1;
    if (value1 == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getSimTypes"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"isFilter": 1, "parentSimTypeID": _mySelection}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body.toString());
        List<dynamic> mdata1 = map["simTypes"];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setInt(
            'simType', int.parse(map['simTypes'][0]['simTypeID'].toString()));
        setState(() {
          dataScope = mdata1;
        });
        //print("value od" +_mySelection);
        print('hello' + mdata1[0]['name']);
        final stringRes = JsonEncoder.withIndent('').convert(mdata1);
        print(stringRes);
      } else {
        print("failed responce scope data");
        // print("value od" +_mySelection);
      }
      return value1;
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

  Future<PlanPojo?> geSubscription() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getImsiDetail"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"imsi": imsi}),
      );
      if (response.statusCode == 200) {
        var res = response.body;
        print('gggggggg');
        print(res);

        print(res);
        PlanPojo planPojo = PlanPojo.fromJson(json.decode(res));
        return planPojo;

        final stringRes = JsonEncoder.withIndent('').convert(res);
        print(stringRes);
      } else {
        print("failed");
      }
      // return value;
    }
  }

  _widgetList() {


  }

   filter(){

   }


}
