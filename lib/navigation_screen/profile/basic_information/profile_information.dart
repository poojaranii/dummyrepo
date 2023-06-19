import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../../demo.dart';
class ProileInformationScreen extends StatefulWidget {
  @override
  _ProfileInformatioState createState() => _ProfileInformatioState();
}

class _ProfileInformatioState extends State<ProileInformationScreen> {

  String token="";
  String name="";
  String account="";
  String? user="";
  String? firstName="";
  String email="";
  String lastName="";
  String phoneNumber="";
  String lastLogin="";
  String lastLoginIp="";
  var count;
  String image ="";
  bool condition = true;

  @override
  void initState() {
    super.initState();
   // setUpTimedFetch();
    Future.delayed(const Duration(seconds: 5), () => condition = false);
    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {getUser();
      getNotification();
    });
    getToken();

  }

  @override
  void dispose() {
    super.dispose();
    //setUpTimedFetch();
    getToken();
    getNotification();
  }

  void getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
      /*  name = sharedPreferences.getString('user');
        account = sharedPreferences.getString('account');*/
        user = sharedPreferences.getString('userid');
        firstName = sharedPreferences.getString('firstName');
       /* email = sharedPreferences.getString('email');
        lastName = sharedPreferences.getString('lastName');
        phoneNumber = sharedPreferences.getString('mobileNumber');
        lastLogin = sharedPreferences.getString('lastLogin');
        lastLoginIp = sharedPreferences.getString('lastLoginIp');
        image = sharedPreferences.getString('image');*/
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
                'Basic Information',
                style: TextStyle(
                    color: Color(0xff2B2B2B),
                    fontSize: 18.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              backgroundColor: Color(0xffFFFFFF),
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
          body: SingleChildScrollView(
            child: Column(
              children: [

                InkWell(
                  onTap: (){
                    //getUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 22.0),
                    height: 163.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Color(0xffACABB3)),
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
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 18.0,
                            right: 15.0,
                          ),
                          child: CircleAvatar(
                            //backgroundImage: NetworkImage(
                           //    'https://www.woolha.com/media/2020/03/eevee.png'),
                            radius: 40,
                            child:ClipRRect(
                              child: Image.network(image,fit: BoxFit.fill,height: 100,),
                              borderRadius: BorderRadius.circular(40.0),
                              //borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 8.0,
                                  ),
                                  child: Text("${firstName} ${lastName}",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Inter')),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 8.0, left: 2.0),
                                    child: SvgPicture.asset(
                                        "images/distributer_icon.svg")),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 4.0, top: 4.0),
                              child: Text("Distributer",
                                  style: TextStyle(
                                      color: Color(0xff858C97),
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter')),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    height: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Color(0xffACABB3)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 15.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4, left: 15.0),
                          child: Text(
                            "${email}",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Color(
                            0x1E000000,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 15.0),
                          child: Text(
                            "Phone",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4, left: 15.0),
                          child: Text(
                            "${phoneNumber}",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Color(
                            0x1E000000,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 15.0),
                          child: Text(
                            "Last Login At",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4, left: 15.0),
                          child: Text(
                            "${lastLogin}",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Color(
                            0x1E000000,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 15.0),
                          child: Text(
                            "Last Login IP",
                            style: TextStyle(
                                color: Color(0xff788395),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 4, left: 15.0, bottom: 10.0),
                          child: Text(
                            "${lastLoginIp}",
                            style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter'),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )),
    );
  }

  Future<void> getUser() async {
    var response= await http.post(Uri.parse("http://192.168.20.94:8081/Api/getUsersDetail"),
      headers: {
        "content-type": "application/json",
        "accept-encoding": "gzip",
        "Authorization": token
      },
      body:jsonEncode({
        "userID":user,
      }),
    );

    if(response.statusCode==200){
      var responseJson = jsonDecode(response.body.toString()) as Map<String,dynamic>;
      print(responseJson);
      if(mounted==true) {
        setState(() {
          firstName = responseJson['userDetail']['firstName'];
          email = responseJson['userDetail']['email'];
          lastName = responseJson['userDetail']['lastName'];
          phoneNumber = responseJson['userDetail']['mobileNumber'];
          lastLogin = responseJson['userDetail']['lastLoginAt']['String'];
          lastLoginIp = responseJson['userDetail']['lastLoginIP']['String'];
          image=responseJson['userDetail']['profileImageURL']['String'];
        });
      }

      final stringRes = JsonEncoder.withIndent('').convert(responseJson);
      print(response.body);
      print(stringRes);

    }else{
      print("failed");
    }
  }

  void setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
     //   getUser();
      });
    });
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
