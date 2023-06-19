import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'notificatio_responce/Notifcation_data.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  String token="";
  String name="";
  String account="";
  String user="";
  bool condition = true;
  String title="";
  String message="";
  String duration="";
  // List notificationData = List();
  List<dynamic> notificationData = [];

  var type;


  Future<NotificationData?> getNotification() async {
    String? value;
    if(value==null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getNotifications"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },

      );
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body.toString()) as Map<String, dynamic>;
       // NotificationData data=
        print(res);

        setState(() {
          title= res['Notifications'][0]['title'];
          message= res['Notifications'][0]['message'];
          duration= res['Notifications'][0]['duration'];
        });
        final stringRes = JsonEncoder.withIndent('').convert(res);
        print(stringRes);
      } else {
        print("failed");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () => condition = false);

    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      getNotification();
    });
    getToken();
  }

  @override
  void dispose() {
    super.dispose();
    getNotification();
    getToken();
  }

  void getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
        name = sharedPreferences.getString('user')!;
        account = sharedPreferences.getString('account')!;
        user = sharedPreferences.getString('userid')!;
      });
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    final List<String> items =
    new List<String>.generate(10, (i) => "item  ${i + 1}");
    final double scaleFactor = MediaQuery
        .of(context)
        .textScaleFactor;
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
                  'All Tickets',
                  style: TextStyle(
                      color: Color(0xff2B2B2B),
                      fontSize: 18.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                backgroundColor: Color(0xffFFFFFF),
                leading: Padding(
                    padding: EdgeInsets.all(18),
                    child: SvgPicture.asset('images/forgot_back.svg')),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context,true);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 20, 8),
                      child: SvgPicture.asset(
                        'images/bell_icon.svg',
                        height: 21.0,
                        width: 16.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 15, 8),
                      child: SvgPicture.asset(
                        'images/message.svg',
                        height: 20.0,
                        width: 20.0,
                      ),
                    ),
                  ),

                  // Image.asset('images/notification_appbar.png'),
                ],
                elevation: 0.1,
              ),
            ),
          ),
          //  drawer: Drawer(),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 28.0),
            child: FloatingActionButton(
              backgroundColor: Color(0xff6B87EB),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) =>
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.54,
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
                                children: [
                                  Container(
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
                                  Spacer(flex: 2),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                        child: Text(
                                          'Create a new ticket ',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 18.0,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  Spacer(flex: 2),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(height: 12.0),
                                      Container(
                                        margin: EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          "Subject",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 13.0,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        height: 42.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                          Border.all(color: Color(0xffDFE0E6)),
                                          borderRadius: BorderRadius.circular(
                                            6.0,
                                          ),
                                        ),
                                        child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              textScaleFactor: 1.0 *
                                                  MediaQuery.textScaleFactorOf(
                                                      context)),
                                          child: TextFormField(
                                            textAlignVertical:
                                            TextAlignVertical.bottom,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 16.0, left: 10.0),
                                                border: InputBorder.none,
                                                hintText: 'Enter subject',
                                                hintStyle: TextStyle(
                                                    fontSize: 13.0 /
                                                        scaleFactor,
                                                    color: Color(0xff999CAB),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w500)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Container(
                                        margin: EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          "Discription",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 13.0,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15.0, right: 15.0),
                                        height: 131.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                          Border.all(color: Color(0xffDFE0E6)),
                                          borderRadius: BorderRadius.circular(
                                            6.0,
                                          ),
                                        ),
                                        child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              textScaleFactor: 1.0 *
                                                  MediaQuery.textScaleFactorOf(
                                                      context)),
                                          child: TextFormField(
                                            textAlignVertical:
                                            TextAlignVertical.bottom,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 16.0, left: 10.0),
                                                border: InputBorder.none,
                                                hintText:
                                                'Write some description here....',
                                                hintStyle: TextStyle(
                                                    fontSize: 13.0 /
                                                        scaleFactor,
                                                    color: Color(0xff999CAB),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w500)),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          //  width: 327.0,
                                          margin: EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 9.0,
                                              bottom: 20.0),
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Color(0xff420098),
                                            //  border: Border.all(color: Color(0xffACABB3)),
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Create",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    color: Color(0xffFFFFFF),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w600),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 294.0,
                      margin: EdgeInsets.only(left: 15.0, top: 21.0),
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
                              1.0,
                              0.0,
                            ),
                            blurRadius: 3.0,
                            spreadRadius: -3.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: TextFormField(
                        cursorColor: Color(0xcc2b2b2b),
                        style: TextStyle(color: Color(0xcc2b2b2b)),
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              bottom: 16.0,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                "images/search_icons.svg",
                                width: 13.0,
                                height: 14.0,
                                color: Color(0xff9F9F9F),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Search for tickets',
                            hintStyle: TextStyle(
                                fontSize: 11.0,
                                color: Color(0xff9F9F9F),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400)),
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
                        builder: (context) =>
                            Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.55,
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
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              "images/cross.svg",
                                              color: Colors.black26,
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
                                                    fontWeight: FontWeight
                                                        .w600),
                                              )),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                              child: Text(
                                                'Clear',
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    color: Color(0xffE13939),
                                                    fontSize: 14.0,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w400),
                                              )),
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

                                ],
                              ),
                            ),
                      );
                    },
                    child: Container(
                      width: 42.0,
                      margin: EdgeInsets.only(right: 15.0, top: 21.0),
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
                          )),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              left: 15.0,
                            ),
                            child: Text(
                              "TODAY",
                              style: TextStyle(
                                  color: Color(0xff565E6B),
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter'),
                            ),
                          ),
                          Container(
                            //height: 300,
                            child: ListView.builder(
                                itemCount: 5,
                                //padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      if (index == 1) {}
                                      if (index == 2) {}
                                    },
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.99,
                                      margin: EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 10.0,
                                          bottom: 3),
                                      height: 97.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 18.0, top: 15.0),
                                                  child: SvgPicture.asset(
                                                    'images/mail_icon.svg',
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.0, top: 12.0),
                                                  child: Text(
                                                    "My sim is not activated",
                                                    style: TextStyle(
                                                        color:
                                                        Color(0xff2B2B2B),
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontSize: 13.0),
                                                  )),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Container(
                                                  margin:
                                                  EdgeInsets.only(left: 35),
                                                  child: SvgPicture.asset(
                                                    'images/group.svg',
                                                    height: 8.0,
                                                    width: 14.0,
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 12.0,
                                                      bottom: 1.0,
                                                      left: 1.0),
                                                  child: Text(
                                                    "HMACSHA256",
                                                    style: TextStyle(
                                                        color:
                                                        Color(0xff6B87EB),
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 11.0),
                                                  )),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 45.0, top: 2),
                                            child: Text(
                                              "Lorem ipsum dolor sit amet,consectetur\nadipiscing elit,sed do eiusmod tempor incidident.",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Color(0xff788395),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 41,
                                                margin: EdgeInsets.only(
                                                    left: 45.0,
                                                    right: 10.0,
                                                    bottom: 8,
                                                    top: 8.0),
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffEDEEF3),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                    4.0,
                                                  ),
                                                ),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Low",
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xff8F94A0),
                                                          fontSize: 11.0,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    )),
                                              ),
                                              Container(
                                                width: 41,
                                                margin: EdgeInsets.only(
                                                    left: 0.0,
                                                    right: 10.0,
                                                    bottom: 8.0,
                                                    top: 8.0),
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffE5FFEA),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                    4.0,
                                                  ),
                                                ),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Open",
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xff5DAF6A),
                                                          fontSize: 11.0,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    )),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 0.0,
                                                      right: 0.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                                  child: SvgPicture.asset(
                                                    'images/clock.svg',
                                                  )),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 10.0,
                                                    bottom: 8.0,
                                                    top: 8.0),
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  //border: Border.all(color: Color(0xffACABB3)),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                    4.0,
                                                  ),
                                                ),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "11.30 AM",
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xffD2D3D9),
                                                          fontSize: 11.0,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0, top: 9.0),
                            child: Text(
                              "YESTERDAY",
                              style: TextStyle(
                                  color: Color(0xff565E6B),
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter'),
                            ),
                          ),
                          Container(
                            //height: 300,
                            child: ListView.builder(
                                itemCount: 5,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      if (index == 1) {}
                                      if (index == 2) {}
                                    },
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(bottom: 4.0, top: 10),
                                      child: Container(
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.99,
                                        margin: EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          //  top: 12.0,
                                        ),
                                        height: 97.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
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
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 18.0, top: 15.0),
                                                    child: SvgPicture.asset(
                                                      'images/mail_icon.svg',
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10.0, top: 12.0),
                                                    child: Text(
                                                      "My sim is not activated",
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xff2B2B2B),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontSize: 13.0),
                                                    )),
                                                Spacer(
                                                  flex: 1,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 35),
                                                    child: SvgPicture.asset(
                                                      'images/group.svg',
                                                      height: 8.0,
                                                      width: 14.0,
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 12.0,
                                                        bottom: 1.0,
                                                        left: 1.0),
                                                    child: Text(
                                                      "HMACSHA256",
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xff6B87EB),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize: 11.0),
                                                    )),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 45.0, top: 2),
                                              child: Text(
                                                "Lorem ipsum dolor sit amet,consectetur\nadipiscing elit,sed do eiusmod tempor incidident.",
                                                style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: Color(0xff788395),
                                                    fontFamily: 'Inter',
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: 41,
                                                  margin: EdgeInsets.only(
                                                      left: 45.0,
                                                      right: 10.0,
                                                      bottom: 8,
                                                      top: 8.0),
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffEDEEF3),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      4.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                      alignment:
                                                      Alignment.center,
                                                      child: Text(
                                                        "Low",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff8F94A0),
                                                            fontSize: 11.0,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      )),
                                                ),
                                                Container(
                                                  width: 41,
                                                  margin: EdgeInsets.only(
                                                      left: 0.0,
                                                      right: 10.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffE5FFEA),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      4.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                      alignment:
                                                      Alignment.center,
                                                      child: Text(
                                                        "Open",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff5DAF6A),
                                                            fontSize: 11.0,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      )),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 0.0,
                                                        right: 0.0,
                                                        bottom: 8.0,
                                                        top: 8.0),
                                                    child: SvgPicture.asset(
                                                      'images/clock.svg',
                                                    )),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 2.0,
                                                      right: 10.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    //border: Border.all(color: Color(0xffACABB3)),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      4.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                      alignment:
                                                      Alignment.center,
                                                      child: Text(
                                                        "11.30 AM",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffD2D3D9),
                                                            fontSize: 11.0,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight
                                                                .w400),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
