import 'package:flutter/material.dart';
import 'dart:math';
// import 'package:hb_check_code/hb_check_code.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bottom_dashboard.dart';
import '../../forgot_password/forgot_password.dart';
import '../../mobileno_screen/mobileregister_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class DealerScreen extends StatefulWidget {
  const DealerScreen({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  _DealerScreenState createState() => _DealerScreenState();
}

class _DealerScreenState extends State<DealerScreen> {
  var banner;

  bool visible = false ;
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;
  String _name = '';
  bool _submitted = false;
  int number = 1;
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _captcha = TextEditingController();
  FocusNode _textFocus = new FocusNode();
  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_name);
    }
  }
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    String code = "";
    for (var i = 0; i < 5; i++) {

      code = code + Random().nextInt(9).toString();
    }
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 17.0),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
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
                        ///obscureText: _obscureText,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                          contentPadding: EdgeInsets.only(left: 73,bottom: 14),
                          prefixIcon: Container(
                            margin: EdgeInsets.only(left: 34.0,right: 16,),
                            padding: EdgeInsets.only(right: 16),
                            // margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border:
                              Border(right: BorderSide(color: Color(0xffACABB3))),
                            ),
                            child: SvgPicture.asset(
                              "images/profile_icon.svg",
                            ),
                          ),

                          border: InputBorder.none,
                          hintText: 'Username',
                          hintStyle:
                          TextStyle(fontSize: 13.0, color: Color(0xff686A8A),fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                        ),
                        autovalidateMode: _submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        onFieldSubmitted: (value) {},
                        // ignore: missing_return
                        validator: (value) {
                        //  RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if(value!.isEmpty){
                            return 'Please enter email';
                          }
                          //if(!regex.hasMatch(value)){
                         //   return 'Enter valid password';
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

                  SizedBox(height: 17.0),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
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
                          // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                          contentPadding: EdgeInsets.only(left: 73,bottom: 14),
                          prefixIcon: Container(
                            margin: EdgeInsets.only(left: 33.0,right: 16,),
                            padding: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              border:
                              Border(right: BorderSide(color: Color(0xffACABB3))),
                            ),
                            child: SvgPicture.asset(
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
                          hintText: 'Password',
                          hintStyle:
                          TextStyle(fontSize: 13.0, color: Color(0xff686A8A),fontWeight: FontWeight.w500,fontFamily: 'Inter'),
                        ),
                        autovalidateMode: _submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        onFieldSubmitted: (value) {},
                        // ignore: missing_return
                        validator: (value) {
                         // RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if(value!.isEmpty){
                            return 'Please enter password';
                          }
                          //if(!regex.hasMatch(value)){
                         //   return 'Enter valid password';
                         // }
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
                  SizedBox(height: 17.0),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.0, right: 15.0),
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
                        keyboardType: TextInputType.number,
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorColor: Color(0xffACABB3),
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
                                  WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {


                                  }));
                                },
                                // child: HBCheckCode(
                                //
                                //   code: code,
                                // ),
                              ),
                              // ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Enter captcha code',
                            hintStyle:
                            TextStyle(fontSize: 13.0, color: Color(0xff686A8A),fontWeight: FontWeight.w500,fontFamily: 'Inter')),

                        autovalidateMode:_submitted
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                        onFieldSubmitted:(value) {},
                        // ignore: missing_return
                        validator: (value) {
                          RegExp regex=RegExp(r'^[1-9]$|^10$');
                          if(value!.isEmpty){
                            return 'Please enter Captcha';
                          } else if(value.length < 5){
                            return 'Minimum length 5';
                          } else if(value.length > 5){
                            return 'No more than 5';
                          }
                        },

                          onChanged: (text) => setState(() => _name = text),

                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      login();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 17, left: 15.0, right: 15.0),
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
                          "Login",
                          style: TextStyle(fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.w600,fontFamily: 'Inter'),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 17.0),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MobileScreen()),);
                      //_submit();
                    },
                    child:  Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(left: 15.0, right: 15.0),
                          height: 48,
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
                              SvgPicture.asset('images/smartphone.svg'),
                              SizedBox(width: 7.0,),
                              Text('Continue with Mobile No',style: TextStyle(color: Color(0xffFFFFFF),fontSize: 14.0,fontWeight: FontWeight.w600,fontFamily: 'Inter'),),

                            ],
                          ),),
                      ),
                    ),
                  ),

                  SizedBox(height: 13,),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ForgotPasswordScreen()),);
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                            child: Text('Forgot Password?',style: TextStyle(color: Color(0xff7A7B8C),fontSize: 12.0,fontWeight: FontWeight.w500,fontFamily: 'Inter'),))),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
  }

  Future<void> login() async {
    String username = _userName.text.toString();
    String password = _password.text.toString();
    String captcha = _captcha.text.toString();
    print("use :" + username);
    print("pas :" + password);
    if(username.isNotEmpty && password.isNotEmpty && captcha.isNotEmpty){
      print("usein :" + username);
      print("pasin :" + password);
      var response= await http.post(Uri.parse("http://192.168.20.94:8081/login"),
        body:jsonEncode({
          "username":username,
          "password":password
        }),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          //  "Authorization": "Bearer"
        },
      );
      // ignore: unrelated_type_equality_checks
      if(response.statusCode==200){
        var responseJson = jsonDecode(response.body.toString()) as Map<String,dynamic>;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString('login',responseJson['AccessToken']);
        await sharedPreferences.setString('user',responseJson['Name']);
        await sharedPreferences.setString('account',responseJson['AccountID']);
        await sharedPreferences.setString('userid',responseJson['UserID']);
        await sharedPreferences.setString('accountId',responseJson['AccountID']);
        print(responseJson);
        print('Token : ${login}');
        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
        Navigator.push(
          context,
         MaterialPageRoute(builder: (context) =>
                DashBoard()));
      }else{
        print("failed");
      }
    }else{
      _submit();
    }
  }
}

