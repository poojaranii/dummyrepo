// ignore_for_file: missing_return

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'notification_screen/notificatio_responce/Notifcation_data.dart';

class Hello extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Hello> {
  var myMenuItems = <String>[
    'Read all',

  ];

  void onSelect(item) {
    switch (item) {
      case 'Read all':
        print('Home clicked');
        break;
    }
  }
  // ignore: non_constant_identifier_names
  var type_icon;
  int _radioValue = 0;
  bool value = false;
  String token = "";
  String? countryname, message;
  String? _mySelection;
  String selectedSpinnerItem = 'Eliseo@gardner.biz';
  List data = List as List;
  Future? myFuture;
  bool condition = true;
  var type;

  // var data;
  List<String> countries = ["Nepal", "India", "USA"];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () => condition = false);

    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      getNotification();
      getNotificationRead();
      getComplaint();
    });
    getToken();
  }

  Future<NotificationData?> getNotificaon() async {
    String? value;
    if (value == null) {
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
        final stringRes = JsonEncoder.withIndent('').convert(res);
        print(stringRes);
      } else {
        print("failed");
      }
    }
  }

  @override
  void didChangeDependencies() {
    getToken();
    getNotification();
    super.didChangeDependencies();
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
    final List<String> items =
    new List<String>.generate(10, (i) => "item  ${i + 1}");
    return
      Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
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

              title: Text('Notifications',
                style: TextStyle(color: Color(0xff2B2B2B), fontSize: 18.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600),),
              centerTitle: true,
              backgroundColor: Color(0xffF8F8F8),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context, true);
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

                Container(
                  margin: EdgeInsets.fromLTRB(0, 8, 15, 8),
                  child: PopupMenuButton(
                      itemBuilder: (context) =>
                      [
                        PopupMenuItem(child:
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  getNotificationRead();
                                });

                              },
                              child: Text('Read all', style: TextStyle(
                                  color: Color(0xff788395), fontSize: 13.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400),),
                            ),
                          ],
                        ))
                      ],
                      child: SvgPicture.asset(
                        'images/notification_icon.svg', height: 20.0,
                        width: 20.0,)),
                ),

                // Image.asset('images/notification_appbar.png'),
              ],
              elevation: 0.1,
            ),
          ),
        ),
        body: Container(

          width: double.infinity,
          height: double.infinity,

          child: Padding(
            padding: EdgeInsets.only(top: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15.0,),
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
                    child: FutureBuilder<NotificationData?>(
                        future: getNotification(),
                        // ignore: missing_return
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Notifications>? list = snapshot.data!.notifications;
                            return list == null ? Container() : ListView
                                .builder(
                                itemCount: list.length,
                                shrinkWrap: true,

                                physics:
                                NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Notifications user = list[index];


                                  if (type == "REQUEST") {

                                  }  if (type == 'Success') {

                                  }

                                  return Slidable(

                                    // secondaryActions: <Widget>[
                                    //   Container(
                                    //     margin: EdgeInsets.only(top: 8,bottom: 10.0),
                                    //     height: 70.0,
                                    //     width: 20,
                                    //
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(
                                    //         60.0,
                                    //       ),),
                                    //     child: IconSlideAction(
                                    //         iconWidget: SvgPicture.asset(
                                    //           'images/read.svg',
                                    //           width: 8.0,
                                    //           height: 14.0,
                                    //         ),
                                    //         color: Color(0xff27A360),
                                    //         closeOnTap: false,
                                    //         //list will not close on tap
                                    //         onTap: () {
                                    //           print(
                                    //               "More ${items[index]} is Clicked");
                                    //         }
                                    //     ),
                                    //   )
                                    // ],
                                    child: InkWell(
                                      onTap: () {
                                        if (index == 1) {}
                                        if (index == 2) {}
                                      },
                                      child: Container(
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.99,
                                        margin: EdgeInsets.only(
                                            left: 15.0,
                                            right: 15.0,
                                            top: 10.0,
                                            bottom: 3
                                        ),
                                        height: 74.0,

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
                                          mainAxisAlignment: MainAxisAlignment.start,
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
                                                child:type_icon=="Success" ?  SvgPicture.asset('images/dustbine.svg',) : SvgPicture.asset('images/bottom_kyc_icon.svg',)),
                                                Container(margin: EdgeInsets.only(
                                                        left: 10.0, top: 12.0),
                                                    child: Text(
                                                      user.title.toString(),
                                                      style: TextStyle(
                                                          color: Color(0xff2B2B2B),
                                                          fontFamily: 'Inter',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 13.0),
                                                    )),
                                                Spacer(
                                                  flex: 1,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 0.0,
                                                        right: 0.0,
                                                        bottom: 8.0,
                                                        top: 8.0),
                                                    child: SvgPicture.asset(
                                                      'images/clock.svg',)),
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
                                                      alignment: Alignment
                                                          .center,
                                                      child: Text(
                                                        user.duration.toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffD2D3D9),
                                                            fontSize: 11.0,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                            FontWeight.w400),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 218,
                                              margin:
                                              EdgeInsets.only(
                                                  left: 45.0, top: 2),
                                              child: Text(
                                                user.message.toString(),
                                                style: TextStyle(
                                                    fontSize: 11.0,
                                                    color: Color(0xff788395),
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight
                                                        .w400),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),

                                    ),
                                    //actionPane: SlidableDrawerActionPane(),
                                  );
                                }
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }
                    ),
                  ),

                  Visibility(
                    visible: false,
                    child: Container(
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
                  ),
                  Visibility(
                    visible: false,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                          itemCount: 10,
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
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.99,
                                margin: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 10.0,
                                    bottom: 3
                                ),
                                height: 74.0,

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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                            child:  type_icon=="ACTIVE" ?  SvgPicture.asset('images/dustbine.svg',) : SvgPicture.asset('images/bottom_kyc_icon.svg',)),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 10.0, top: 12.0),
                                            child: Text(
                                              "Title",
                                              style: TextStyle(
                                                  color: Color(0xff2B2B2B),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13.0),
                                            )),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0,
                                                right: 0.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: SvgPicture.asset(
                                              'images/clock.svg',)),
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
                                                    color: Color(0xffD2D3D9),
                                                    fontSize: 11.0,
                                                    fontFamily: 'Inter',
                                                    fontWeight:
                                                    FontWeight.w400),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                      EdgeInsets.only(left: 45.0, top: 2),
                                      child: Text(
                                        "Thank you for the order.Your order no is\nORDR000024. Total quantity : 2",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            color: Color(0xff788395),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            );
                          }),
                    ),
                  ),
                ],

              ),
            ),
          ),
        ),
      );
  }

  Future<NotificationData?> getNotification() async {
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
        var res = response.body;

        print(res);
        NotificationData notificationData = NotificationData.fromJson(json.decode(res));

        return notificationData;

        final stringRes = JsonEncoder.withIndent('').convert(res);
        print(stringRes);
      } else {
        print("failed");
      }
    }
  }

  Future<NotificationData?> getNotificationRead() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/markNotificationRead"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({"logID": 1,
        }),
      );
      var responseJson = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {

        print(responseJson);

        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed");
      }
    }
  }

  Future<void> getComplaint() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getTicketDetails"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        }

      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString());
        if (response.statusCode == 200) {
          final stringRes = JsonEncoder.withIndent('').convert(responseJson);
          print(stringRes);
        } else {
          print("failed");
        }
      }
    }
  }
}


