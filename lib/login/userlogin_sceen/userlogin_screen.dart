import 'package:flutter/material.dart';
import 'dart:math';
// import 'package:hb_check_code/hb_check_code.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../bottom_dashboard.dart';
class UserScreen extends StatefulWidget {

  const UserScreen({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;

  String _name = '';
  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_name);
    }
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
      child: Scaffold(
        backgroundColor: Color(0xffF8F8F8),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 17.0,),
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
                    cursorColor: Color(0xffACABB3),
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                      contentPadding: EdgeInsets.only(left: 73,bottom: 14),
                      prefixIcon: Container(
                        margin: EdgeInsets.only(left: 34.0,right: 16,),
                        padding: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          border:
                          Border(right: BorderSide(color: Color(0xffACABB3))),
                        ),
                        child: SvgPicture.asset(
                          "images/unique_id.svg",
                        ),
                      ),


                      border: InputBorder.none,
                      hintText: 'Enter unique id',
                      hintStyle:
                      TextStyle(fontSize: 13.0, color: Color(0xff686A8A),fontWeight: FontWeight.w500,fontFamily: 'Inter'),
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

              SizedBox(height: 17.0,),

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
                    cursorColor: Color(0xffACABB3),
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                      contentPadding: EdgeInsets.only(left: 73,bottom: 14),
                      prefixIcon: Container(
                        margin: EdgeInsets.only(left: 36.0,right: 16,),
                        padding: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          border:
                          Border(right: BorderSide(color: Color(0xffACABB3))),
                        ),
                        child: SvgPicture.asset(
                          "images/mobile_no.svg",
                        ),
                      ),


                      border: InputBorder.none,
                      hintText: 'Enter registered mobile no',
                      hintStyle:
                      TextStyle(fontSize: 13.0, color: Color(0xff686A8A),fontWeight: FontWeight.w500,fontFamily: 'Inter'),
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
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(bottom: 16.0, left: 5.0),
                        prefixIcon: Container(
                          padding: EdgeInsets.fromLTRB(2, 1, 1, 1),
                          margin: EdgeInsets.only(left: 25, right: 16),
                          decoration: BoxDecoration(
                            border: Border(
                                right:
                                BorderSide(color: Color(0xffACABB3))),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                //  someCondition = false;
                              });
                            },
                            // child:
                            // HBCheckCode(
                            //   code: code,
                            // ),
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter captcha code',
                        hintStyle: TextStyle(
                            fontSize: 13.0, color: Color(0xff686A8A),fontWeight: FontWeight.w500,fontFamily: 'Inter')),

                    onFieldSubmitted: (value) {},
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Captcha';
                      }

                      if (value.length < 5) {
                        return 'Minimum length 5';
                      }
                      if (value.length > 5) {
                        return 'No more than 5';
                      }
                      return null;
                    },

                    //   onChanged: (text) => setState(() => _name = text),
                  ),
                ],
              ),
              SizedBox(height: 17.0),
              InkWell(
                onTap: (){
                  //_submit();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DashBoard()),);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only( left: 15.0, right: 15.0),
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xff420098),
                 //   border: Border.all(color: Color(0xffACABB3)),
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
            ],
          ),
        ),
      ),
    );

  }
}
