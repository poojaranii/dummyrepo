import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../login/dealerlogin_screen/DealerLogin_screen.dart';
import '../login/userlogin_sceen/userlogin_screen.dart';
class LoginClass extends StatefulWidget {
  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<LoginClass>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Color(0xffF8F8F8),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 100.0, left: 131.0, right: 117.0),
                child: SvgPicture.asset(
                  'images/login_logo.svg',

                  color: Color(0xff420098),
                ),
              ),
              Container(
                //  width: 178.0,
                margin: EdgeInsets.only(top: 22.0,  ),
                child: Text(
                  "Welcome Back,",
                  style: TextStyle(fontSize: 24.0, color: Color(0xff2B2B2B),fontFamily: 'Inter',fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                // width: 160.0,
                margin: EdgeInsets.only(top: 6.0,),
                child: Text(
                  "Please login to continue",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xae353750),fontWeight: FontWeight.w500,fontFamily: 'Inter'
                  ),
                ),
              ),

              // give the tab bar a height [can change hheight to preferred height]
              Container(
                margin: EdgeInsets.only(top: 57.0,left: 15.0,right: 15.0),
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff7D1DFB)),
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(
                    6.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3),
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                    ),
                    color: Color(0xff420098),
                  ),
                  labelColor: Color(0xffFFFFFF),
                  unselectedLabelColor: Color(0xff7D1DFB),
                  tabs: [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Dealer',
                    ),

                    // second tab [you can add an icon using the icon property]
                    Tab(
                      text: 'User',
                    ),
                  ],
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    DealerScreen(onSubmit: (String value) {  },),
                    UserScreen(onSubmit: (String value) {  },),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}