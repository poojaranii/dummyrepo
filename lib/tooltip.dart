import 'dart:math';
// import 'package:charts_flutter/flutter.dart';
// import 'package:charts_flutter/src/text_element.dart' as charts_text;
// import 'package:charts_flutter/src/text_style.dart' as style;

// class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
//   static String? value;
//   @override
//   void paint(ChartCanvas canvas, Rectangle<num> bounds, {List<int>? dashPattern, Color? fillColor, FillPatternType? fillPattern, Color? strokeColor, double? strokeWidthPx}) {
//     super.paint(canvas, bounds,
//         dashPattern: dashPattern,
//         fillColor: fillColor,
//         fillPattern: fillPattern,
//         strokeColor: strokeColor,
//         strokeWidthPx: strokeWidthPx);
//     var textStyle = style.TextStyle();
//     textStyle.color = Color.black;
//     textStyle.fontSize = 15;
//
//     canvas.drawText(
//         charts_text.TextElement("$value", style: textStyle),
//       (bounds.left - 4).round(),
//       (bounds.top - 16).round(),
//     );
//   }
//  // RegExp regex =
//  // RegExp('([A-Za-z0-9_\s]+)');
//  // if (value == null || value.isEmpty) {
//  // return 'Please enter last name';
// //  }
//  // if (value.length < 1) {
//  // return 'Minimum length 1';
//  // }
//  // if (value.length > 50) {
//  // return 'Not exceed 50';
//  // }
//  // return null;
// //},
// //onChanged: (text) =>
// //setState(() => _name = text),
// //
//   //RegExp regex = RegExp(
//   //    '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.]{1}[a-zA-Z]{2,}');
// //  if (value == null || value.isEmpty) {
// //  return 'Please enter valid Email';
// //  }
// //  if (value.length < 1) {
// //  return 'Minimum length 1';
// //  }
// //  if (value.length > 50) {
// //  return 'Not exceed 50';
// //  }
// //  return null;
// //},
// //onChanged: (text) =>
// //setState(() => _name = text),
// //
//  // RegExp regex =
//  // RegExp('[7-9]{1}[0-9]{9}');
//   //if (value == null || value.isEmpty) {
//  // return 'Please enter 10 digit mobile no';
//   //}
//  // return null;
// //},
// //onChanged: (text) =>
// //setState(() => _name = text),
//  }