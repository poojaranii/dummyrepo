import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bottom_dashboard.dart';
import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();

  }

  void checkLogin() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? val = sharedPreferences.getString('login');
    if(val!=null){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              DashBoard()));
    } else{
      Timer(Duration(seconds: 2),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) => LoginClass()
              )
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff420098),
              Color(0xff6309D9),
            ],
          )
      ),
      // color: Color(0xff7D1DFB),
      child: Container(
        margin: EdgeInsets.only(left: 76.0,right: 76.0),
        child: SvgPicture.asset(
            'images/splash_logo.svg',width: 22.0,height: 56.0,),
      ),
    );
  }
}
