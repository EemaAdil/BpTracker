import 'dart:convert';

import 'package:bptracker/Methods/get_sys_dia_status.dart';
import 'package:bptracker/models/blood_pressure_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_controller.dart';
import '../../../models/bp_status.dart';
import '../../../utils/export.dart';

class PressureRecordController extends BaseController {
  String prefKey="BloodPressureRecord";
  List<BloodPressureInfo> list = [];

  int sysVal = 70;
  int diaVal = 40;
  int pulseVal = 20;
  DateTime date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  TimeOfDay time = TimeOfDay(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );
  final TextEditingController noteController = TextEditingController();

  BPStatus crrbpStatus = getSysDiaStatus(70, 40);

  void updatePulseVal() {
    // return;
    int df = sysVal - diaVal;
    if (df > 20) {
      pulseVal = df;
    }
  }

  ///
  void observeCrrStatus() {
    crrbpStatus = getSysDiaStatus(sysVal, diaVal);
    update();
  }

  ///
  void onDateChanged(newDate) {
    date = newDate;
    update();
  }

  ///
  void onTimeChanged(newDate) {
    time = newDate;
    update();
  }

  ///
  void savePressureRecord() async {
    String dateTimeStr =
        "${date.day}/${date.month}/${date.year} - ${time.hour}:${time.minute}}";
    String y = date.year.toString();
    String mo = date.month.toString();
    debugPrint("Save to: $mo/$y");
    Map dayContext = {
      "sys": sysVal,
      "dia": diaVal,
      "pulse": pulseVal,
      "note": noteController.text,
      "date_time_str": dateTimeStr,
      "date_time": {
        "year": date.year,
        "month": date.month,
        "day": date.day,
        "hour": time.hour,
        "min": time.minute,
      }
    };

    /// Store in Local Storage
    final prefs = await SharedPreferences.getInstance();

    String? yData = prefs.getString(y);
    if (yData != null) {
      Map yDataDecoded = json.decode(yData);
      Map? mData = yDataDecoded[mo];
      if (mData == null) {
        yDataDecoded[mo] = {dateTimeStr: dayContext};
      } else {
        mData[dateTimeStr] = dayContext;
        yDataDecoded[mo] = mData;
      }

      String newEncodedContext = json.encode(yDataDecoded);
      // print(newEncodedContext);
      prefs.setString(y, newEncodedContext);
    } else {
      Map context = {
        mo: {dateTimeStr: dayContext}
      };
      String encodedContext = json.encode(context);
      prefs.setString(y, encodedContext);
    }
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: Colors.black.withOpacity(.7),
      content: const Text('Added Successfully'),
    ));

    // Get.offAllNamed("/");
    Get.back(result: true);
  }

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
    //
    list.add(BloodPressureInfo(
      color: AppColors.normal,
      title: "Normal Blood Pressure",
      startValue: "< 120",
      centerValue: "and",
      endValue: "<80",
    ));
    list.add(BloodPressureInfo(
      color: AppColors.elevated,
      title: "Elivated Blood Pressure",
      startValue: "120-129",
      centerValue: "and",
      endValue: "<80",
    ));
    list.add(BloodPressureInfo(
      color: AppColors.hts1,
      title: "High Blood Pressure Stage-I",
      startValue: "< 130+",
      centerValue: "or",
      endValue: "<80",
    ));
    list.add(BloodPressureInfo(
      color: AppColors.hts2,
      title: "High Blood Pressure Stage-II",
      startValue: "< 140+",
      centerValue: "or",
      endValue: "<90 +",
    ));
    list.add(BloodPressureInfo(
      color: AppColors().primary,
      title: "Dangerously High Blood Pressure",
      startValue: "< 180+",
      centerValue: "And/Or",
      endValue: "<120+",
    ));
  }

  @override
  void dispose() {
    super.dispose();
    admobAdsManager.disposeBannerAd();
  }
}
