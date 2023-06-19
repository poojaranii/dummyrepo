import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bottom_dashboard.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {
  String codeValue = "";

  // var code;

  @override
  void codeUpdated() {
    // print("Update code $code");
    setState(() {
      print('codeUpdated');
    });
  }

  @override
  void initState() {
    listenOtp();
    super.initState();
  }

  void listenOtp() async {
    SmsAutoFill().unregisterListener();
    //listenForCode();
    await SmsAutoFill().listenForCode();
    print('otp lisen called');
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

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
            onTap: (){
        Navigator.of(context).pop();
        },
            child: Container(
              margin: EdgeInsets.only(top: 58.0, left: 24.0, ),
              child: SvgPicture.asset(
                'images/forgot_back.svg',
                width: 8.0,
                height: 14.0,
              ),
            ),
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
                    Container(
                      margin: EdgeInsets.only(left: 80.0, right: 55.0, top: 50.0),
                      child: Image.asset(
                        'images/otp.png',
                        height: 240.0,
                        width: 240.0,
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24.0),
                      child: Text(
                        "OTP Verification",
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xff2B2B2B),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: 263.0,
                      height: 40.0,
                      margin: EdgeInsets.only(left: 24.0),
                      child: Text(
                        "Check your SMS messages.We've sent\nyou the PIN (+91) 987-668-9981.",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xae353750),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Column(
                        children: [
                          PinFieldAutoFill(
                            decoration: UnderlineDecoration(
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              colorBuilder: FixedColorBuilder(Colors.black),
                            ),
                            currentCode: codeValue,
                            codeLength: 5,
                            onCodeSubmitted: (code) {},
                            onCodeChanged: (code) {
                              setState(() {
                                codeValue = code.toString();
                              });
                              if (code?.length == 5) {
                                FocusScope.of(context).requestFocus(FocusNode());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DashBoard()),);
                      },
                      child: Container(
                        //  width: 327.0,
                        margin: EdgeInsets.only(left: 24.0, right: 24.0),
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
                              "Verify Now",
                              style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter'),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 31.0,
                    ),
                    Container(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Didn't you recieve any code?",
                            style: TextStyle(
                                color: Color(0xff7A7B8C),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 40.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Re-send code",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff4F565E),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter'),
                          )),
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
