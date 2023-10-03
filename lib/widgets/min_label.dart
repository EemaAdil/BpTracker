import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MinLabel extends StatelessWidget {
  MinLabel({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.stats,
    this.color = Colors.orange,
  }) : super(key: key);

  String title;
  String subtitle;
  Map<String, int> stats;
  Color color;

  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(left: 5, right: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: AppColors().labelColors,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 05),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black.withOpacity(.5),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 60,
            child: Center(
              child: Text(
                stats["min"].toString(),
                style: TextStyle(
                  fontSize: 38,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
