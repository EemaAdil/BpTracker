import 'package:bptracker/Methods/app_bar_char_rod_data.dart';
import 'package:bptracker/models/sys_dia_stats.dart';
import 'package:bptracker/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/blood_sugar_stats.dart';

class BloodSugarBarChar extends StatelessWidget {
  // List<charts.Series> seriesList;

  BloodSugarBarChar({Key? key, required this.data}) : super(key: key);

  List<BloodSugarStats> data;

  int xIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 330),
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 0.70 * data.length,
            height: 200,
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    fitInsideHorizontally: true,
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 1.h,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.toY.round().toString(),
                        TextStyle(
                          color: rod.color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                alignment: BarChartAlignment.spaceBetween,
                borderData: FlBorderData(
                  show: true,
                  border: const Border.symmetric(
                    horizontal: BorderSide(
                      color: Color(0xFFececec),
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    drawBehindEverything: true,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 34,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Color(0xFF606060),
                          ),
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Container(
                            child: Text(
                              data[value.toInt()].date,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(.7),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: const Color(0xFFececec),
                    strokeWidth: 1,
                  ),
                ),
                barGroups: [
                  ...data.map((BloodSugarStats data) {
                    //debugPrint(data.toString());
                    return BarChartGroupData(
                      showingTooltipIndicators: [0, 1],
                      x: xIndex++,
                      barRods: [
                        AppBarCharRodData(
                          data.sugarNumber.toDouble(),
                          AppColors().primary,
                        ),
                      ],
                    );
                  })
                ],
                maxY: 200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
