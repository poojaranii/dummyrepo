import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../../demo.dart';
import '../profil_screen/profile.dart';

class ProileSettingScreen extends StatefulWidget {
  const ProileSettingScreen({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;
  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProileSettingScreen> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  bool _obscureText = true;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _emailId = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  String _name = '';
  bool _submitted = false;
  bool _isLoading=false;
  String token = "";
  String name = "";
  String account = "";
  String user = "";
  String firstName = "";
  String image = "";
  String email = "";
  String lastName = "";
  String phoneNumber = "";
  bool condition = true;
  String lastLogin = "";
  String lastLoginIp = "";
  var count;
  //var user;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => condition = false);

    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
     // getUser();
      getNotification();
    });

    getToken();
  }

  @override
  void dispose() {
    super.dispose();
  //  setUpTimedFetch();
    getToken();
  }

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        // getUser();
        token = sharedPreferences.getString('login')!;
        name = sharedPreferences.getString('user')!;
        account = sharedPreferences.getString('account')!;
        user = sharedPreferences.getString('userid')!;
        firstName = sharedPreferences.getString('firstName')!;
        email = sharedPreferences.getString('email')!;
        lastName = sharedPreferences.getString('lastName')!;
        phoneNumber = sharedPreferences.getString('mobileNumber')!;
        image = sharedPreferences.getString('image')!;
      });
    }
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_name);
    }
  }

  File? imageFile;

  _openGalery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
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
                    },
                  )
                ],
              ),
            ),
          );
        });
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
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x2A000000),
                    offset: const Offset(
                      0.0,
                      1.0,
                    ),
                    blurRadius: 16.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),

              child: AppBar(
                title: Text(
                  'Profile Setting',
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
                    Navigator.pop(context,true);
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
                        children:[
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
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Visibility(
                  visible: false,
                  child: GestureDetector(
                    onTap: () {
                     // getUser();
                    },
                    child: Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.99,
                        margin: EdgeInsets.only(left: 15.0, right:15.0, top:22.0),
                        height: MediaQuery.of(context).size.height * 0.16,
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
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: 15.0, right: 15.0, bottom: 15.0),
                                  child: InkWell(
                                    onTap: () {

                                    },
                                    child:Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                            //imageFile != null ?
                                            FileImage(imageFile!),
                                               // : NetworkImage(image),
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                      child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: isLoading ? CircularProgressIndicator() : InkWell(
                                                onTap: (){
                                                  _showchoicDailog(context);

                                                  setState(() {
                                                    _isLoading=true;
                                                    getUploadPics();
                                                  });

                                                  setState(() {
                                                    _isLoading=false;
                                                  });
                                                  //  getUploadPics();
                                                },
                                                child: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor: Colors.white70,
                                                  child: Icon(CupertinoIcons.camera,),
                                                ),
                                              ),

                                            ),
                                          ]
                                      ),
                                    ),
                                    /*Container(


                                      child: CircleAvatar(
                                        radius: 40,
                                        foregroundImage: imageFile != null
                                            ? FileImage(imageFile)
                                            : Image.network(image,fit: BoxFit.fill,height: 100,),
                                        child: Stack(
                                            children: [


                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: isLoading ? CircularProgressIndicator() : InkWell(
                                                  onTap: (){
                                                    _showchoicDailog(context);

                                                    setState(() {
                                                      _isLoading=true;
                                                      getUploadPics();
                                                    });

                                                    setState(() {
                                                      _isLoading=false;
                                                    });
                                                  //  getUploadPics();
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor: Colors.white70,
                                                    child: Icon(CupertinoIcons.camera),
                                                  ),
                                                ),

                                              ),
                                            ]
                                        ),
                                      ),
                                    ),*/

                                    /* CircleAvatar(
                                      radius: 40,
                                      backgroundImage: imageFile != null
                                          ? FileImage(imageFile)
                                          : null,
                                     // child: ClipRRect(
                                       // child: SvgPicture.asset(
                                       //   "images/defaultImage.svg",
                                      //  ),
                                     //   borderRadius: BorderRadius.circular(40.0),
                                        //borderRadius: BorderRadius.circular(50.0),
                                    //  ),
                                    ),*/
                                  )),

                            ),
                          //  Container(
                             // child: SvgPicture.asset(
                             //   "images/camera.svg",
                             // ),
                           // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                margin: EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 15.0),
                                      child: Text(
                                        "First Name",
                                        style: TextStyle(
                                            color: Color(0xff788395),
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Inter'),
                                      ),
                                    ),

                                    Container(
                                       margin: EdgeInsets.only(left: 15.0),
                                       child: TextFormField(
                                        controller: _firstName,
                                        cursorColor: Color(0xffACABB3),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          errorStyle: TextStyle(
                                              fontSize: 13, height: 0.05),
                                          hintText: '${firstName}',
                                          hintStyle: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Inter'),
                                          border: InputBorder.none,
                                        ),
                                        autovalidateMode: _submitted
                                            ? AutovalidateMode.onUserInteraction
                                            : AutovalidateMode.disabled,
                                        onFieldSubmitted: (value) {},
                                        validator: (value) {
                                          RegExp regex =
                                              RegExp('([A-Za-z0-9_\s]+)');
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter first name';
                                          }
                                          if (value.length < 1) {
                                            return 'Minimum length 1';
                                          }
                                          if (value.length > 50) {
                                            return 'Not exceed 50';
                                          }
                                          return null;
                                        },

                                        onChanged: (text) =>
                                            setState(() => _name = text),
                                      ),
                                    ),
                                    Divider(
                                      color: Color(
                                        0x1E000000,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 15.0),
                                      child: Text(
                                        "Last Name",
                                        style: TextStyle(
                                            color: Color(0xff788395),
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Inter'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        controller: _lastName,
                                        cursorColor: Color(0xffACABB3),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          errorStyle: TextStyle(
                                              fontSize: 13, height: 0.05),
                                          hintText: '${lastName}',
                                          hintStyle: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Inter'),
                                          border: InputBorder.none,
                                        ),
                                        autovalidateMode: _submitted
                                            ? AutovalidateMode.onUserInteraction
                                            : AutovalidateMode.disabled,
                                        onFieldSubmitted: (value) {},
                                        validator: (value) {
                                          RegExp regex = RegExp(
                                              '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.]{1}[a-zA-Z]{2,}');
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter last name';
                                          }

                                          return null;
                                        },
                                        onChanged: (text) =>
                                            setState(() => _name = text),
                                      ),
                                    ),
                                    Divider(
                                      color: Color(
                                        0x1E000000,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 15.0),
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
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        controller: _emailId,
                                        cursorColor: Color(0xffACABB3),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          errorStyle: TextStyle(
                                              fontSize: 13, height: 0.05),
                                          hintText: '${email}',
                                          hintStyle: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Inter'),
                                          border: InputBorder.none,
                                        ),
                                        autovalidateMode: _submitted
                                            ? AutovalidateMode.onUserInteraction
                                            : AutovalidateMode.disabled,
                                        onFieldSubmitted: (value) {},
                                        validator: (value) {
                                          RegExp regex =
                                              RegExp('([A-Za-z0-9_\s]+)');
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter valid Email';
                                          }
                                          if (value.length < 1) {
                                            return 'Minimum length 1';
                                          }
                                          if (value.length > 50) {
                                            return 'Not exceed 50';
                                          }
                                          return null;
                                        },
                                        onChanged: (text) =>
                                            setState(() => _name = text),
                                      ),
                                    ),
                                    Divider(
                                      color: Color(
                                        0x1E000000,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 15.0),
                                      child: Text(
                                        "Mobile Number",
                                        style: TextStyle(
                                            color: Color(0xff788395),
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Inter'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: TextFormField(
                                        controller: _mobileNumber,
                                        cursorColor: Color(0xffACABB3),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          errorStyle: TextStyle(
                                              fontSize: 13, height: 0.05),
                                          hintText: '${phoneNumber}',
                                          hintStyle: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Inter'),
                                          border: InputBorder.none,
                                        ),
                                        autovalidateMode: _submitted
                                            ? AutovalidateMode.onUserInteraction
                                            : AutovalidateMode.disabled,
                                        onFieldSubmitted: (value) {},
                                        validator: (value) {
                                          RegExp regex =
                                              RegExp('([A-Za-z0-9_\s]+)');
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter mobile number';
                                          }
                                          if (value.length < 10) {
                                            return 'please enter 10 digit mobile number';
                                          }

                                          return null;
                                        },
                                        onChanged: (text) =>
                                            setState(() => _name = text),
                                      ),
                                    ),
                                  ],
                                )),
                            InkWell(
                              onTap: () {
                                //updateImage();
                                updateProfile();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                margin: EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 21.0,
                                    bottom: 20.0),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Color(0xff420098),
                                  //border: Border.all(color: Color(0xffACABB3)),
                                  borderRadius: BorderRadius.circular(
                                    5.0,
                                  ),
                                ),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Save changes",
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
                ),
              ],
            ),
          )),
    );
  }


  Future<void> updateProfile() async {
    String nameFirst = _firstName.text.toString();
    String nameLast = _lastName.text.toString();
    String emailId = _emailId.text.toString();
    String mobileNumber = _mobileNumber.text.toString();

    if (nameFirst.isNotEmpty &&
        nameLast.isNotEmpty &&
        emailId.isNotEmpty &&
        mobileNumber.isNotEmpty) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/updateUserProfile"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token,
          "platform": 'mobile_application'
        },
        body: jsonEncode({
          "firstName": nameFirst,
          "lastName": nameLast,
          "email": emailId,
          "mobileNumber": mobileNumber,
          //"profileImage":imageFile.toString()
        }),
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString()) as Map<String, dynamic>;
        print(responseJson);
        setState(() {

        });
        final stringRes = JsonEncoder.withIndent('').convert(responseJson);

        Navigator.push(context, MaterialPageRoute(builder: (context) => ProileScreen()));

        print(stringRes);
      } else {
        print("failed");
      }
    } else {
      _submit();
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
