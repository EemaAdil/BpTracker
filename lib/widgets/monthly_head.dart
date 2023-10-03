import 'package:flutter/material.dart';

import '../utils/export.dart';

/// Generate Dropdown items
List<String> getMonthListItems() {
  List<String> monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<String> items = monthNames.map((mo) {
    return "${mo.substring(0, 3)} ${DateTime.now().year}";
  }).toList();
  return items;
}

List<String> items = getMonthListItems();

class MonthlyHead extends StatelessWidget {
  MonthlyHead({
    Key? key,
    required this.selectedMonthIndex,
    required this.onChange,
  }) : super(key: key);
  int selectedMonthIndex;
  Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton(
            elevation: 1,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            underline: const SizedBox(),
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black.withOpacity(0.4),
            ),
            value: items[selectedMonthIndex],
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors().primaryColor,
            ),
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}
