import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final Color backgroundColor;
  final String image;

  const CustomAppBar({Key? key,required this.title,required this.backgroundColor,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: AppBar(
        foregroundColor:Color(0xffFFFFFF),
        title: Text(title,style: TextStyle(color: Color(0xff2B2B2B),fontSize: 18.0,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600),),centerTitle: true,
        backgroundColor: backgroundColor,
        leading: Padding(
            padding: EdgeInsets.all(18),
            child: SvgPicture.asset(image)),
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 8, 20, 8),
            child:SvgPicture.asset('images/bell_icon.svg',height: 21.0,width: 16.0,),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 8, 15, 8),
            child: SvgPicture.asset('images/message.svg',height: 20.0,width: 20.0,),
          ),

          // Image.asset('images/notification_appbar.png'),
        ],
        elevation: 0,
        bottomOpacity: 16,
      ),
    );

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);


}
