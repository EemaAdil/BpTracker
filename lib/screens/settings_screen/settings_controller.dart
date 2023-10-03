import 'dart:convert';
import 'dart:io';

import 'package:bptracker/Methods/get_sys_dia_status.dart';
import 'package:bptracker/utils/dialogs.dart';
import 'package:bptracker/utils/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_excel/excel.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:mailto/mailto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/base/base_controller.dart';
import '../../utils/admob_ads_manager.dart';

class SettingsController extends BaseController {


  void exportAsFile() async {
    /* Your blah blah code here */

    ByteData data = await rootBundle.load("assets/blood_pressure_file.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    debugPrint(excel.tables.keys.toString());

    String sheet1Name = excel.tables.keys.toList()[0];
    Sheet? sheet1 = excel.tables[sheet1Name];
    if (sheet1 == null) {
      debugPrint("No Sheet...");
      return;
    }
    int rowIndex = 1;
    final prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    for (String year in prefs.getKeys()) {
      Map months = json.decode(prefs.getString(year) ?? "");
      for (Map month in months.values) {
        for (Map day in month.values) {
          ///
          Data cell = sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex));
          cell.value = day["date_time_str"];
          ///
          Data cell2 = sheet1.cell(
              CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex));
          cell2.value = day["sys"];

          ///
          Data cell3 = sheet1.cell(
              CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex));
          cell3.value = day["dia"];

          ///
          Data cell4 = sheet1.cell(
              CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex));
          cell4.value = day["pulse"];

          ///
          Data cell5 = sheet1.cell(
              CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex));
          //cell5.value = getSysDiaStatus(day["sys"], day["dia"]).label;
        }
        rowIndex++;
      }
    }

    bool isYes = await Permissions.requestStorage();
    if (!isYes) {
      Dialogs.showOkAlertDialog(
          "Warning", "Please Allow Storage To Save This File");
      return;
    }
    var fileBytes = excel.save();
    var directory = await getApplicationDocumentsDirectory();
    DateTime today = DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    File("/storage/emulated/0/Download/Pressure_Blood_Tracker-$dateSlug.xlsx")
        .writeAsBytesSync(fileBytes!);
    debugPrint("Exported in /Download .....");
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.black.withOpacity(.7),
      content: const Text('Exported Successfully at /Download'),
    ));
  }

  // TODO: Change This To Your Package name
  String bundleId = "com.bmicalculator.bpmonitor";

  ///
  late AdmobAdsManager admobAdsManager;
  bool bannerLoaded = false;

  @override
  void onInit() {
    super.onInit();
    admobAdsManager = AdmobAdsManager();
    admobAdsManager.loadBannerAd((val) {
      bannerLoaded = val;
      update();
    });
    admobAdsManager.loadIntertitialAd();
  }

  @override
  void dispose() {
    admobAdsManager.disposeBannerAd();
    super.dispose();
  }

  launchPrivacyPolicyURL() async {
    const url = 'https://bloodpressuretrackerwithsuger.blogspot.com/2023/01/privacy-policy-body-font-family.html?m=1';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }


  // void launchEmail() async {
  //   final Uri params = Uri(
  //     scheme: 'mailto',
  //     path: 'mehndi2021design@gmail.com',
  //   );
  //   String  url = params.toString();
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     print( 'Could not launch $url');
  //   }
  // }


  launchEmail() async {
    final mailtoLink = Mailto(
      to: ['mehndi2021design@gmail.com'],
      subject: 'Feedback',
      body: 'typing here...',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

}
