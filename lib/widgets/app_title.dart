import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTitle extends StatelessWidget {
  AppTitle(
      {Key? key,
      required this.txt,
      this.fontSize,
      this.maxLine = 1,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  final String txt;
  double? fontSize;
  int maxLine;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return txt != ''
        ? Text(
            txt,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: fontSize??16,
                color: color,
                fontWeight: fontWeight),
            softWrap: false,
            maxLines: maxLine,
            overflow: TextOverflow.ellipsis, // new
          )
        : Container(
            width: 100.w,
            height: 5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[800],
            ),
          );
  }
}
