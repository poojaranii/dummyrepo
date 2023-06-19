import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../otp_screen/OtpScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MobileScreen extends StatefulWidget {


  @override
  _MobileState createState() => _MobileState();
}

class _MobileState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {

    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          backgroundColor: Color(0xffF8F8F8),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              //flex: 1,
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 58.0, left: 24.0),
                  child: SvgPicture.asset(
                    'images/forgot_back.svg',
                    width: 8.0,
                    height: 14.0,
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),

              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 40.0, right: 41.0),
                            child: Image.asset(
                              'images/mobile_logo.png',

                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Container(

                          margin: EdgeInsets.only(left: 24.0),
                          child: Text(
                            "Enter Mobile No",
                            style: TextStyle(fontSize: 24.0, color: Color(0xff2B2B2B),fontWeight: FontWeight.w600,fontFamily: 'Inter'),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          // width: 301.0,
                          height: 20.0,
                          margin: EdgeInsets.only(left: 24.0),
                          child: Text(
                            "Enter mobile no associate with your account.",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xad353750),fontWeight: FontWeight.w500,fontFamily: 'Inter'
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 31.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 24.0, right: 24.0),
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffACABB3)),
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.bottom,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 16.0, left: 10.0),
                                prefixIcon: Container(
                                    padding: EdgeInsets.only(left: 4,right: 6),
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(color: Color(0xffACABB3))),
                                    ),
                                    child: SvgPicture.asset(
                                      "images/mobile_country_icon.svg",width: 55.0,height: 18.0,
                                    )),
                                border: InputBorder.none,
                                hintText: 'Enter your mobile number',
                                hintStyle:
                                TextStyle(fontSize: 13.0, color: Color(0xb5686a8a),fontWeight: FontWeight.w500,fontFamily: 'Inter')),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter valid emailid';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(
                          height: 17,
                        ),

                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OtpScreen()),);

                          },
                          child: Container(
                            //  width: 327.0,
                            margin: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 118.0),
                            height: 48,
                            decoration: BoxDecoration(
                              color: Color(0xff420098),
                              border: Border.all(color: Color(0xff420098)),
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                            ),

                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Enter OTP",
                                  style: TextStyle(color: Color(0xffFFFFFF),fontWeight: FontWeight.w600,fontFamily: 'Inter'),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
