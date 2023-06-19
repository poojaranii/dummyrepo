import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../demo.dart';
import '../../editor_demo.dart';
import '../../notification_screen/Notification.dart';
import 'compliant_pojo/ComplaintPojo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'message_screen/message_screen.dart';
import 'package:grouped_list/grouped_list.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<ComplaintScreen> {
  String date = "";
  String ticketNumber = "";
  String priority = "";
  var myFormat = DateFormat('yyyy-MM-dd');
  var ticketStatus;
  DateTime selectedDate = DateTime.now();
  String token = "";
  String dropdownvalue = 'Item 1';
  String dropdownvalue1 = 'Item 1';
  bool condition = true;
  SharedPreferences? sharedPreferences;
  List ticket=[];
  List status =[];
  List<Tickets>? list;
  String titile = "";
  String ticketNum = "";
  String createdAt = "";
  var currentStatus;
  String sta = "";
  String dateFormat = "";
  File? imageFile;
  var count;
  TextEditingController _complaintControl = TextEditingController();
  var scrollcontroller = ScrollController();

  _openGalery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });

    }
  }

  @override
  void initState() {
    super.initState();
    scrollcontroller.addListener(pagination);
    Future.delayed(const Duration(seconds: 5), () => condition = false);

    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      getComplaint();
      getTicketType();
      getTicketStatus();
      getComplaintNew();
      getNotification();
    });
    getToken();
  }

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
        ticketNumber = sharedPreferences.getString('ticketNumber')!;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = MediaQuery.of(context).textScaleFactor;
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
                  'All Tickets',
                  style: TextStyle(
                      color: Color(0xff2B2B2B),
                      fontSize: 18.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                backgroundColor: Color(0xffFFFFFF),
                leading: Padding(
                    padding: EdgeInsets.all(18),
                    child: SvgPicture.asset('images/drower.svg')),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Hello()));
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
                            margin:
                                EdgeInsets.only(top: 0, right: 3, bottom: 3),
                            child: Container(
                              width: 20,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffff5252),
                                  border: Border.all(
                                      color: Color(0xffff5252), width: 0)),
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
          //  drawer: Drawer(),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 28.0),
            child: FloatingActionButton(
              backgroundColor: Color(0xff6B87EB),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.54,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(12.0),
                        topRight: const Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 15.0, left: 15.0, right: 15.0),
                          child: Row(
                            children: [
                              Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: new BoxDecoration(
                                  color: Color(0xffEFF0F2),
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      "images/cross.svg",
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(flex: 2),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                    child: Text(
                                  'Create a new ticket ',
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: Color(0xff2B2B2B),
                                      fontSize: 18.0,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600),
                                )),
                              ),
                              Spacer(flex: 2),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Divider(
                          thickness: 1,
                          color: Color(0xffECEDEF),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Ticket",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontSize: 13.0,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 15.0),
                                    height: 42.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xffDFE0E6)),
                                      borderRadius: BorderRadius.circular(
                                        6.0,
                                      ),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: ticketNumber,
                                                hint: Text(
                                                  "Choose Ticket",
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Color(0xff999CAB),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                isExpanded: true,
                                                icon: SvgPicture.asset(
                                                    'images/drop_png.svg',
                                                    color: Color(0xcc2b2b2b)),
                                                items: ticket?.map((item) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color:
                                                              Color(0xcc2b2b2b),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    value: item,
                                                  );
                                                })?.toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    ticketNumber = value as String;
                                                    print("You selected " +
                                                        value);
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        )),
                                  ),
                                  SizedBox(height: 12.0),
                                  Container(
                                    margin: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Title",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Color(0xff2B2B2B),
                                          fontSize: 13.0,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    height: 42.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xffDFE0E6)),
                                      borderRadius: BorderRadius.circular(
                                        6.0,
                                      ),
                                    ),
                                    child: MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaleFactor: 1.0 *
                                              MediaQuery.textScaleFactorOf(
                                                  context)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.bottom,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 16.0, left: 10.0),
                                            border: InputBorder.none,
                                            hintText: 'Enter subject',
                                            hintStyle: TextStyle(
                                                fontSize: 13.0 / scaleFactor,
                                                color: Color(0xff999CAB),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    margin: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Discription",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Color(0xff2B2B2B),
                                          fontSize: 13.0,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    height: 131.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xffDFE0E6)),
                                      borderRadius: BorderRadius.circular(
                                        6.0,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 10.0, right: 10.0),
                                              child: InkWell(
                                                  onTap: () {
                                                    _openGalery(context);
                                                  },
                                                  child: SvgPicture.asset(
                                                    'images/ticket_image.svg',
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Color(0xffDFE0E6),
                                          thickness: 1,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: TextFormField(
                                            textAlignVertical:
                                                TextAlignVertical.bottom,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'Write some description here....',
                                                hintStyle: TextStyle(
                                                    fontSize:
                                                        13.0 / scaleFactor,
                                                    color: Color(0xff999CAB),
                                                    fontFamily: 'Inter',
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: 15.0, right: 15.0, bottom: 15.0),
                                      child: imageFile != null
                                          ? Image.file(
                                              File(imageFile!.path).absolute,
                                              height: 100.0,
                                              width: 100.0,
                                            )
                                          : null),
                                  InkWell(
                                    onTap: () {
                                      getGenrateTicket();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      //  width: 327.0,
                                      margin: EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          top: 9.0,
                                          bottom: 20.0),
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
                                            "Create",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: Color(0xffFFFFFF),
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600),
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
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 294.0,
                        margin: EdgeInsets.only(left: 15.0, top: 21.0),
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffEBE5E5)),
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x4cbeccda),
                              offset: const Offset(
                                1.0,
                                0.0,
                              ),
                              blurRadius: 3.0,
                              spreadRadius: -3.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: TextFormField(
                          controller: _complaintControl,
                          cursorColor: Color(0xcc2b2b2b),
                          style: TextStyle(color: Color(0xcc2b2b2b)),
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                bottom: 16.0,left: 15.0,
                              ),

                              suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                   getComplaint();
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: SvgPicture.asset(
                                    "images/search_icons.svg",
                                    width: 13.0,
                                    height: 14.0,
                                    color: Color(0xff9F9F9F),
                                  ),
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'Search for tickets',
                              hintStyle: TextStyle(
                                  fontSize: 11.0,
                                  color: Color(0xff9F9F9F),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400)),

                          onChanged: (value) {
                            //filterSearchResults(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid emailid';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 9.0,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(12.0),
                                topRight: const Radius.circular(12.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 15.0, left: 15.0, right: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: new BoxDecoration(
                                          color: Color(0xffEFF0F2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              "images/cross.svg",
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                            child: Text(
                                          'Filter',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: Color(0xff2B2B2B),
                                              fontSize: 18.0,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                              child: Text(
                                            'Clear',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: Color(0xffE13939),
                                                fontSize: 14.0,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Color(0xffECEDEF),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 15.0, top: 12.0),
                                            child: Text(
                                              "Date",
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  color: Color(0xff2B2B2B),
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Inter'),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(15.0),
                                            height: 42.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color(0xffDFE0E6)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                6.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              child: StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xcc2b2b2b),
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13.0),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        final DateFormat
                                                            formatter =
                                                            DateFormat(
                                                                'yyyy-MM-dd');
                                                        DateTime? pickedDate =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    selectedDate,
                                                                firstDate:
                                                                    DateTime(
                                                                        2000),
                                                                lastDate:
                                                                    DateTime
                                                                        .now());
                                                        if (pickedDate !=
                                                            null) {
                                                          //   print(
                                                          //      pickedDate);
                                                          final String output =
                                                              formatter.format(
                                                                  pickedDate);

                                                          // print('selectDate' + selectedDate.toString());
                                                          setState(() {
                                                            selectedDate = pickedDate ;
                                                             var dated=myFormat.format(selectedDate);
                                                            print(
                                                                "Date is not selected" + dated);

                                                          });
                                                        } else {
                                                          print(
                                                              "Date is not selected");
                                                        }
                                                      },
                                                      child: SvgPicture.asset(
                                                        'images/calender.svg',
                                                        color:
                                                            Color(0xcc2b2b2b),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              "Ticket",
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                color: Color(0xff2B2B2B),
                                                fontSize: 13.0,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 15.0),
                                            height: 42.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color(0xffDFE0E6)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                6.0,
                                              ),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      StateSetter setState) {
                                                    return DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        value: ticketNumber,
                                                        hint: Text(
                                                          "Choose Ticket",
                                                          style: TextStyle(
                                                              fontSize: 13.0,
                                                              color: Color(
                                                                  0xff999CAB),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        isExpanded: true,
                                                        icon: SvgPicture.asset(
                                                            'images/drop_png.svg',
                                                            color: Color(
                                                                0xcc2b2b2b)),
                                                        items:
                                                            ticket?.map((item) {
                                                          return DropdownMenuItem(
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.0,
                                                                  color: Color(
                                                                      0xcc2b2b2b),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            value: item,
                                                          );
                                                        })?.toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            ticketNumber =
                                                                value as String;
                                                            print(
                                                                "You selected " +
                                                                    ticketNumber);
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  },
                                                )),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 15.0, top: 15.0),
                                            child: Text(
                                              "Status",
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                color: Color(0xff2B2B2B),
                                                fontSize: 13.0,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 15.0),
                                            height: 42.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color(0xffDFE0E6)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                6.0,
                                              ),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      StateSetter setState) {
                                                    return DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        value: ticketStatus,
                                                        hint: Text(
                                                          "Choose Status",
                                                          style: TextStyle(
                                                              fontSize: 13.0,
                                                              color: Color(
                                                                  0xff999CAB),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        isExpanded: true,
                                                        icon: SvgPicture.asset(
                                                            'images/drop_png.svg',
                                                            color: Color(
                                                                0xcc2b2b2b)),
                                                        items: status
                                                            ?.map((items) {
                                                          return DropdownMenuItem(
                                                            child: Text(
                                                              items,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.0,
                                                                  color: Color(
                                                                      0xcc2b2b2b),
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            value: items,
                                                          );
                                                        })?.toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            ticketStatus =
                                                                value;
                                                            print(
                                                                "You selected " +
                                                                    ticketStatus);
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  },
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                getComplaint();
                                              //  getComplaintNew();
                                              });
                                            //  getComplaint();
                                            },
                                            child: Container(
                                              //  width: 327.0,
                                              margin: EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 16,
                                                  bottom: 20.0),
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: Color(0xff420098),
                                                //  border: Border.all(color: Color(0xffACABB3)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  6.0,
                                                ),
                                              ),
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Apply filters",
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                      color: Color(0xffFFFFFF),
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                            ),
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
                      },
                      child: Container(
                        width: 42.0,
                        margin: EdgeInsets.only(right: 15.0, top: 21.0),
                        height: 42.0,
                        decoration: BoxDecoration(
                          color: Color(0xffE4E4E4),
                          //border: Border.all(color: Color(0xffACABB3)),
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(11.0),
                            child: SvgPicture.asset(
                              "images/filter.svg",
                            )),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              //height: 300,
                              child: FutureBuilder<ComplaintPojo?>(
                                  future: getComplaint(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      list = snapshot.data?.tickets;
                                      return list == null
                                          ? Container()
                                          : ListView.builder(
                                              itemCount: list?.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                Tickets ticket = list![index];
                                                String html =
                                                    ticket.description.toString();
                                                RegExp exp = RegExp(r"<[^>]*>",
                                                    multiLine: true,
                                                    caseSensitive: true);
                                                String description =
                                                    html.replaceAll(exp, '');

                                                var now = new DateTime.now();
                                                var formatter = new DateFormat(
                                                    ticket.createdAt);
                                                String formattedTime =
                                                    DateFormat(ticket.createdAt)
                                                        .format(now);
                                                String formattedDate =
                                                    DateFormat.jm().format(now);

                                                titile = ticket.title.toString();
                                                ticketNum = ticket.ticketNumber.toString();
                                                createdAt = ticket.createdAt.toString();
                                                sta = ticket.currentStatus.toString();
                                                priority = ticket.priority.toString();
                                                currentStatus=ticket.currentStatus;

                                                //formattedTime=ticket.createdAt;
                                                var time = dateTimeConverter(
                                                    "time", createdAt);

                                                // formattedDate=ticket.createdAt;
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 15.0,top: 5.0
                                                          ),
                                                      child: Text(
                                                        dateTimeConverter(
                                                            'type', createdAt),
                                                        style: TextStyle(
                                                            color:
                                                                Color(0xff565E6B),
                                                            fontSize: 11.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily: 'Inter'),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => MessageScreen(
                                                                 list : ticket)));
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.99,
                                                        margin: EdgeInsets.only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            top: 10.0,
                                                            bottom: 3),
                                                        height: 97.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            6.0,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0x51beccda),
                                                              offset:
                                                                  const Offset(
                                                                0.0,
                                                                2.0,
                                                              ),
                                                              blurRadius: 9.0,
                                                              spreadRadius: 0.0,
                                                            ), //BoxShadow
                                                          ],
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            18.0,
                                                                        top:
                                                                            15.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'images/mail_icon.svg',
                                                                    )),
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            10.0,
                                                                        top:
                                                                            12.0),
                                                                    child: Text(
                                                                      titile,
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xff2B2B2B),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              13.0),
                                                                    )),
                                                                Spacer(
                                                                  flex: 1,
                                                                ),
                                                                Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            right:
                                                                                2),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'images/group.svg',
                                                                      height:
                                                                          8.0,
                                                                      width:
                                                                          14.0,
                                                                    )),
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            12.0,
                                                                        bottom:
                                                                            1.0,
                                                                        left:
                                                                            1.0),
                                                                    child: Text(
                                                                      ticketNum,
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xff6B87EB),
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              11.0),
                                                                    )),
                                                              ],
                                                            ),

                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: 247.0,
                                                                  height: 26.0,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              48.0,
                                                                          top:
                                                                              2),
                                                                  child: Text(
                                                                    description,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11.0,
                                                                        color: Color(
                                                                            0xff788395),
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                if (ticket
                                                                        .priority ==
                                                                    'LOW') ...[
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.14,
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            45.0,
                                                                        right:
                                                                            10.0,
                                                                        bottom:
                                                                            8,
                                                                        top:
                                                                            8.0),
                                                                    height: 18,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffEDEEF3),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        4.0,
                                                                      ),
                                                                    ),
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                          ticket.priority.toString(),
                                                                          style: TextStyle(
                                                                              color: Color(0xff8F94A0),
                                                                              fontSize: 11.0,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                  )
                                                                ] else if (ticket
                                                                        .priority ==
                                                                    'HIGH') ...[
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.14,
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            45.0,
                                                                        right:
                                                                            10.0,
                                                                        bottom:
                                                                            8,
                                                                        top:
                                                                            8.0),
                                                                    height: 18,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffFFE3D4),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        4.0,
                                                                      ),
                                                                    ),
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                          ticket.priority.toString(),
                                                                          style: TextStyle(
                                                                              color: Color(0xffFF8649),
                                                                              fontSize: 11.0,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                  ),
                                                                ] else if (ticket
                                                                        .priority ==
                                                                    'MEDIUM') ...[
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.14,
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            45.0,
                                                                        right:
                                                                            10.0,
                                                                        bottom:
                                                                            8,
                                                                        top:
                                                                            8.0),
                                                                    height: 18,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffE5FFEA),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        4.0,
                                                                      ),
                                                                    ),
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                          ticket.priority.toString(),
                                                                          style: TextStyle(
                                                                              color: Color(0xff5DAF6A),
                                                                              fontSize: 11.0,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                  ),
                                                                ],


                                                                if (currentStatus ==
                                                                    "PENDING") ...[
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.18,
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            0.0,
                                                                        right:
                                                                            10.0,
                                                                        bottom:
                                                                            8.0,
                                                                        top:
                                                                            8.0),
                                                                    height: 16,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffFFD4CE),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        4.0,
                                                                      ),
                                                                    ),
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                          ticket.currentStatus.toString(),
                                                                          style: TextStyle(
                                                                              color: Color(0xffFC3A1F),
                                                                              fontSize: 11.0,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                  ),
                                                                ] else if (currentStatus ==
                                                                    "CLOSED") ...[
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.18,
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            0.0,
                                                                        right:
                                                                            10.0,
                                                                        bottom:
                                                                            8.0,
                                                                        top:
                                                                            8.0),
                                                                    height: 16,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffE5FFEA),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        4.0,
                                                                      ),
                                                                    ),
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                          ticket.currentStatus.toString(),
                                                                          style: TextStyle(
                                                                              color: Color(0xff5DAF6A),
                                                                              fontSize: 11.0,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                  ),
                                                                ] else if (currentStatus ==
                                                                    'PROCESSING') ...[
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.20,
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            0.0,
                                                                        right:
                                                                            10.0,
                                                                        bottom:
                                                                            8.0,
                                                                        top:
                                                                            8.0),
                                                                    height: 16,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xffFFE3D4),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        4.0,
                                                                      ),
                                                                    ),
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                          ticket
                                                                              .currentStatus.toString(),
                                                                          style: TextStyle(
                                                                              color: Color(0xffFF8649),
                                                                              fontSize: 11.0,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                  ),
                                                                ],


                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.22,
                                                                  margin: EdgeInsets.only(
                                                                      left: 0.0,
                                                                      right:
                                                                          0.0,
                                                                      bottom:
                                                                          8.0,
                                                                      top: 8.0),
                                                                  height: 16,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffE5FFEA),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      4.0,
                                                                    ),
                                                                  ),
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        ticket
                                                                            .ticketType.toString(),
                                                                        style: TextStyle(
                                                                            color: Color(
                                                                                0xff5DAF6A),
                                                                            fontSize:
                                                                                11.0,
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      )),
                                                                ),
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            6.0,
                                                                        right:
                                                                            0.0,
                                                                        bottom:
                                                                            8.0,
                                                                        top:
                                                                            8.0),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'images/clock.svg',
                                                                    )),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.only(
                                                                        left:
                                                                            2.0,
                                                                        right:
                                                                            10.0,
                                                                        bottom:
                                                                            8.0,
                                                                        top:
                                                                            9.0),
                                                                    height: 16,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      //border: Border.all(color: Color(0xffACABB3)),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        4.0,
                                                                      ),
                                                                    ),
                                                                    child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                          time,
                                                                          style: TextStyle(
                                                                              color: Color(0xffD2D3D9),
                                                                              fontSize: 11.0,
                                                                              fontFamily: 'Inter',
                                                                              fontWeight: FontWeight.w400),
                                                                        )),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ),

                            Visibility(
                              visible: false,
                              child: Container(
                                margin: EdgeInsets.only(left: 15.0, top: 9.0),
                                child: Text(
                                  "YESTERDAY",
                                  style: TextStyle(
                                      color: Color(0xff565E6B),
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Container(
                                //height: 300,
                                child: ListView.builder(
                                    itemCount: 5,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          if (index == 1) {}
                                          if (index == 2) {}
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 4.0, top: 10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.99,
                                            margin: EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              //  top: 12.0,
                                            ),
                                            height: 97.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 18.0,
                                                            top: 15.0),
                                                        child: SvgPicture.asset(
                                                          'images/mail_icon.svg',
                                                        )),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10.0,
                                                            top: 12.0),
                                                        child: Text(
                                                          "My sim is not activated",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff2B2B2B),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13.0),
                                                        )),
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 35),
                                                        child: SvgPicture.asset(
                                                          'images/group.svg',
                                                          height: 8.0,
                                                          width: 14.0,
                                                        )),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 12.0,
                                                            bottom: 1.0,
                                                            left: 1.0),
                                                        child: Text(
                                                          "HMACSHA256",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff6B87EB),
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 11.0),
                                                        )),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 45.0, top: 2),
                                                  child: Text(
                                                    "Lorem ipsum dolor sit amet,consectetur\nadipiscing elit,sed do eiusmod tempor incidident.",
                                                    style: TextStyle(
                                                        fontSize: 11.0,
                                                        color:
                                                            Color(0xff788395),
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                Row(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 41,
                                                      margin: EdgeInsets.only(
                                                          left: 45.0,
                                                          right: 10.0,
                                                          bottom: 8,
                                                          top: 8.0),
                                                      height: 16,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffEDEEF3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          4.0,
                                                        ),
                                                      ),
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Low",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff8F94A0),
                                                                fontSize: 11.0,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                    ),
                                                    Container(
                                                      width: 41,
                                                      margin: EdgeInsets.only(
                                                          left: 0.0,
                                                          right: 10.0,
                                                          bottom: 8.0,
                                                          top: 8.0),
                                                      height: 16,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffE5FFEA),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          4.0,
                                                        ),
                                                      ),
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Open",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff5DAF6A),
                                                                fontSize: 11.0,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                    ),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 0.0,
                                                            right: 0.0,
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                        child: SvgPicture.asset(
                                                          'images/clock.svg',
                                                        )),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2.0,
                                                          right: 10.0,
                                                          bottom: 8.0,
                                                          top: 8.0),
                                                      height: 16,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        //border: Border.all(color: Color(0xffACABB3)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          4.0,
                                                        ),
                                                      ),
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "11.30 AM",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xffD2D3D9),
                                                                fontSize: 11.0,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<ComplaintPojo?> getComplaint() async {
    String? complaintControl = _complaintControl.text.toString();
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getTicketDetails"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body:jsonEncode({
          "date": myFormat.format(selectedDate),
         // "type": "DATE",
          "pageNo": 1,
          "status": ticketStatus,
          "ticketType": ticketNumber,
         "searchText":complaintControl

        }),
      );

      if (response.statusCode == 200) {
        var res = response.body;
        print('hello' + res);
        ComplaintPojo complaintPojo = ComplaintPojo.fromJson(json.decode(res));
        return complaintPojo;

        final stringRes = JsonEncoder.withIndent('').convert(res);
        print(stringRes);
      } else {
        print("failed");
      }
    }
  }


  Future<String?> getTicketType() async {
    String? value;
    if (value == null) {
      var response = await http.get(
        Uri.parse("http://192.168.20.94:8081/Api/getTicketTypes"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
      );
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body.toString());

        setState(() {
          ticket = res['ticketTypes'];
        });

        final stringRes = JsonEncoder.withIndent('').convert(res);
        print(stringRes);
      } else {
        print("failed");
      }
      return value;
    }
  }

  Future<String?> getTicketStatus() async {
    String? value;
    if (value == null) {
      var response = await http.get(
        Uri.parse("http://192.168.20.94:8081/Api/getTicketStatus"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
      );
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body.toString());
        setState(() {
          status = res['ticketStatus'];
        });

        final stringRes = JsonEncoder.withIndent('').convert(res);
        print(stringRes);
      } else {
        print("failed");
      }
      return value;
    }
  }

  Future<void> getComplaintNew() async {
    String? value;
    if (value == null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getTicketDetails"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
        body: jsonEncode({
          "date": myFormat.format(selectedDate),
          "type": "DATE",
          "pageNo": 1,
          "status": ticketStatus,
          "ticketType": ticketNumber,
        }),
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString());

        print(responseJson);

        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed");
      }
    }
  }

  Future<void> getGenrateTicket() async {
    String? value;
    if (value == null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.20.94:8081/Api/generateTicket'));
      request.headers.addAll({
        "content-type": "multipart/form_data",
        "accept-encoding": "gzip",
        "Authorization": token,
        "platform": 'mobile_application'
      });

      request.fields['ticketType'] = 'APPLICATION';
      request.fields['title'] = 'not warking properly';
      request.fields['description'] = 'come fast';

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final decodedMap = json.decode(responseString);

        print(decodedMap);

        final stringRes = JsonEncoder.withIndent('').convert(decodedMap);
        print(stringRes);
      } else {
        print("failed");
      }
    }
  }

  String dateTimeConverter(String type, String currentDate) {
    var result = '';
    var dateArray = currentDate.split(' ');
    if (type == 'time') {
      result = dateArray[1].trim() + " " + dateArray[2].trim();
    } else {
      result = dateArray[0].trim();
    }
    return result;
  }

  getFormatedDate(_date) {
    var inputFormat = DateFormat('dd-MM-yyyy HH:mm a');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
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
        body: jsonEncode({"isRead": 'false'}),
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
  void pagination() {

    }
  }


