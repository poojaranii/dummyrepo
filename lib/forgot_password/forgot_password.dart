
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
// import 'package:hb_check_code/hb_check_code.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'create_new_password/createnew_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {

  @override
  _ForgotoState createState() => _ForgotoState();
}

class _ForgotoState extends State<ForgotPasswordScreen> {

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;
  String _name = '';
  var _userName = TextEditingController();
  var _captcha = TextEditingController();
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {

    final formGlobalKey = GlobalKey < FormState > ();
    String code = "";

    for (var i = 0; i < 5; i++) {
      code = code + Random().nextInt(9).toString();
    }
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          backgroundColor: Color(0xffF8F8F8),
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                //flex: 1,
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 58.0, left: 24.0,),
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
                            // margin: EdgeInsets.only(left: 49.0, right: 46.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/forgot _password_bro.png',
                                width: 280.0,
                                height: 280.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 24.0),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Inter',fontSize: 24.0, color: Color(0xff2B2B2B)),
                            ),
                          ),
                          SizedBox(
                            height: 11.0,
                          ),
                          Container(
                            width: 300.0,
                            height: 60.0,
                            margin: EdgeInsets.only(left: 24.0),
                            child: Text(
                              "Enter the email address associated with you account and we'll send you a link to reset your password.",
                              style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Inter',
                                fontSize: 14.0,
                                color: Color(0xAD353750),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 24.0, right: 24.0),
                                height: 49,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffACABB3)),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: _userName,
                                cursorColor: Color(0xffACABB3),
                                textAlignVertical: TextAlignVertical.bottom,
                                obscureText: _obscureText,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                                  contentPadding: EdgeInsets.only(left: 73,bottom: 14),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(left: 42.0,right: 16,),
                                    padding: EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      border:
                                      Border(right: BorderSide(color: Color(0xffACABB3))),
                                    ),
                                    child: SvgPicture.asset(
                                      "images/mail_forgot.svg",
                                    ),
                                  ),

                                  suffixIcon: Container(
                                    margin: EdgeInsets.only(right: 25),
                                    child: IconButton(icon: Icon(
                                      _obscureText ? Icons.visibility:Icons.visibility_off,color: Color(0xff9395AC),
                                    ),
                                      onPressed: (){
                                        setState(() {
                                          _obscureText=!_obscureText;
                                        });
                                      },
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Enter new address',
                                  hintStyle:
                                  TextStyle(fontSize: 13.0, color: Color(
                                      0xb6686a8a),fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                                ),
                                onFieldSubmitted: (value) {
                                },
                                // ignore: missing_return
                                validator: (value) {
                                //  RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  if(value!.isEmpty){
                                    return 'Please enter password';
                                  }
                                //  if(!regex.hasMatch(value)){
                                //    return 'Enter valid password';
                                //  }
                                  if(value.length < 3){
                                    return 'Minimum length 3';
                                  }
                                  if(value.length > 50){
                                    return 'No more length 50';
                                  }
                                  return null;
                                },

                                onChanged: (text) => setState(() => _name = text),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 24.0, right: 24.0),
                                height: 49,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffACABB3)),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: _captcha,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 16.0, left: 72.0),
                                    prefixIcon: Container(
                                      padding: EdgeInsets.fromLTRB(2, 1, 1, 1),
                                      margin: EdgeInsets.only(left: 25,right: 16),
                                      decoration: BoxDecoration(
                                        border:
                                        Border(right: BorderSide(color: Color(0xffACABB3))),
                                      ),
                                      child: InkWell(

                                        onTap: (){
                                          setState(() {

                                          });
                                        },
                                        // child: HBCheckCode(
                                        //   code: code,
                                        // ),
                                      ),
                                      // ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Enter captcha code',
                                    hintStyle:
                                    TextStyle(fontSize: 13.0, color: Color(
                                        0xb5686a8a),fontWeight: FontWeight.w500,fontFamily: 'Inter')),

                                onFieldSubmitted: (value) {
                                },
                                // ignore: missing_return
                                validator: (value) {
                                  RegExp regex=RegExp(r'^[1-9]$|^10$');
                                  if(value!.isEmpty){
                                    return 'Please enter Captcha';
                                  } else if(value.length < 5){
                                    return 'Minimum length 3';
                                  } else if(value.length > 5){
                                    return 'No more than 5';
                                  }
                                },

                              //  onChanged: (text) => setState(() => _name = text),

                              ),
                            ],
                          ),

                          SizedBox(
                            height: 18,
                          ),
                          InkWell(
                            onTap: (){
                              forgot();
                            //  Navigator.push(
                              //  context,
                              //  MaterialPageRoute(
                              //      builder: (context) =>
                               //         CreateNewpasswordScreen()),);
                              // ignore: unnecessary_statements
                             // _submit();
                            },
                            child: Container(

                              margin: EdgeInsets.only(left: 24.0, right: 24.0,bottom: 80.0),
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
                                    "Continue",
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
            ),
          )),
    );
  }

  Future<void> forgot() async{
    String email = _userName.text.toString();
    String captcha = _captcha.text.toString();
    if(email.isNotEmpty  && captcha.isNotEmpty){

      var response= await http.post(Uri.parse("http://192.168.20.94:8081/forgotPassword"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          //  "Authorization": "Bearer"
        },
        body:jsonEncode({
          'username':email,
        }),
      );

      if(response.statusCode==200){
        var responseJson = jsonDecode(response.body.toString());
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString('forgot',responseJson['apiResponseMsg']);
        print(responseJson);
        print("forgot Succesfully");

        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
        Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                    CreateNewpasswordScreen()),);
      }else{
        print("failed");
      }
    }else{
      _submit();

    }
  }
}
