import 'package:bptracker/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_nav_controller.dart';

class BottomNav extends GetView<BottomNavController> {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      builder: (_) {
        return Obx(
          () => Scaffold(
            body:
                controller.bottomNavigationPages[controller.currentIndex.value],
            bottomNavigationBar: Container(
              height: 70,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(.1),
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      AppAssets().icHome,
                      height: 24,
                      width: 24,
                      color: AppColors().onBoarding,
                    ),
                    activeIcon: Image.asset(
                      AppAssets().icHome,
                      height: 24,
                      width: 24,
                      color: AppColors().primaryColor,
                    ),
                    label: 'home'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      AppAssets().icBloodPressure,
                      height: 24,
                      width: 24,
                      color: AppColors().onBoarding,
                    ),
                    activeIcon: Image.asset(
                      AppAssets().icBloodPressure,
                      height: 24,
                      width: 24,
                      color: AppColors().primaryColor,
                    ),
                    label: 'b-pressure'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      AppAssets().icGuide,
                      height: 24,
                      width: 24,
                      color: AppColors().onBoarding,
                    ),
                    activeIcon: Image.asset(
                      AppAssets().icGuide,
                      height: 24,
                      width: 24,
                      color: AppColors().primaryColor,
                    ),
                    label: 'guide'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      AppAssets().icSetting,
                      height: 24,
                      width: 24,
                      color: AppColors().onBoarding,
                    ),
                    activeIcon: Image.asset(
                      AppAssets().icSetting,
                      height: 24,
                      width: 24,
                      color: AppColors().primaryColor,
                    ),
                    label: 'settings'.tr,
                  ),
                ],
                selectedItemColor: AppColors().primaryColor,
                unselectedItemColor: Colors.grey.withOpacity(.5),
                unselectedIconTheme: IconThemeData(
                  color: Colors.grey.withOpacity(.5),
                ),
                onTap: (val) {
                  controller.currentIndex.value = val;
                },
                elevation: 1,
                iconSize: 24,
                selectedFontSize: 14,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                unselectedFontSize: 12,
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        );
      },
    );
  }
}
