import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'export.dart';

class AppUtils {

  getDate(date){
    return DateFormat('yyyy-MM-dd').format(date).toString();
  }

  void statusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors().white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void screenRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void toast(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
    ));
  }

  showMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors().primaryColor.withOpacity(0.2),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

}
