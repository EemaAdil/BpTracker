import 'package:bptracker/core/base/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../models/blood_sugar_record_model.dart';
import '../../../models/pressure_record_model.dart';
import '../../../utils/export.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_title.dart';
import '../../../widgets/blood_sugar_bar_char.dart';
import '../../../widgets/blood_sugar_record.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/max_label.dart';
import '../../../widgets/min_label.dart';
import '../../../widgets/monthly_head.dart';
import '../../../widgets/sys_dia_bar_char.dart';
import '../../../widgets/sys_dia_record.dart';
import '../export.dart';
import 'bs_dashboard_controller.dart';

class BSDashboardView extends GetView<BSDashboardController> {
  const BSDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BSDashboardController>(
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors().white,
          appBar: CustomAppBar(
            title: "Blood Sugar",
            isBack: true,
            space: 4,
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 3,
            backgroundColor: AppColors().primaryColor,
            child: const Icon(
              Icons.add,
              size: 50,
            ),
            onPressed: () async {
              Get.to(
                () => const NewSugarRecordView(),
                binding: Appbindings(),
              )!
                  .then((value) {
                AdsManager.showInterAd();
                controller.refreshDataBySelectDate();

                /// Admob Ad
                controller.admobAdsManager.showAdmobInterAd();
              });
            },
          ),
          bottomNavigationBar: SizedBox(
            height: 55,
            child: Column(
              children: [
                //Unity ads
                AdsManager.bannerAd(),
                // Admob ad banner
                controller.bannerLoaded
                    ? controller.admobAdsManager.getBannerAd()
                    : const SizedBox()
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                getGraph(),
                const SizedBox(height: 20),
                getAllDataList(),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      },
    );
  }

  getGraph() {
    return AppCard(
      child: Column(
        children: [
          MonthlyHead(
            selectedMonthIndex: controller.selectedMonthIndex,
            onChange: (val) {
              controller.selectedMonthIndex = items.indexOf(val!);
              controller.refreshDataBySelectDate();
            },
          ),
          const SizedBox(height: 20),
          BloodSugarBarChar(data: controller.sysDiaBarCharData),
          // SysDiaBarChar(),
          const SizedBox(height: 10),
          Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: AppColors().primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Blood Sugar",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  getAllDataList() {
    return Column(
      children: [
        controller.latest.isEmpty
            ? Container(
                decoration: BoxDecoration(
                  color: AppColors().onBoarding.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 100,
                child: Center(
                  child: AppTitle(
                    txt: "No Records",
                    color: Colors.grey,
                  ),
                ),
              )
            : Column(
                children: [
                  ...controller.latest
                      .map((record) => Container(
                            margin: EdgeInsets.only(bottom: 06.h),
                            child: BloodSugarRecord(
                              pressureRecord: record!,
                              onAfterDelete: (bool? isDeleted,
                                  BloodSugarRecordModel record) {
                                if (isDeleted != null && isDeleted) {
                                  controller.refreshDataBySelectDate();
                                }
                              },
                            ),
                          ))
                      .toList()
                ],
              ),
      ],
    );
  }
}
