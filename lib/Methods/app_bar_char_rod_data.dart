import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';

BarChartRodData AppBarCharRodData(yVal, color) {
  return BarChartRodData(
    toY: yVal,
    width: 15,
    color: color,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(2),
      topRight: Radius.circular(2),
    ),
  );
}
