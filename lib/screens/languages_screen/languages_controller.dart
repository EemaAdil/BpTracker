import 'dart:ui';

import 'package:bptracker/utils/export.dart';
import 'package:bptracker/main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/base/base_controller.dart';
import '../../models/languages.dart';

class LanguageController extends BaseController {
  RxInt selectedLang = 0.obs;

  final List<Languages> languagesList = [
    Languages(
      countryFlag: AppAssets().flagEnglish,
      countryName: "English",
      countryCode: 'en',
    ),
    Languages(
      countryFlag: AppAssets().flagArabic,
      countryName: "Arabic",
      countryCode: 'ar',
    ),
    Languages(
      countryFlag: AppAssets().flagFrench,
      countryName: "French",
      countryCode: 'fa',
    ),
    Languages(
      countryFlag: AppAssets().flagHindi,
      countryName: "Hindi",
      countryCode: 'hi',
    ),
  ];

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

  setLanguages(int index, BuildContext context) {
    selectedLang.value = index;
    if(index == 0)
      {
        Get.updateLocale(Locale('en','US'));
      }
    if(index == 1)
      {
        Get.updateLocale(Locale('ar','SA'));
      }
    update();
  }

  @override
  void dispose() {
    admobAdsManager.disposeBannerAd();
    super.dispose();
  }
}
