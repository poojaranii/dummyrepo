
import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:ich/tooltip.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Editor extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Editor> {
   late Timer _time;
  String date = "";
  String token="";
  int _radioValue = 0;
  DateTime selectedDate = DateTime.now();
  bool condition = true;
  @override
  void initState() {
    super.initState();

    _startTimer();

  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
    print("first" + value.toString() + "radiovalue" + _radioValue.toString());
  }


  void _startTimer() {
    _time = Timer.periodic(Duration(seconds: 5), (Timer t) {
      print('yaaay');
      print('dhoni');
      t.cancel();
    });
  }


    @override
     Widget build(BuildContext context) {

      return Scaffold(

        body: Center(
          child: InkWell(
            onTap: (){
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Container(
                  height:
                  MediaQuery.of(context).size.height * 0.57,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft:
                      const Radius.circular(12.0),
                      topRight:
                      const Radius.circular(12.0),
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 15.0,
                            left: 15.0,
                            right: 15.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: new BoxDecoration(
                                color: Color(0xffEFF0F2),
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: (){
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
                              alignment:
                              Alignment.center,
                              child: Container(
                                  child: Text(
                                    'Proof of identity',textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: Color(
                                            0xff2B2B2B),
                                        fontSize: 18.0,
                                        fontFamily:
                                        'Inter',
                                        fontWeight:
                                        FontWeight
                                            .w600),
                                  )),
                            ),
                            Align(
                              alignment:
                              Alignment.center,
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    child: Text(
                                      'Cancel',textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Color(
                                              0xffE13939),
                                          fontSize: 14.0,
                                          fontFamily:
                                          'Inter',
                                          fontWeight:
                                          FontWeight
                                              .w400),
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
                                  EdgeInsets.only(
                                      left: 15.0),
                                  child: Text(
                                    "CHOOSE YOUR IDENTITY TYPE",textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: Color(
                                            0xbe545468),
                                        fontSize:
                                        11.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),

                                StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return
                                        Row(
                                          children: [
                                            new Radio(
                                              value: 0,
                                              groupValue:
                                              _radioValue,
                                              onChanged:
                                                  (value) {
                                                setState(() {
                                                  _radioValue =
                                                      value as int;
                                                });
                                                print("radiofirst" +
                                                    value
                                                        .toString() +
                                                    "radiovalue" +
                                                    _radioValue
                                                        .toString());
                                                _handleRadioValueChange(
                                                    value as int);
                                              },
                                            ),
                                            new Text(
                                              'Aadhaar Card',textScaleFactor: 1.0,
                                              style: new TextStyle(
                                                  fontSize:
                                                  13.0,fontFamily:
                                              'Inter',
                                                  fontWeight:
                                                  FontWeight
                                                      .w600,
                                                  color: Color(
                                                      0xff848B99)),
                                            ),
                                            new Radio(
                                              value: 1,
                                              groupValue:
                                              _radioValue,
                                              onChanged:
                                                  (value) {
                                                setState(() {
                                                  _radioValue =
                                                      value as int;
                                                });
                                                print("radiosecond " +
                                                    value
                                                        .toString() +
                                                    "radiovalue " +
                                                    _radioValue
                                                        .toString());
                                                _handleRadioValueChange(
                                                    value as int);
                                              },
                                            ),
                                            new Text(
                                              'PAN Card',textScaleFactor: 1.0,
                                              style: new TextStyle(
                                                  fontSize:
                                                  13.0,fontFamily:
                                              'Inter',
                                                  fontWeight:
                                                  FontWeight
                                                      .w600,
                                                  color: Color(
                                                      0xff848B99)),
                                            ),
                                            new Radio(
                                              value: 2,
                                              groupValue:
                                              _radioValue,
                                              onChanged:
                                                  (value) {
                                                setState(() {
                                                  _radioValue =
                                                      value as int;
                                                });
                                                print("radiosecond " +
                                                    value
                                                        .toString() +
                                                    "radiovalue " +
                                                    _radioValue
                                                        .toString());
                                                _handleRadioValueChange(
                                                    value as int);
                                              },
                                            ),
                                            Expanded(
                                              child: new Text(
                                                'Driving License',textScaleFactor: 1.0,
                                                style: new TextStyle(
                                                    fontSize:
                                                    13.0,fontFamily:
                                                'Inter',
                                                    fontWeight:
                                                    FontWeight
                                                        .w600,
                                                    color: Color(
                                                        0xff848B99)),
                                              ),
                                            ),
                                          ],
                                        );
                                    }),



                                Container(
                                  height: 174.0,
                                  //  width: MediaQuery.of(context).size.width*0.80,
                                  color: Color(
                                      0xffFCFCFC),
                                  margin:
                                  const EdgeInsets
                                      .only(
                                      top: 10.0,
                                      left: 15.0,
                                      right: 15.0,
                                      bottom:
                                      15.0),
                                  child: DottedBorder(
                                    borderType:
                                    BorderType
                                        .RRect,
                                    radius: Radius
                                        .circular(6),
                                    color: Color(
                                        0xffDFE0E6),
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                6)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisSize:
                                          MainAxisSize
                                              .max,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top:
                                                  40.0),
                                              child: Align(
                                                  alignment:
                                                  Alignment.bottomCenter,
                                                  child: Image.asset('images/uploadproof.png')),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top:
                                                  9.0),
                                              child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text(
                                                    "Upload proof identity",textScaleFactor: 1.0,
                                                    style: TextStyle(color: Color(0xff767D88), fontSize: 15.0,fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w500),
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top:
                                                  6.0),
                                              child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Text(
                                                    "Support JPG,JPEG,PNG or PDF only",textScaleFactor: 1.0,
                                                    style: TextStyle(color: Color(0xff989EA8), fontSize: 11.0,fontFamily: 'Inter',
                                                        fontWeight: FontWeight.w400),
                                                  )),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(
                                      context)
                                      .size
                                      .width,
                                  margin:
                                  EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 10.0),
                                  height: 42,
                                  decoration:
                                  BoxDecoration(
                                    color:
                                    Colors.white,
                                    border: Border.all(
                                        color: Color(
                                            0xffDFE0E6)),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      5.0,
                                    ),
                                  ),
                                  child:
                                  TextFormField(
                                    textAlignVertical:
                                    TextAlignVertical
                                        .bottom,
                                    keyboardType:
                                    TextInputType
                                        .phone,
                                    decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.only(
                                            bottom:
                                            16.0,
                                            left:
                                            10.0),
                                        border:
                                        InputBorder
                                            .none,
                                        hintText:
                                        'Enter 12 digit aadhaar no',
                                        hintStyle: TextStyle(
                                            fontSize:
                                            13.0, // scaleFactor,
                                            color: Color(
                                                0xff999CAB),fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500)),
                                    validator:
                                        (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter valid emailid';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  //  width: 327.0,
                                  margin:
                                  EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 18.0),
                                  height: 48,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(
                                        0xff420098),
                                    border: Border.all(
                                        color: Color(
                                            0xff420098)),
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
                                        "Submit",textScaleFactor: 1.0,
                                        style: TextStyle(
                                            color: Color(
                                                0xffFFFFFF),fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,fontSize: 15.0),
                                      )),
                                ),

                                SizedBox(height: 17.0,),

                                Row(children: <Widget>[
                                  Expanded(
                                    child: new Container(
                                        margin: const EdgeInsets.only(left: 15.0, right: 8.0),
                                        child: Divider(
                                          color: Color(0xffDFE0E6),
                                          height: 50,
                                        )),
                                  ),

                                  new Container(
                                    width: 25.0,
                                    height: 25.0,
                                    decoration:
                                    new BoxDecoration(
                                      border: Border.all(color: Color(0xffDFE0E6)),
                                      color:
                                      Color(0xffFFFFFF),
                                      shape:
                                      BoxShape.circle,
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("OR",textScaleFactor: 1.0,style: TextStyle(color: Color(0xffDFE0E6),fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,fontSize: 11.0),),
                                    ),
                                  ),


                                  Expanded(
                                    child: new Container(
                                        margin: const EdgeInsets.only(left: 8.0, right: 15.0),
                                        child: Divider(
                                          color: Color(0xffDFE0E6),
                                          height: 50,
                                        )),
                                  ),
                                ]),


                                SizedBox(height: 17,),
                                Container(
                                  // margin: EdgeInsets.only(left: 15.0,right: 15.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(

                                      margin: EdgeInsets.only(
                                          left: 15.0, right: 15.0,bottom: 20.0),
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        border: Border.all(color: Color(0xff2B2B2B)),
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'images/camera.svg',),
                                          SizedBox(
                                            width: 7.0,
                                          ),
                                          Text(
                                            'Take a photo',textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: Color(0xff2B2B2B),
                                                fontSize: 15.0,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
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
              child: Text("hello")),
        ),

      );


  }



}


