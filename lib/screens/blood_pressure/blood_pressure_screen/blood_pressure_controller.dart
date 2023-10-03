import 'dart:convert';

import 'package:bptracker/models/pressure_record_model.dart';
import 'package:bptracker/models/sys_dia_stats.dart';
import 'package:bptracker/utils/admob_ads_manager.dart';
import 'package:bptracker/widgets/monthly_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_controller.dart';

class BloodPressureController extends BaseController {
  bool? isBack = Get.arguments;
  late AdmobAdsManager admobAdsManager;

  //
  RxString selectedLabel = "Max".obs;

  //
  int maxLatest = 5;
  List<PressureRecordModel?> latest = [];
  List<SysDiaStats> sysDiaBarCharData = [];
  List allMonthsData = [];

  Map<String, dynamic> stats = {
    "sys": {"max": 0, "min": 0},
    "dia": {"max": 0, "min": 0},
    "pulse": {"max": 0, "min": 0}
  };

  void _resetUIData() {
    stats = {
      "sys": {"max": 0, "min": 0},
      "dia": {"max": 0, "min": 0},
      "pulse": {"max": 0, "min": 0}
    };
    latest = [];
    sysDiaBarCharData = [];
    allMonthsData = [];
    update();
  }

  ///
  void loadLatestData() async {
    if (allMonthsData.isEmpty) {
      debugPrint("Empty.....");
      return;
    }
    int lenLatest = allMonthsData.length;
    List<PressureRecordModel?> latestData = allMonthsData
        .sublist(0, lenLatest > maxLatest ? maxLatest : lenLatest)
        .map((decodedContext) {

          if(decodedContext["sys"]==null){
            return null;
          }

      return  PressureRecordModel(
        date: decodedContext["date_time_str"] ?? "",
        dateTime: decodedContext["date_time"],
        note: decodedContext["note"],
        sys: decodedContext["sys"],
        dia: decodedContext["dia"],
        pulse: decodedContext["pulse"],
      );
    }).toList();
    latest = latestData;
    update();
  }

  Future<void> _getMonthList() async {
    debugPrint("Start calling _getMonthList.....");

    final prefs = await SharedPreferences.getInstance();
    String y = items[selectedMonthIndex].split(" ")[1];
    String mo = (selectedMonthIndex + 1).toString();
    debugPrint("Getting Data by this Date: $mo/$y...........");
    String? yData = prefs.getString(y);
    // print(yData);
    if (yData == null) {
      debugPrint("no record for this year($y)");

      return;
    }

    Map yDataDecoded = json.decode(yData);
    Map? mData = yDataDecoded[mo];
    if (mData == null) {
      debugPrint("no record for this month($mo)");
      // _resetUIData();
      return;
    }

    Map mDataSorted = Map.fromEntries(
        mData.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));
    List dd = mDataSorted.values.toList();
    allMonthsData = dd;
    update();
    // return dd;
  }

  ///
  void loadMonthStats() async {
    if (allMonthsData.isEmpty) {
      debugPrint("Empty.....");
      return;
    }

    debugPrint(allMonthsData.toString());

    try{
      int sMax = allMonthsData[0]["sys"];
      int sMin = allMonthsData[0]["sys"];
      int dMax = allMonthsData[0]["dia"];
      int dMin = allMonthsData[0]["dia"];
      int pMax = allMonthsData[0]["pulse"];
      int pMin = allMonthsData[0]["pulse"];

      /// then loop through the rest and compare crr and previous
      for (var decodedContext in allMonthsData) {
        int sVal = decodedContext["sys"];
        int dVal = decodedContext["dia"];
        int pVal = decodedContext["pulse"];

        debugPrint("For Loop");

        if (sVal > sMax) {
          sMax = sVal;
        } else if (sVal < sMin) {
          sMin = sVal;
        }
        if (dVal > dMax) {
          dMax = dVal;
        } else if (dVal < dMin) {
          dMin = dVal;
        }
        if (pVal > pMax) {
          pMax = pVal;
        } else if (pVal < pMin) {
          pMin = pVal;
        }
        update();
      }

      stats["sys"]["max"] = sMax;
      stats["sys"]["min"] = sMin;
      stats["dia"]["max"] = dMax;
      stats["dia"]["min"] = dMin;
      stats["pulse"]["max"] = pMax;
      stats["pulse"]["min"] = pMin;
      update();
    }catch(e){
      debugPrint(e.toString());
    }

  }

  /// Load This Month Data
  loadMonthCharData() async {
    var allMonthData = allMonthsData;
    if (allMonthData.isEmpty) {
      debugPrint("Empty.....");
      return;
    }

    for (var data in allMonthData) {
      if(data["sys"]!=null){
        sysDiaBarCharData.add(
          SysDiaStats(
            '${data["date_time"]["day"]}/${data["date_time"]["month"]}',
            data["sys"],
            data["dia"],
          ),
        );
        update();
      }
    }
    update();
  }

  int selectedMonthIndex = DateTime.now().month - 1;

  void refreshDataBySelectDate() async {
    _resetUIData();
    await _getMonthList();
    loadMonthStats();
    loadMonthCharData();
    loadLatestData();
  }

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
    refreshDataBySelectDate();
  }

  @override
  void dispose() {
    admobAdsManager.disposeBannerAd();
    super.dispose();
  }

  void selectLabel(String s) {
    selectedLabel.value = s;
    update();
  }
}
