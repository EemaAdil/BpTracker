import 'package:bptracker/core/base/export.dart';
import 'package:bptracker/utils/app_assets.dart';
import 'package:bptracker/utils/app_colors.dart';
import 'package:bptracker/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/custom_app_bar.dart';
import '../languages_screen/languages_view.dart';
import 'settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      initState: (_) {
        Get.put(SettingsController());
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors().white,
          bottomNavigationBar: controller.bannerLoaded
              ? controller.admobAdsManager.getBannerAd()
              : const SizedBox(),
          appBar: CustomAppBar(
            title: "Settings",
            isBack: false,
            space: 4,
          ),
          body: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors().black2.withOpacity(0.05),
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsCard(
                  label: "Language",
                  icon: AppAssets().icLanguage,
                  onTap: () {
                    Get.to(
                      () => const LanguageView(),
                      binding: Appbindings(),
                      duration: const Duration(seconds: 1),
                      transition: Transition.upToDown,
                    );
                  },
                ),
                SettingsCard(
                  label: "Export as File",
                  icon: AppAssets().icExport,
                  onTap: controller.exportAsFile,
                ),
                const SizedBox(height: 10),
                AppTitle(
                  txt: "General",
                  fontSize: 20,
                ),
                const SizedBox(height: 10),
                SettingsCard(
                  label: "Rate Us",
                  icon: AppAssets().icRate,
                  onTap: () {
                    LaunchReview.launch(androidAppId: controller.bundleId);
                  },
                ),
                const SizedBox(height: 10),
                SettingsCard(
                  label: "Share App",
                  icon: AppAssets().icShare,
                  onTap: () {
                    Share.share(
                      'Check Out This Blood Pressure Tracker: https://play.google.com/store/apps/details?id=${controller.bundleId}',
                    );
                  },
                ),
                const SizedBox(height: 10),
                SettingsCard(
                  label: "Feedback",
                  icon: AppAssets().icFeedback,
                  onTap: () {
                    debugPrint("jo");
                    controller.launchEmail();
                  },
                ),
                const SizedBox(height: 10),
                SettingsCard(
                  label: "Privacy Policy",
                  icon: AppAssets().icPrivacyPolicy,
                  onTap: () {
                    debugPrint("jo");
                   controller.launchPrivacyPolicyURL();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingsCard extends StatelessWidget {
  SettingsCard({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  String label;
  String icon;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 10),
              AppTitle(
                txt: label,
                fontSize: 16,
                color: Colors.black.withOpacity(.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
