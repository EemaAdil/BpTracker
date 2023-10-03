import 'package:bptracker/widgets/scroll_glow.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppContainer extends StatelessWidget {
  AppContainer({Key? key, required this.child}) : super(key: key);
  Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollGlow(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                top: 02.h,
                left: 10,
                right:10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.05),
              ),
              child: child),
        ),
      ),
    );
  }
}
