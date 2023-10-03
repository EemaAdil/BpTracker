import 'dart:convert';

import 'package:bptracker/utils/admob_ads_manager.dart';
import 'package:bptracker/utils/app_colors.dart';
import 'package:bptracker/widgets/monthly_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/base/base_controller.dart';
import '../../../models/blood_sugar_record_model.dart';
import '../../../models/blood_sugar_stats.dart';

class BSDashboardController extends BaseController {
  bool? isBack = Get.arguments;
  late AdmobAdsManager admobAdsManager;

  //
  List<BloodSugarRecordModel?> latest = [];
  List<BloodSugarStats> sysDiaBarCharData = [];
  List allMonthsData = [];

  void _resetUIData() {
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
    for (var element in allMonthsData) {
      if (element.toString().contains("status")) {
        latest.add(
          BloodSugarRecordModel(
            date: element["date_time_str"] ?? "",
            dateTime: element["date_time"],
            status: element["status"],
            sugarType: element["sugarType"],
            sugarNumber: element["sugarNumber"],
            selectedSugarType: element["selectedSugarType"] ?? "Normal",
            selectedColor: element["selectedColor"] ?? AppColors.normal,
          ),
        );
      }
      update();
    }
    update();
  }

  Future<void> _getMonthList() async {
    debugPrint("Start calling _getMonthList.....");

    final prefs = await SharedPreferences.getInstance();
    String y = items[selectedMonthIndex].split(" ")[1];
    String mo = (selectedMonthIndex + 1).toString();
    debugPrint("Getting Data by this Date: $mo/$y...........");

    String prefKey = "Sugar_$y";

    String? yData = prefs.getString(prefKey);
    // print(yData);
    if (yData == null) {
      debugPrint("no record for this year($y)");
      return;
    }

    //String year=y.split("_")[1];

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

  /// Load This Month Data
  loadMonthCharData() async {
    var allMonthData = allMonthsData;
    if (allMonthData.isEmpty) {
      debugPrint("Empty.....");
      return;
    }

    for (var data in allMonthData) {
      update();
      debugPrint(data.toString());
      if (data.toString().contains("status")) {
        sysDiaBarCharData.add(
          BloodSugarStats(
            '${data["date_time"]["day"]}/${data["date_time"]["month"]}',
            data["sugarNumber"],
          ),
        );
      }
    }
    update();
  }

  int selectedMonthIndex = DateTime.now().month - 1;

  void refreshDataBySelectDate() async {
    _resetUIData();
    await _getMonthList();
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
}
