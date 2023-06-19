import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../demo.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPasword = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  String _name = '';
  bool _submitted = false;
  String token="";
  String? name="";
  String? account="";
  String? user="";
  String firstName="";
  var count;
  bool condition = true;

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

  void getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      token=sharedPreferences.getString('login')!;
      name=sharedPreferences.getString('user');
      account=sharedPreferences.getString('account');
      user=sharedPreferences.getString('userid');

    });
  }


  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffF8F8F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child:Container(
            decoration: BoxDecoration( boxShadow: [
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
            title: Text(
              'Change Password',
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
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Hello()));
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
                        margin: EdgeInsets.only(top: 0,right: 3,bottom: 3),
                        child: Container(
                          width: 20,
                          height: 16,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffff5252),
                              border: Border.all(color:  Color(0xffff5252), width: 0)),
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
        //  backgroundColor: Color(0xffE5E5E5),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 48.0),
                    child: Image.asset(
                      'images/change_password.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      children: [
                        Text(
                          "Current Password",
                          style: TextStyle(
                              color: Color(0xff788395),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter'),
                        ),
                        //  Image.asset('name')
                      ],
                    )),
                SizedBox(
                  height: 8.0,
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffACABB3)),
                        borderRadius: BorderRadius.circular(
                          6.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _currentPasword,
                      cursorColor: Color(0xffACABB3),
                      textAlignVertical: TextAlignVertical.bottom,
                      obscureText: _obscureText,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                        contentPadding: EdgeInsets.only(left: 30, bottom: 16),
                        suffixIcon: Container(
                          margin: EdgeInsets.only(right: 25),
                          child: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xff9395AC),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter current password',
                        hintStyle: TextStyle(
                            fontSize: 13.0,
                            color: Color(0xff999CAB),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500),
                      ),
                      autovalidateMode: _submitted
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 3) {
                          return 'Minimum length 3';
                        }
                        if (value.length > 50) {
                          return 'Maximum length 50';
                        }

                        return null;
                      },
                      onChanged: (text) => setState(() => _name = text),
                    ),
                  ],
                ),
                SizedBox(
                  height: 17.0,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      children: [
                        Text(
                          "New Password",
                          style: TextStyle(
                              color: Color(0xff788395),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter'),
                        ),
                        //  Image.asset('name')
                      ],
                    )),
                SizedBox(
                  height: 8.0,
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffACABB3)),
                        borderRadius: BorderRadius.circular(
                          6.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      cursorColor: Color(0xffACABB3),
                      textAlignVertical: TextAlignVertical.bottom,
                      controller: _newPass,
                      obscureText: _obscureText1,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                        contentPadding: EdgeInsets.only(left: 30, bottom: 16),

                        suffixIcon: Container(
                          margin: EdgeInsets.only(right: 25),
                          child: IconButton(
                            icon: Icon(
                              _obscureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xff9395AC),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText1 = !_obscureText1;
                              });
                            },
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter new password',
                        hintStyle: TextStyle(
                            fontSize: 13.0,
                            color: Color(0xff999CAB),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500),
                      ),
                      autovalidateMode: _submitted
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onFieldSubmitted: (value) {},
                      // ignore: missing_return
                      validator: (value) {
                        RegExp regex =
                            RegExp('[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{3,50}');
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 3) {
                          return 'Minimum length 3';
                        }
                        if (value.length > 50) {
                          return 'Maximum length 50';
                        }
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid password';
                        }
                        return null;
                      },
                      onChanged: (text) => setState(() => _name = text),
                    ),
                  ],
                ),
                SizedBox(
                  height: 17.0,
                ),
                Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      children: [
                        Text(
                          "Confirm New Password",
                          style: TextStyle(
                              color: Color(0xff788395),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter'),
                        ),
                        //  Image.asset('name')
                      ],
                    )),
                SizedBox(
                  height: 8.0,
                ),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffACABB3)),
                        borderRadius: BorderRadius.circular(
                          6.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      cursorColor: Color(0xffACABB3),
                      textAlignVertical: TextAlignVertical.bottom,
                      obscureText: _obscureText2,
                      controller: _confirmPass,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30, bottom: 16),
                        suffixIcon: Container(
                          margin: EdgeInsets.only(right: 25),
                          child: IconButton(
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xff9395AC),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Confirm new password',
                        hintStyle: TextStyle(
                            fontSize: 13.0,
                            color: Color(0xff999CAB),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500),
                      ),
                      autovalidateMode: _submitted
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onFieldSubmitted: (value) {},
                      validator: (value) {
                        RegExp regex =
                            RegExp('[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{3,50}');
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 3) {
                          return 'Minimum length 3';
                        }
                        if (value.length > 50) {
                          return 'Maximum length 50';
                        }
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid password';
                        }
                        if (value != _newPass.text) {
                          return 'Not Match';
                        }
                        return null;
                      },
                      onChanged: (text) => setState(() => _name = text),
                    ),
                  ],
                ),
               // Text("your token:${token}"),
                SizedBox(
                  height: 24.0,
                ),
                InkWell(
                  onTap: () {
                    changePassword();
                   // _submit();
                  },
                  child: Container(
                    //width: MediaQuery.of(context).size.width * 0.99,
                    margin:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: Color(0xff420098),
                      //border: Border.all(color: Color(0xffACABB3)),
                      borderRadius: BorderRadius.circular(
                        6.0,
                      ),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Update password',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 15.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> changePassword() async {
    String currentPass = _currentPasword.text.toString();
    String newPassword = _newPass.text.toString();
    String confirmPassword = _confirmPass.text.toString();

    if(currentPass.isNotEmpty && newPassword.isNotEmpty && confirmPassword.isNotEmpty){
    var response= await http.post(Uri.parse("http://192.168.20.94:8081/Api/changeUserPassword"),
      headers: {
        "content-type": "application/json",
        "accept-encoding": "gzip",
        "Authorization": token
      },
      body:jsonEncode({
        "currentPassword":currentPass,
        "newPassword":newPassword,
        "confirmNewPassword":confirmPassword
      }),
    );
    if(response.statusCode==200){
      var responseJson = jsonDecode(response.body.toString()) as Map<String,dynamic>;
      print(responseJson);
      final stringRes = JsonEncoder.withIndent('').convert(responseJson);
      print(stringRes);
    }else{
      print("failed");
    }
    }else{
      _submit();
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
        body: jsonEncode({"isRead": 'false'
        }),
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
}
