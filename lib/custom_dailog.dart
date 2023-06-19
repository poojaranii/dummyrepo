
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
     this.title,
     this.description,
  }) : super(key: key);

  final String? title, description;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: 345,
        height: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 41),
           Image.asset('images/crown.png'),
            SizedBox(height: 22),
            Text("${widget.description}",style: TextStyle(fontSize: 16.0,color: Color(0xff000000),fontWeight: FontWeight.w500),),
            SizedBox(height: 30,),
            Divider(color: Color(0x84000000),),

            IntrinsicHeight(
                child:Row(
                  children: [
                    Expanded(
                      child:Card(
                        child: Container(
                          height: 30,
                          color: Colors.black12,
                        ),
                      ),
                    ),

                    VerticalDivider(
                      color: Colors.black,
                      thickness: 3, //thickness of divier line
                    ),

                    Expanded(
                      child:Card(
                        child: Container(
                          height: 30,
                          color: Colors.black12,
                        ),
                      ),
                    )
                  ],
                )
            )
            // IntrinsicHeight(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       Text('Cancel', style: TextStyle(color: Color(0xffEB6B6B),fontSize: 15),),
            //       SizedBox(
            //         width: 40,
            //         child: VerticalDivider(
            //           width: 20,
            //           indent: 5,
            //           // endIndent: 0,
            //           color: Color(0x84000000),
            //         ),
            //       ),
            //       Text('Upgrade', style: TextStyle(color: Color(0xff6B87EB)),)
            //     ],
            //   ),
            // )

          ],
        ),
      ),
    );
  }
}