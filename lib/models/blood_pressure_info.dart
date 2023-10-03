import 'package:flutter/material.dart';

class BloodPressureInfo {
  Color color;
  String title;
  String startValue;
  String centerValue;
  String endValue;

  BloodPressureInfo({
    required this.color,
    required this.title,
    required this.startValue,
    required this.centerValue,
    required this.endValue,
  });
}
