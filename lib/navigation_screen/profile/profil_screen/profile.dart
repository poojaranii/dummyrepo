import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../demo.dart';
import '../../../kyc_adhaar_update.dart';
import '../../../kyc_detail_screen/kyc_full_detail/kyc_detail.dart';
import '../../../notification_screen/Notification.dart';
import '../basic_information/profile_information.dart';
import '../change_password_screen/change_password.dart';
import '../kyc_detail/kyc_detail_adhaar.dart';
import '../profile_setting_screen/profile_setting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProileScreen extends StatefulWidget {

  var res;

  String nameLast="";
  String firstNameDe="";
  String emailId="";
  var mobileNumber;

  ProileScreen ({ Key? key,this.res}): super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProileScreen> {

  bool isLoading = true;
  String token="";
  String? name="";
  var res;
  String? account="";
  String? firstNameDe="";
  String? user="";
  String? firstName="";
  bool condition = true;
  String? nameFirstIch="";
  String? nameLast="";
  String? emailId="";
  var mobileNumber;
  String? lastName="";
  String? email="";
  var count;
  var nameFirst;
  String? image="";
  SharedPreferences? sharedPreferences;
  Timer? _everySecond;
  StreamController? _userController;
  @override
  void initState() {
    super.initState();

    _userController = new StreamController();

    Future.delayed( Duration(seconds: 5), () => condition = false);

    Stream.periodic( Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      getUser();
      getAccountDetail();
      getNotification();
    });
    getToken();
  }

  File? imageFile;

  _openGalery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        getUploadPics();
      });
      Navigator.of(context).pop();
    }
  }

  _openCamera(BuildContext context) async {
    PickedFile? pickedFile1 = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile1 != null) {
      print("image selected");
      setState(() {
        imageFile = File(pickedFile1.path);
        getUploadPics();

      });
      Navigator.of(context).pop();
    }
  }

  Future<void> _showchoicDailog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice!",
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter')),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text(
                      "Gallary",
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter'),
                    ),
                    onTap: () {
                      _openGalery(context);

                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("camera",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter')),
                    onTap: () {
                      _openCamera(context);
                      getUser();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }




  @override
  void didChangeDependencies() {
    getUser();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ProileScreen oldWidget) {
    getUser();
    super.didUpdateWidget(oldWidget);
  }


  @override
  void dispose() {
    super.dispose();
    getUser();
    getToken();
  }

  void getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
        name = sharedPreferences.getString('user');
        account = sharedPreferences.getString('account');
        user = sharedPreferences.getString('userid');
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    //getUser();
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffF8F8F8),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child:Container(
            decoration: BoxDecoration(boxShadow: [
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
            title: Text('Account',style: TextStyle(color: Color(0xff2B2B2B),fontSize: 18.0,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600),),centerTitle: true,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: (){
                getUser();
              },
              child: Padding(
                  padding: EdgeInsets.all(18),
                  child: SvgPicture.asset('images/drower.svg')),
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
       // drawer: Drawer(),
          body:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                     // getUser();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 22.0),
                      height: 84.0,
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
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left:15.0,right: 15.0,),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                    // imageFile != null
                                    //     ?
                                    FileImage(imageFile!) ,
                                    //     :
                                    // NetworkImage(image),
                                    fit: BoxFit.fill
                                ),
                              ),
                              child: Stack(
                                  children: [

                                    Align(
                                      alignment: Alignment.center,
                                      child:  InkWell(
                                        onTap: (){
                                          _showchoicDailog(context);

                                          getUser();
                                          setState(() {
                                          //  _isLoading=true;

                                          });

                                          setState(() {
                                          //  _isLoading=false;
                                          });
                                          //  getUploadPics();
                                        },
                                        child:   SvgPicture.asset(
                                            'images/camera.svg',
                                            height: 16.0,
                                            width: 20.0,
                                          ),

                                      ),

                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20.0,),
                                    child: Text("${firstName} ${lastName ?? nameLast}",textScaleFactor: 1.0,style: TextStyle(color: Color(0xff000000),fontSize: 18.0 ,fontWeight: FontWeight.w600,fontFamily: 'Inter',)),
                                  ),

                                  //Text("your token:${token}"),
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 13.0,
                                            left: 5.0),
                                        child: SvgPicture.asset("images/edit.svg")
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 0.0,top: 5.0),
                                child: Text("${email}",textScaleFactor: 1.0,style: TextStyle(color: Color(0xff858C97),fontSize: 13.0 ,fontWeight: FontWeight.w500,fontFamily: 'Inter'), overflow: TextOverflow.ellipsis,
                                  softWrap: false,),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ProileInformationScreen()));
                    },
                   child: Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 13.0),
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 15.0),
                              child: SvgPicture.asset("images/profile_icon.svg")
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 10.0,),
                            child: Text("Basic information",textScaleFactor: 1.0,style: TextStyle(color: Color(0xff2B2B2B),fontSize: 15.0,fontWeight: FontWeight.w600,fontFamily: 'Inter')),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                    //left: 165,
                                      right: 15.0
                                  ),
                                  child: SvgPicture.asset("images/profile_back.svg",)

                              ),
                            ],
                          ),

                        ],
                      ),
                    )
                  ),


                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ProileSettingScreen(onSubmit: (String value) {  },)));
                    },
                    child:Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 13.0),
                      height: 48.0,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 15.0),
                              child: SvgPicture.asset("images/setting_icon.svg")
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 10.0,),
                            child: Text("Profile Setting",textScaleFactor: 1.0,style: TextStyle(color: Color(0xff2B2B2B),fontSize: 15.0,fontWeight: FontWeight.w600,fontFamily: 'Inter')),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                    //left: 165,
                                      right: 15.0
                                  ),
                                  child: SvgPicture.asset("images/profile_back.svg",)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ChangePassword(onSubmit: (String value) {  },)));
                    },
                    child:  Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 13.0),
                      height: 48.0,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 15.0),
                              child: SvgPicture.asset("images/unlock_profile.svg")
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 10.0,),
                            child: Text("Change Password",textScaleFactor: 1.0,style: TextStyle(color: Color(0xff2B2B2B),fontSize: 15.0,fontWeight: FontWeight.w600,fontFamily: 'Inter')),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                    //left: 165,
                                      right: 15.0
                                  ),
                                  child: SvgPicture.asset("images/profile_back.svg",)

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  KycAdhaar()));
                    },
                    child:  Container(
                      width: MediaQuery.of(context).size.width * 0.99,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 13.0),
                      height: 48.0,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 15.0),
                              child: SvgPicture.asset("images/kyc_profile.svg")
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 10.0,),
                            child: Text("KYC Detail",textScaleFactor: 1.0,style: TextStyle(color: Color(0xff2B2B2B),fontSize: 15.0,fontWeight: FontWeight.w600,fontFamily: 'Inter')),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                    //left: 165,
                                      right: 15.0
                                  ),
                                  child: SvgPicture.asset("images/profile_back.svg",)

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Text("your token:${token}"),

                  Spacer(flex: 2,),

                Flexible(
                      child: InkWell(
                        onTap: () async {
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          preferences.clear();

                         // _logout(context);
                          //await Future.delayed(Duration(seconds: 2));

                      /*    Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  LoginClass()));*/
                        },
                        child: Container(
                              width: MediaQuery.of(context).size.width * 0.99,
                              margin: EdgeInsets.only(left: 15.0, right: 15.0,bottom: 20.0),
                              height: 48.0,
                              decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                border: Border.all(color: Color(0xffE13939)),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0,),
                                    child: Text("Logout",textScaleFactor: 1.0,style: TextStyle(color: Color(0xffE13939),fontSize: 15.0,fontWeight: FontWeight.w600,fontFamily: 'Inter')),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 5.0),
                                      child: SvgPicture.asset("images/log_out.svg")
                                  ),
                                ],
                              ),
                            ),
                      ),
                    ),

                ],
              ),
          ),
    );
  }

  Future<String?> getUser() async {
    String? value;
    if(value==null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getUsersDetail"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({
          "userID": user,
        }),
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString()) as Map<String,dynamic>;

        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences?.setString('firstName', responseJson['userDetail']['firstName']);
        await sharedPreferences?.setString('email',responseJson['userDetail']['email']);
        await sharedPreferences?.setString('lastName',responseJson['userDetail']['lastName']);
        await sharedPreferences?.setString('mobileNumber',responseJson['userDetail']['mobileNumber']);
        await sharedPreferences?.setString('lastLogin',responseJson['userDetail']['lastLoginAt']['String']);
        await sharedPreferences?.setString('lastLoginIp',responseJson['userDetail']['lastLoginIP']['String']);
        await sharedPreferences?.setString('image',responseJson['userDetail']['profileImageURL']['String']);
        print(responseJson);
        if (mounted == true) {
          setState(() {
            firstName = responseJson['userDetail']['firstName'];
            lastName = responseJson['userDetail']['lastName'];
            email = responseJson['userDetail']['email'];
            image=responseJson['userDetail']['profileImageURL']['String'];
            return;
          });
        }

        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed");
      }
      return value;
    }
  }

  Future<void> getAccountDetail() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/accountDetail"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString()) as Map<String, dynamic>;

        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences?.setInt('isVerified',int.parse(responseJson['account']['isVerified'].toString()));

        print(responseJson);
          final stringRes = JsonEncoder.withIndent('').convert(responseJson);
          print(stringRes);
        } else {
          print("failed");

      }
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

  Future<void> getUploadPics() async {
    String? value;
    if (value == null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.20.94:8081/Api/uploadProfileImage'));
      request.headers.addAll({"content-type": "multipart/form_data",
        "accept-encoding": "gzip",
        "Authorization": token,
        "platform": 'mobile_application'});


      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          imageFile!.readAsBytesSync(),
          filename: "test.${imageFile?.path.split(".").last}",
        ),
      );
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final decodedMap = json.decode(responseString);
        print(decodedMap);

        final stringRes = JsonEncoder.withIndent('').convert(decodedMap);
        print(stringRes);
      } else {
        print("failed uploaddocument");
      }
    }
  }

}
