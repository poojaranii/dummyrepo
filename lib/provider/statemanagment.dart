import 'package:flutter/material.dart';

import '../login/dealerlogin_screen/DealerLogin_screen.dart';
import '../login/userlogin_sceen/userlogin_screen.dart';
class StackOver extends StatefulWidget {
  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<StackOver>
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
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 100.0, left: 131.0, right: 117.0),
              child: Image.asset(
                'images/logo-idemia.png',
                width: 127.0,
                height: 32.0,
                color: Color(0xff420098),
              ),
            ),
            Container(
              //  width: 178.0,
              margin: EdgeInsets.only(top: 22.0, left: 98.0, right: 99.0),
              child: Text(
                "Welcome Back,",
                style: TextStyle(fontSize: 24.0, color: Color(0xff2B2B2B),fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              // width: 160.0,
              margin: EdgeInsets.only(top: 6.0, left: 98.0, right: 117.0),
              child: Text(
                "Please login to continue",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff353750),fontWeight: FontWeight.w500
                ),
              ),
            ),

            // give the tab bar a height [can change hheight to preferred height]
            Container(
              margin: EdgeInsets.only(top: 57.0,left: 24.0,right: 24.0),
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff7D1DFB)),
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  6.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    6.0,
                  ),
                  color: Color(0xff7D1DFB),
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
    );
  }
}