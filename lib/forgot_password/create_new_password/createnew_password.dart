import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login/login_screen.dart';
class CreateNewpasswordScreen extends StatefulWidget {

  @override
  _NewPassState createState() => _NewPassState();
}

class _NewPassState extends State<CreateNewpasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String forgotMessage="";
  bool _obscureText = true;
  var _password = TextEditingController();
  var _confirmPassword = TextEditingController();
  String _name = '';
  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  void initState() {
    super.initState();

    getToken();
  }

  void getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      // getUser();
      forgotMessage=sharedPreferences.getString('forgot')!;


    });
  }

  @override
  Widget build(BuildContext context) {

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
                Visibility(
                  visible: false,
                  child: InkWell(
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
                ),
                SizedBox(
                  height: 16.0,
                ),

                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top:65.0 ),
                              child: Image.asset(
                                'images/reset_password.png',

                              ),
                            ),
                          ),
                          SizedBox(
                            height: 17.0,
                          ),
                          Visibility(
                            visible: false,
                            child: Container(
                              // width: 256.0,
                              height: 29.0,
                              margin: EdgeInsets.only(left: 22.0),
                              child: Text(
                                "Create New Password",
                                style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Inter',fontSize: 24.0, color: Color(0xff2B2B2B)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 11.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0,right: 24.0,left: 24.0),
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Color(0xffdcf5e7),
                                border: Border.all(color: Color(0xffcef1de)),
                                borderRadius: BorderRadius.circular(
                                  6.0,
                                ),
                              ),
                              //height: 40.0,
                              width: MediaQuery.of(context).size.width * 0.99,
                              //margin: EdgeInsets.only(left: 24.0,),
                              child: Text(
                                "${forgotMessage}",
                                style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Inter',
                                  fontSize: 20.0,
                                    color: Color(0xff2a6b47),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: SizedBox(
                              height: 33.0,
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Stack(
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
                                  controller: _password,
                                  cursorColor: Color(0xffACABB3),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  obscureText: _obscureText,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 73,bottom: 14),
                                    prefixIcon: Container(
                                      margin: EdgeInsets.only(left: 42.0,right: 16,),
                                      padding: EdgeInsets.only(right: 16),
                                      decoration: BoxDecoration(
                                        border:
                                        Border(right: BorderSide(color: Color(0xffACABB3))),
                                      ),
                                      child:  SvgPicture.asset(
                                        "images/lock.svg",
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
                                    hintText: 'Enter new password',
                                    hintStyle:
                                    TextStyle(fontSize: 13.0, color: Color(
                                        0xb6686a8a),fontWeight: FontWeight.w500,fontFamily: 'Inter',),
                                  ),
                                  onFieldSubmitted: (value) {
                                  },
                                  // ignore: missing_return
                                  validator: (value) {
                                    RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    if(value!.isEmpty){
                                      return 'Please enter password';
                                    }
                                    if(!regex.hasMatch(value)){
                                      return 'Enter valid password';
                                    }
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
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Visibility(
                            visible: false,
                            child: Stack(
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
                                  controller: _confirmPassword,
                                  cursorColor: Color(0xffACABB3),
                                  textAlignVertical: TextAlignVertical.bottom,
                                 // obscureText: _obscureText,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 73,bottom: 14),
                                    prefixIcon: Container(
                                      margin: EdgeInsets.only(left: 42.0,right: 16,),
                                      padding: EdgeInsets.only(right: 16),
                                      decoration: BoxDecoration(
                                        border:
                                        Border(right: BorderSide(color: Color(0xffACABB3))),
                                      ),
                                      child:  SvgPicture.asset(
                                        "images/lock.svg",
                                      ),
                                    ),

                                    border: InputBorder.none,
                                    hintText: 'Confirm new password',
                                    hintStyle:
                                    TextStyle(fontSize: 13.0, color: Color(
                                        0xb6686a8a),fontWeight: FontWeight.w500,fontFamily: 'Inter',),
                                  ),
                                  onFieldSubmitted: (value) {

                                  },
                                  // ignore: missing_return
                                  validator: (value) {
                                    RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    if(value!.isEmpty){
                                      return 'Please enter password';
                                    }
                                    if(!regex.hasMatch(value)){
                                      return 'Enter valid password';
                                    }
                                    if(value.length < 3){
                                      return 'Minimum length 3';
                                    }
                                    if(value.length > 50){
                                      return 'No more length 50';
                                    }
                                  },
                                  onChanged: (text) => setState(() => _name = text),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          InkWell(
                            onTap: (){
                              // ignore: unnecessary_statements
                             // _name.isNotEmpty ? _submit : null;
                              resetPassword();
                            },
                           //   RegExp regex=RegExp('[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{3,50}');
                              child: Container(
                              margin: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 105.0),
                              height: 48,
                              decoration: BoxDecoration(
                                color: Color(0xff420098),
                                border: Border.all(color: Color(0xff420098)),
                                borderRadius: BorderRadius.circular(
                                  6.0,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginClass()),);
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Back to Login",
                                      style: TextStyle(color: Color(0xffFFFFFF),fontWeight: FontWeight.w500,fontFamily: 'Inter',),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),

                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<void> resetPassword() async {
   // if (_password.text.isNotEmpty && _confirmPassword.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/resetAccountLogin"),
        headers: {
          "Content-Type": "application/json",
          "Accept-Encoding": "gzip",
          //  "Authorization": "Bearer"
        },
        body: jsonEncode({
          'password':"@Bryc@123",
          'confirmPassword':"@Bryc@123",

        }),
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        print("forgot Succesfully");
        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed");
      }
  //  } else {
      // _submit();

   // }
  }
}
