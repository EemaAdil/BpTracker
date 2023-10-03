import 'package:bptracker/utils/app_colors.dart';
import 'package:bptracker/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppButton extends StatelessWidget {
  AppButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.bg,
    this.height,
    this.color = Colors.white,
  }) : super(key: key);

  String label;
  Function() onTap;
  Color? bg;
  double? height;
  Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height??30,
        decoration: BoxDecoration(
          color: bg ??  AppColors().primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: AppTitle(
          txt: label,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: color,
        )),
      ),
    );
  }
}
