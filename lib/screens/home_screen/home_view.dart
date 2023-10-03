import 'package:bptracker/core/base/export.dart';
import 'package:bptracker/utils/app_assets.dart';
import 'package:bptracker/utils/app_colors.dart';
import 'package:bptracker/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blood_pressure/blood_pressure_screen/blood_pressure_view.dart';
import '../blood_sugar/export.dart';
import '../bmi_screen/export.dart';
import 'home_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (_) {
        Get.put(HomeController());
      },
      builder: (_) {
        return Scaffold(
          //bottomNavigationBar: controller.bannerLoaded
              //? controller.admobAdsManager.getNativeAd()
             // : const SizedBox(),
          appBar: AppBar(
            title: Text('home'.tr),
           // isBack: false,
           // space: 4,
          ),
          body: ListView(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: getBloodSugar(context),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: getBMI(),
                    ),
                  ],
                ),
              ),
              getBloodPressure(context),
              controller.bannerLoaded
                  ? controller.admobAdsManager.getNativeAd()
                  : const SizedBox(),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget getBloodSugar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const BSDashboardView(),
          binding: Appbindings(),
          duration: const Duration(seconds: 1),
          transition: Transition.leftToRightWithFade,
        );
      },
      child: Container(
        height: 113,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets().icBloodSugar,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 10),
            Text(
              'blood Sugar'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: AppColors().black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBMI() {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const BMIView(),
          binding: Appbindings(),
          duration: const Duration(seconds: 1),
          transition: Transition.leftToRightWithFade,
        );
      },
      child: Container(
        height: 113,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets().icBmi,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 10),
            Text(
              "BMI",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: AppColors().black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBloodPressure(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const BloodPressureView(),
          binding: Appbindings(),
          duration: const Duration(seconds: 1),
          transition: Transition.leftToRightWithFade,
        );
      },
      child: Container(
        height: 113,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets().appLogo,
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 // AppLocalizations.of(context)!.bloodPressureTracker
                  'bloodPressureTracker'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: AppColors().black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(textAlign: TextAlign.center,

                  "Track your blood pressure",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 17,
                      color: AppColors().black2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
