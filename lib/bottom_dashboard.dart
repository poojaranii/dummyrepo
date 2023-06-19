
import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navigation_screen/complaint_screen/complain.dart';
import 'navigation_screen/dashboard_screen/dashboard_screen.dart';
import 'navigation_screen/kyc_screen/kyc_screen.dart';
import 'navigation_screen/profile/profil_screen/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoard extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<DashBoard> {

  ListQueue<int> _navigationQueue =ListQueue();
  int index=0;

  Future<bool> _onWillPop(BuildContext context) async {
    bool exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  CupertinoAlertDialog _buildExitDialog(BuildContext context) {
    return CupertinoAlertDialog(
   //   title: Text("??!"),
      content: Text("Do you Really Want to Delete the App.",textScaleFactor: 1.0,style: TextStyle(color: Color(
          0xff1a1a1d),fontFamily: 'Inter',
          fontWeight: FontWeight.w600,fontSize: 15.0,),),
      actions: [
        // Close the dialog
        // You can use the CupertinoDialogAction widget instead
        CupertinoButton(
            child: Text('NO',textScaleFactor: 1.0,style: TextStyle(color: Color(0xd7ff222f),fontFamily: 'Inter',
              fontWeight: FontWeight.w500,fontSize: 13.0,),),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        CupertinoButton(
          child: Text('YES',textScaleFactor: 1.0,style: TextStyle(color: Color(0xd5d42256),fontFamily: 'Inter',
            fontWeight: FontWeight.w500,fontSize: 13.0,)),
          onPressed: () {
            // Do something
            print('I agreed');

            // Then close the dialog
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  int _currentIndex = 0;

  GlobalKey<NavigatorState> _page1 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _page2 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _page3 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _page4 = GlobalKey<NavigatorState>();

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        if(_currentIndex == 0){
          _onWillPop(context);
          return true;
        }
        setState(() {
          _currentIndex = 0;
        });

        return false;

      },

      child: Scaffold(

        body: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            Navigator(
              key: _page1,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => DashBoardScreen(),
              ),
            ),
            Navigator(
              key: _page2,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => KycScreen(),
              ),
            ),
            Navigator(
              key: _page3,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => ComplaintScreen(),
              ),
            ),
            Navigator(
              key: _page4,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => ProileScreen(),
              ),
            ),
          ],
        ),

        bottomNavigationBar: Container(
          height: 90.0,
         // width: 373.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              6.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x28000000),
                offset: const Offset(
                  0.0,
                  1.0,
                ),
                blurRadius: 16.0,
                spreadRadius: 0.0,
              ), //BoxShadow

            ],
          ),
          child: BottomNavigationBar(
            unselectedIconTheme: IconThemeData(color: Color(0xff545660)),
            selectedIconTheme: const IconThemeData(color: Color(0xff420098),),
            unselectedLabelStyle: TextStyle(color: Color(0xff545660),fontWeight: FontWeight.w500,fontFamily: 'Inter',fontSize: 13.0),
            selectedLabelStyle: const TextStyle(color: Color(0xff420098),fontWeight: FontWeight.w500,fontFamily: 'Inter',fontSize: 13.0),
            fixedColor: Color(0xff420098),
            type: BottomNavigationBarType.fixed,
            elevation: 25.0,
            onTap: onTapped,
            currentIndex: _currentIndex,

            items:  [
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(2.0),
                child: _currentIndex==0? SvgPicture.asset('images/bottom_dashboard.svg'):SvgPicture.asset("images/bottom_dashboard.svg",color: Color(0xff545660),),
          ) ,
                label: "Dashboard",

              ),
              BottomNavigationBarItem(
                icon:Container(
                  padding: EdgeInsets.only( top: 3.0,left: 3.0,bottom: 3.0,right: 4.0),
                  child:_currentIndex==1?new SvgPicture.asset("images/bottom_kyc_icon.svg",color: Color(0xff420098),):new SvgPicture.asset("images/bottom_kyc_icon.svg",),
                ) ,
                  label: "KYC"

              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(2.0),
                  child:_currentIndex==2?new SvgPicture.asset('images/complaint_bottom_icon.svg',color: Color(0xff420098),):new SvgPicture.asset('images/complaint_bottom_icon.svg'),
                ),
                  label: "Complaint"

              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(2.0),
                  child:_currentIndex==3?new SvgPicture.asset('images/profile_bottom_icon.svg',color: Color(0xff420098),):new SvgPicture.asset('images/profile_bottom_icon.svg'),
                ),
                  label: "Account"
              ),
            ],

          ),
        ),
      ),
    );
  }
}