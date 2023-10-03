import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_controller.dart';
import '../../../models/blood_sugar_info.dart';
import '../../../utils/export.dart';

class NewSugarRecordController extends BaseController {
  List<BloodSugarInfo> mgDlList = [];
  List<BloodSugarInfo> mmOlList = [];
  List<String> statusList = [];
  RxInt selectedStatus = 0.obs;
  RxString statusValue = "Default".obs;
  RxString sugarType = "mg/dL".obs;
  RxInt sugarNumber = 50.obs;
  RxString selectedSugarType = "Normal".obs;
  Color selectedColor = AppColors.normal;



  DateTime date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  TimeOfDay time = TimeOfDay(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );

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
    String dateTimeStr = "${date.day}/${date.month}/${date.year} - ${time.hour}:${time.minute}";
    String y = "Sugar_${date.year}";
    String mo = date.month.toString();
    debugPrint("Save to: $mo/$y");
    Map dayContext = {
      "status": statusValue.value,
      "sugarType": sugarType.value,
      "sugarNumber": sugarNumber.value,
      "selectedSugarType": selectedSugarType.value,
      "selectedColor": selectedColor.toString(),
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
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black.withOpacity(.7),
        content: const Text('Added Successfully'),
      ),
    );

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
    getMGdlList();
    getMMolList();
    getStatusList();
  }

  getMGdlList() {
    mgDlList.add(BloodSugarInfo(
      color: AppColors.elevated,
      title: "Low",
      value: "< 72",
    ));
    mgDlList.add(BloodSugarInfo(
      color: AppColors.normal,
      title: "Normal",
      value: "72 ~ 98",
    ));
    mgDlList.add(BloodSugarInfo(
      color: AppColors.hts1,
      title: "Pre-Diabetes",
      value: "99 ~ 125",
    ));
    mgDlList.add(BloodSugarInfo(
      color: AppColors.hts2,
      title: "Diabetes",
      value: ">=126",
    ));
  }

  getMMolList() {
    mmOlList.add(BloodSugarInfo(
      color: AppColors.elevated,
      title: "Low",
      value: "< 4.0",
    ));
    mmOlList.add(BloodSugarInfo(
      color: AppColors.normal,
      title: "Normal",
      value: "4.0 ~ 5.4",
    ));
    mmOlList.add(BloodSugarInfo(
      color: AppColors.hts1,
      title: "Pre-Diabetes",
      value: "5.5 ~ 6.9",
    ));
    mmOlList.add(BloodSugarInfo(
      color: AppColors.hts2,
      title: "Diabetes",
      value: ">=7.0",
    ));
  }

  getStatusList() {
    statusList.add("Default");
    statusList.add("During Fasting");
    statusList.add("Before Eating");
    statusList.add("After Eating(1h)");
    statusList.add("After Eating(2h)");
    statusList.add("Before Bedtime");
    statusList.add("Before Workout");
    statusList.add("After Workout");
  }

  void setStatus(int index) {
    selectedStatus.value = index;
    update();
  }

  void setStatusValue(String s) {
    statusValue.value=s;
    update();
  }

  void setSugarType(String s) {
    sugarType.value=s;
    update();
  }

  void setSugarNumber(int s) {
    sugarNumber.value=s;
    update();
  }

  setSelectedSugarType(String value){
    selectedSugarType.value=value;
    update();
  }

  setSelectedColor(Color color){
    selectedColor=color;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    admobAdsManager.disposeBannerAd();
  }


}
