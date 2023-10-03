import 'dart:ui';

class BloodSugarRecordModel {
  String date;
  Map dateTime;
  // String title;
  String status;
  String sugarType;
  int sugarNumber;
  String selectedSugarType;
  String selectedColor;

  BloodSugarRecordModel({
    required this.date,
    required this.dateTime,
    required this.status,
    required this.sugarType,
    required this.sugarNumber,
    required this.selectedSugarType,
    required this.selectedColor,
  });

}
