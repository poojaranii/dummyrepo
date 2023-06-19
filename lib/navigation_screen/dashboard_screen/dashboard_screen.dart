import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:ich/navigation_screen/dashboard_screen/GraphPojo.dart';
import '../../barchar_model.dart';
import '../../demo.dart';
import '../../notification_screen/Notification.dart';
import '../../tooltip.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  String token="";
  var totalInstalation;
  var currentMonh;
  List order=[];
  List installation =[];
  List chartData=[];
  List renewal =[];
  List expired =[];
  List customer=[];
  List verified =[];
  var count;
  var totalRenewal;
  var currentRenewal;
  String? currentYear;
  var totalExpired;
  var currentExpired;

  var totalCustomer;
  var currentCustomer;
  bool condition = true;
  var totalVehical;
  var currentVehical;

  var totalOrder;
  var currentOrder;
  List orders=[];
  @override
  void setState(VoidCallback fn) {
   // var list = []..addAll(data)..addAll(orders);
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    getToken();
    getDashboard();
    getGraph();
    getNotification();
  }

  @override
  void didChangeDependencies() {
    getToken();
    getDashboard();
    getGraph();
    getNotification();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DashBoardScreen oldWidget) {
    getToken();
    getDashboard();
    getGraph();
    getNotification();
    super.didUpdateWidget(oldWidget);
  }

  void getToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(mounted) {
      setState(() {
        token = sharedPreferences.getString('login')!;
      });
      return;
    }
  }

   List<SubscriberSeries> data = [
    SubscriberSeries(
      year: "Jan",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Feb",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Mar",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Apr",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "May",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Jun",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Jul",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Aug",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Sep",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Oct",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Nov",
      subscribers: 0,
    ),
    SubscriberSeries(
      year: "Dec",
      subscribers: 0,
    ),
  ];



  String? text;
  String selected = "first";
  String? textSelected;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    print('ppppppiffo');
    // List<charts.Series<SubscriberSeries, String>> series = [
    //   charts.Series(
    //     id: 'mySeriesId', // Provide a unique identifier for the series
    //     data: data,
    //     domainFn: (SubscriberSeries series, _) => series.year,
    //     measureFn: (SubscriberSeries series, _) => series.subscribers,
    //   ),
    // ];
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
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              automaticallyImplyLeading: false,
              title: SvgPicture.asset(
                'images/logo_idemia.svg',
                color: Color(0xff420098),
                height: 28.0,
                width: 110.0,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              leading: Padding(
                  padding: EdgeInsets.all(18),
                  child: SvgPicture.asset('images/drower.svg')),
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
        body: Container(
          child: Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if(currentYear=='installations'){
                          Future.delayed(const Duration(seconds: 5), () => condition = false);
                          Stream.periodic(const Duration(seconds: 1))
                              .takeWhile((_) => condition)
                              .forEach((e) {
                            getGraph();
                          });

                        }
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: EdgeInsets.only(left: 15.0, top: 21.0),
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == 0
                              ? Color(0xff420098)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xd000000),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 6.0),
                              child: Text(
                                "TOTAL INSTALLATIONS",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 0
                                        ? Color(0xc8ffffff)
                                        : Color(0xc8848484),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                "$totalInstalation",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 0
                                        ? Color(0xffffffff)
                                        : Color(0xd5d42256),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 5.0),
                              child: Text(
                                "THIS MONTH: $currentMonh",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 0
                                        ? Color(0xc8ffffff)
                                        : Color(0x5c3a3737),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = 1;
                          updateChart('renewals');
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: EdgeInsets.only(top: 21.0),
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == 1
                              ? Color(0xff420098)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xd000000),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 6.0),
                              child: Text(
                                "TOTAL RENEWAL",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 1
                                        ? Color(0xc6ffffff)
                                        : Color(0xc8848484),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                "$totalRenewal",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 1
                                        ? Colors.white
                                        : Color(0xd5d42256),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 5.0),
                              child: Text(
                                "THIS MONTH: $currentRenewal" ,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 1
                                        ? Colors.white
                                        : Color(0x5c3a3737),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = 2;
                            updateChart('expired');
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          margin: EdgeInsets.only(right: 15.0, top: 21),
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: _currentIndex == 2
                                ? Color(0xff420098)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(
                              6.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xd000000),
                                offset: const Offset(
                                  0.0,
                                  4.0,
                                ),
                                blurRadius: 4.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 9.0, top: 6.0),
                                child: Text(
                                  "TOTAL EXPIRED",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: _currentIndex == 2
                                          ? Colors.white
                                          : Color(0xc8848484),
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.0, top: 5.0),
                                child: Text(
                                  "$totalExpired",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: _currentIndex == 2
                                          ? Color(0xffFFFFFF)
                                          : Color(0xd7ff222f),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 9.0, top: 5.0),
                                child: Text(
                                  "THIS MONTH: $currentExpired",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: _currentIndex == 2
                                          ? Color(0xffFFFFFF)
                                          : Color(0x5d3a3737),
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                        updateChart('customers');
                          _currentIndex = 3;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: EdgeInsets.only(left: 15.0, top: 12.0),
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == 3
                              ? Color(0xff420098)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xd000000),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 6.0),
                              child: Text(
                                "TOTAL CUSTOMER",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 3
                                        ? Color(0xc6ffffff)
                                        : Color(0xc8848484),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                "$totalCustomer" ,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 3
                                        ? Color(0xffFFFFFF)
                                        : Color(0xd74a69b8),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 5.0),
                              child: Text(
                                "THIS MONTH: $currentCustomer" ,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 3
                                        ? Colors.white
                                        : Color(0x5d3a3737),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = 4;
                          updateChart('verifiedInstallations');
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        margin: EdgeInsets.only(top: 12.0),
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == 4
                              ? Color(0xff420098)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            6.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xd000000),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 6.0),
                              child: Text(
                                "TOTAL VERIFIED",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 4
                                        ? Color(0xc6ffffff)
                                        : Color(0xc8848484),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                "$totalVehical" ,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 4
                                        ? Color(0xffFFFFFF)
                                        : Color(0xd5d4a222),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 9.0, top: 5.0),
                              child: Text(
                                "THIS MONTH: $currentVehical" ,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: _currentIndex == 4
                                        ? Color(0xc6ffffff)
                                        : Color(0x5d3a3737),
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = 5;
                            updateChart('orders');
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.30,
                          margin: EdgeInsets.only(right: 15.0, top: 12),
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: _currentIndex == 5
                                ? Color(0xff420098)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(
                              6.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xd000000),
                                offset: const Offset(
                                  0.0,
                                  4.0,
                                ),
                                blurRadius: 4.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 9.0, top: 6.0),
                                child: Text(
                                  "TOTAL ORDERS",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: _currentIndex == 5
                                          ? Color(0xc8ffffff)
                                          : Color(0xc6848484),
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 9.0, top: 5.0),
                                child: Text(
                                  "$totalOrder",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: _currentIndex == 5
                                          ? Color(0xffFFFFFF)
                                          : Color(0xd5ff5d02),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.0, top: 5.0),
                                child: Text(
                                  "THIS MONTH: $currentOrder",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: _currentIndex == 5
                                          ? Color(0xc6ffffff)
                                          : Color(0x5d3a3737),
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            // Container(
                            //   margin: EdgeInsets.only(
                            //       left: 15.0, right: 15.0, bottom: 20.0),
                            //   height: MediaQuery.of(context).size.height * 0.55,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     //  border: Border.all(color: Color(0xffACABB3)),
                            //     borderRadius: BorderRadius.circular(
                            //       6.0,
                            //     ),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Color(0x5000000),
                            //         offset: const Offset(
                            //           0.0,
                            //           4.0,
                            //         ),
                            //         blurRadius: 4.0,
                            //         spreadRadius: 0.0,
                            //       ), //BoxShadow
                            //     ],
                            //   ),
                            //   child: Container(
                            //     margin: EdgeInsets.all(10.0),
                            //     child:
                            //     charts.BarChart(
                            //       series,
                            //       animate: true,
                            //       vertical: true,
                            //       defaultRenderer: new charts.BarRendererConfig(
                            //         maxBarWidthPx: 25,
                            //       ),
                            //       selectionModels: [
                            //         charts.SelectionModelConfig(changedListener:
                            //             (charts.SelectionModel model) {
                            //           if (model.hasDatumSelection) {
                            //             final value = model.selectedSeries[0]
                            //                 .measureFn(
                            //                     model.selectedDatum[0].index);
                            //             CustomCircleSymbolRenderer.value =
                            //                 value.toString();
                            //             print(model.selectedSeries[0].measureFn(
                            //                 model.selectedDatum[0].index));
                            //           }
                            //         })
                            //       ],
                            //       behaviors: [
                            //         new charts.LinePointHighlighter(
                            //           symbolRenderer:
                            //               CustomCircleSymbolRenderer(),
                            //           drawFollowLinesAcrossChart: false,
                            //           defaultRadiusPx: 5,
                            //           showVerticalFollowLine: charts
                            //               .LinePointHighlighterFollowLineType
                            //               .none,
                            //           selectionModelType:
                            //               charts.SelectionModelType.info,
                            //           showHorizontalFollowLine: charts
                            //               .LinePointHighlighterFollowLineType
                            //               .none,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> getDashboard() async {
    String? value;
    if(value==null){
      var response = await http.get(
        Uri.parse("http://192.168.20.94:8081/Api/getDealerDashboardStats"),
        headers:{
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        if (mounted == true) {
          setState(() {
            totalInstalation = int.parse(responseJson['stats']['totalInstallations'].toString());
            currentMonh= int.parse(responseJson['stats']['currentMonthInstallations'].toString());

            totalRenewal=int.parse(responseJson['stats']['totalRenewals'].toString());
            currentRenewal=int.parse(responseJson['stats']['currentMonthRenewals'].toString());

            totalExpired=int.parse(responseJson['stats']['totalExpired'].toString());
            currentExpired=int.parse(responseJson['stats']['currentMonthExpired'].toString());

            totalCustomer=int.parse(responseJson['stats']['totalCustomers'].toString());
            currentCustomer=int.parse(responseJson['stats']['currentMonthCustomers'].toString());

            totalVehical=int.parse(responseJson['stats']['totalVerifiedInstallations'].toString());
            currentVehical=int.parse(responseJson['stats']['currentMonthVerifiedInstallations'].toString());

            totalOrder=int.parse(responseJson['stats']['totalOrders'].toString());
            currentOrder=int.parse(responseJson['stats']['currentMonthOrders'].toString());
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

  Future<String?> getGraph() async {
    String? value;
    if(value==null) {
      var response = await http.post(
        Uri.parse("http://192.168.20.94:8081/Api/getDealerDashboardCharts"),
        headers: {
          "content-type": "application/json",
          "accept-encoding": "gzip",
          "Authorization": token
        },
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body.toString());

        setState(() {

          installation=responseJson['installations'];
          expired=responseJson['expired'];
          customer=responseJson['customers'];
          verified=responseJson['verifiedInstallations'];
          orders=responseJson['orders'];
          renewal=responseJson['renewals'];
          updateChart('installations');

       });
        final stringRes = JsonEncoder.withIndent('').convert(responseJson);
        print(stringRes);
      } else {
        print("failed");
      }
      return value;
    }
  }

    updateChart(String type){

    if(type=='installations'){
      chartData=installation;
    } else if(type=='expired'){
      chartData=expired;
    } else if(type=='customers'){
      chartData=customer;
    } else if(type=='verifiedInstallations'){
      chartData=verified;
    } else if(type=='orders'){
      chartData=orders;
    } else if(type=='renewals'){
      chartData=renewal;
    }
    data = [
      SubscriberSeries(year: "Jan",subscribers: chartData[0]),
      SubscriberSeries(year: "Feb",subscribers:chartData[1]),
      SubscriberSeries(year: "Mar",subscribers: chartData[2]),
      SubscriberSeries(year: "Apr",subscribers: chartData[3]),
      SubscriberSeries(year: "May",subscribers: chartData[4]),
      SubscriberSeries(year: "Jun",subscribers: chartData[5]),
      SubscriberSeries(year: "Jul",subscribers: chartData[6]),
      SubscriberSeries(year: "Aug",subscribers: chartData[7]),
      SubscriberSeries(year: "Sep",subscribers: chartData[8]),
      SubscriberSeries(year: "Oct",subscribers: chartData[9]),
      SubscriberSeries(year: "Nov",subscribers: chartData[10]),
      SubscriberSeries(year: "Dec",subscribers: chartData[11]),
    ];
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
