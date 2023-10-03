import 'package:bptracker/utils/export.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  AppCard({
    Key? key,
    required this.child,
    this.padding = 16,
  }) : super(key: key);
  double padding;

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: AppColors().labelColors,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: child);
  }
}
