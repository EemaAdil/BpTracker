import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/base/base_controller.dart';
import '../../utils/ads_manager.dart';
import '../blood_pressure/blood_pressure_screen/blood_pressure_view.dart';
import '../home_screen/home_view.dart';
import '../posts_screen/posts_view.dart';
import '../settings_screen/settings_view.dart';

class BottomNavController extends BaseController {
  RxInt currentIndex = 0.obs;

  final List<Widget> bottomNavigationPages = [
    const HomeView(),
    const BloodPressureView(),
    const PostsView(),
    const SettingsView(),
  ];

  @override
  void onInit() {
    super.onInit();
    AdsManager.initUnityAds();
  }

  onTabTapped(int index) {
    currentIndex.value = index;
  }
}
