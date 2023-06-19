import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../../demo.dart';
import '../../../editor_demo.dart';
import '../../../notification_screen/Notification.dart';
import '../compliant_pojo/ComplaintPojo.dart';
import 'package:image_picker/image_picker.dart';

import 'message_pojo.dart';

class MessageScreen extends StatefulWidget {
  String? message;
  Tickets? list;
  String? ticket_number;
  String? created;
  String? stat;
  var currentStatus;
  // ignore: non_constant_identifier_names
  MessageScreen({this.message, this.ticket_number, this.created, this.stat,this.currentStatus,this.list});

  @override
  _MessageState createState() =>
      _MessageState(message!, ticket_number!, created!, stat!,currentStatus,list!);
}

class _MessageState extends State<MessageScreen> {
  String message;
  String ticket_number;
  String created;
  var currentStatus;
  Tickets list;
  String stat;
  String token = "";
  TextEditingController _message = TextEditingController();
  _MessageState(this.message, this.ticket_number, this.created, this.stat,this.currentStatus,this.list);
  bool condition = true;
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () => condition = false);

    Stream.periodic(const Duration(seconds: 1))
        .takeWhile((_) => condition)
        .forEach((e) {
      getTicketActivities();
    });
    getToken();

    ticketMessage();
    super.initState();
  }

  void getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 18.0),
                  child: Text(
                    list.title.toString(),
                    style: TextStyle(
                        color: Color(0xff2B2B2B),
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets
                            .only(
                            right:
                            2,bottom: 5.0),
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

                            bottom: 5.0,
                            left:
                            1.0),
                        child: Text(
                          list.ticketNumber.toString(),
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

                    if (list.currentStatus ==
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
                            5.0,
                          ),
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
                              list.currentStatus.toString(),
                              style: TextStyle(
                                  color: Color(0xffFC3A1F),
                                  fontSize: 11.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ] else if (list.currentStatus ==
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
                            5.0,
                           ),
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
                              list.currentStatus.toString(),
                              style: TextStyle(
                                  color: Color(0xff5DAF6A),
                                  fontSize: 11.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ] else if (list.currentStatus ==
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
                            5.0,
                           ),
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
                              list.currentStatus.toString(),
                              style: TextStyle(
                                  color: Color(0xffFF8649),
                                  fontSize: 11.0,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],

                  ],
                )

              ],

            ),
            centerTitle: true,
            backgroundColor: Color(0xffF8F8F8),
            leading: Padding(
                padding: EdgeInsets.all(18),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: SvgPicture.asset('images/forgot_back.svg'))),
            actions: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 8, 15, 8),
                child: PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  list.ticketNumber.toString(),
                                  style: TextStyle(
                                      color: Color(0xff788395),
                                      fontSize: 13.0,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ))
                        ],
                    child: SvgPicture.asset(
                      'images/notification_icon.svg',
                      height: 20.0,
                      width: 20.0,
                    )),
              ),
            ],
            elevation: 0.1,
          ),
        ),
      ),
      //Sandeep Kumar Dogra
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: FutureBuilder<MessagePojo?>(
                future: getTicketActivities(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<TicketActivities>? list=snapshot.data!.ticketActivities;
                    return ListView.builder(
                      itemCount: list?.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        TicketActivities _message=list![index];


                        return   Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                       image: NetworkImage(_message.createdByImage.toString()),
                                        fit: BoxFit.fill
                                    ),
                                  ),

                                ),
                                SizedBox(width: 5.0,),
                                Container(child: Text(_message.createdByName.toString(),style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xff676D75),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),),),
                                SizedBox(width: 5.0,),
                                Container(
                                  margin: EdgeInsets.only(
                                     right: 15.0),
                                  child: Text(_message.createdAt.toString(),style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xff676D75),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter'),),),

                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment:(_message.createdByName == "Sandeep Kumar Dogra"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:(_message.createdByName == "Sandeep Kumar Dogra"
                                        ? Color(0xffEFEFEF)
                                        : Color(0xffefefef)),
                                  ),
                                  padding: EdgeInsets.all(16),

                                  child: Text(
                                    _message.message.toString(),
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xff676D75),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Inter'),
                                  ),
                                ),
                              ),
                            ),
                          ],

                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 84.0,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 294.0,
                        margin: EdgeInsets.only(
                            left: 15.0, top: 22.0, bottom: 20.0),
                        height: 42,
                        decoration: BoxDecoration(
                          color: Color(0xffF6F6FB),
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ),
                        ),
                        child: TextFormField(
                          controller: _message,
                          cursorColor: Color(0xcc2b2b2b),
                          style: TextStyle(color: Color(0xcc2b2b2b)),
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 18.0, right: 10, left: 10.0),
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(12),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {

                                    });

                                  },
                                  child: SvgPicture.asset(
                                    "images/ticket_image.svg",
                                    color: Color(0xff9F9F9F),
                                    width: 13.0,
                                    height: 14.0,
                                  ),
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'Write something',
                              hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xff9A9EAD),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400)),

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

                        setState(() {

                          ticketMessage();
                        });

                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right: 15.0, top: 21.0, bottom: 20.0),
                        child: SvgPicture.asset(
                          "images/message_icon.svg",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> ticketMessage() async {
    String? value;
    if (value == null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.20.94:8081/Api/ticketActivity'));
      request.headers.addAll({
        "content-type": "multipart/form_data",
        "accept-encoding": "gzip",
        "Authorization": token,
        "platform": 'mobile_application'
      });

      request.fields['ticketNumber'] = 'TICKET000333';
      request.fields['message'] = _message.text.toString();
      request.fields['currentStatus'] = 'PROCESSING';
      request.fields['createdAt'] = '06th-Jun-2022 09:55 AM';

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

  Future<MessagePojo?> getTicketActivities() async {
    String message = _message.text.toString();
    print("message" + message);
    var response = await http.post(
      Uri.parse("http://192.168.20.94:8081/Api/getTicketActivities"),
      body: jsonEncode({
        "ticketNumber": 'TICKET000333',
        "createdAt": "06th-Jun-2022 09:55 AM"
      }),
      headers: {
        "content-type": "application/json",
        "accept-encoding": "gzip",
        "Authorization": token,
        "platform": 'mobile_application'
      },
    );

    if (response.statusCode == 200) {
      var res = response.body;
      print(res);
      MessagePojo messagePojo = MessagePojo.fromJson(json.decode(res));
      return messagePojo;
      print(messagePojo);
      final stringRes = JsonEncoder.withIndent('').convert(res);
      print(stringRes);
    } else {
      print("failed");
    }
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
