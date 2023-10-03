import 'package:bptracker/core/base/export.dart';
import 'package:bptracker/core/base/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../models/pressure_record_model.dart';
import '../../../utils/export.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_title.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/max_label.dart';
import '../../../widgets/min_label.dart';
import '../../../widgets/monthly_head.dart';
import '../../../widgets/sys_dia_bar_char.dart';
import '../../../widgets/sys_dia_record.dart';
import '../pressure_record_screen/pressure_record.dart';
import 'blood_pressure_controller.dart';

class BloodPressureView extends GetView<BloodPressureController> {
  const BloodPressureView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodPressureController>(
      initState: (_) {
        Get.put(BloodPressureController());
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors().white,
          appBar: AppBar(
            title: Text('bloodPressureTracker'.tr),
           // "Blood Pressure Tracker",
          //  isBack: false,
          //  space: 4,
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
                () => const PressureRecord(),
                binding: Appbindings(),
              )!.then((value) {
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
            child: Obx(
              () => ListView(
                children: [
                  const SizedBox(height: 20),
                  getTitle(),
                  const SizedBox(height: 20),
                  if (controller.selectedLabel.value == "Max") getMaxLabel(),
                  if (controller.selectedLabel.value == "Min") getMinLabel(),
                  const SizedBox(height: 20),
                  getGraph(),
                  const SizedBox(height: 20),
                  getAllDataList(),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.selectLabel("Max");
          },
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: controller.selectedLabel.value == "Max"
                      ? AppColors().primaryColor
                      : AppColors().white,
                ),
              ),
            ),
            child: Center(
              child: AppTitle(
                txt: "Max",
                fontSize: 16,
                color: controller.selectedLabel.value == "Max"
                    ? AppColors().primaryColor
                    : AppColors().black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
    GestureDetector(
    onTap: () {
    controller.selectLabel("Average");
    },
    child:Container(
          width: 60,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
          ),
          child: Center(
            child: AppTitle(
              txt: "Average",
              fontSize: 16,
              color: Colors.black.withOpacity(.6),
            ),
          ),
        ),
    ),

        const SizedBox(width: 15),
        GestureDetector(
          onTap: () {
            controller.selectLabel("Min");
          },
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: controller.selectedLabel.value == "Min"
                      ? AppColors().primaryColor
                      : AppColors().white,
                ),
              ),
            ),
            child: Center(
              child: AppTitle(
                txt: "Min",
                fontSize: 16,
                color: controller.selectedLabel.value == "Min"
                    ? AppColors().primaryColor
                    : AppColors().black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: AppColors().white,
              ),
            ),
          ),
          child: Center(
            child: AppTitle(
              txt: "Latest",
              fontSize: 16,
              color: Colors.black.withOpacity(.6),
            ),
          ),
        ),
      ],
    );
  }

  getMaxLabel() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: MaxLabel(
            title: "Systolic",
            subtitle: "mmHg",
            color: AppColors().primary,
            stats: {
              "min": controller.stats["sys"]["min"],
              "max": controller.stats["sys"]["max"]
            },
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: MaxLabel(
            title: "Diastolic",
            subtitle: "mmHg",
            color: AppColors().accentColor,
            stats: {
              "min": controller.stats["dia"]["min"],
              "max": controller.stats["dia"]["max"]
            },
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: MaxLabel(
            title: "Pulse",
            subtitle: "BMP",
            color: AppColors().primary,
            stats: {
              "min": controller.stats["pulse"]["min"],
              "max": controller.stats["pulse"]["max"]
            },
          ),
        ),
      ],
    );
  }

  getMinLabel() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: MinLabel(
            title: "Systolic",
            subtitle: "mmHg",
            color: AppColors().primary,
            stats: {
              "min": controller.stats["sys"]["min"],
              "max": controller.stats["sys"]["max"]
            },
          ),
        ),
        const SizedBox(height: 17),
        Expanded(
          flex: 1,
          child: MinLabel(
            title: "Diastolic",
            subtitle: "mmHg",
            color: AppColors().accentColor,
            stats: {
              "min": controller.stats["dia"]["min"],
              "max": controller.stats["dia"]["max"]
            },
          ),
        ),
        const SizedBox(height: 17),
        Expanded(
          flex: 1,
          child: MinLabel(
            title: "Pulse",
            subtitle: "BMP",
            color: AppColors().primary,
            stats: {
              "min": controller.stats["pulse"]["min"],
              "max": controller.stats["pulse"]["max"]
            },
          ),
        ),
      ],
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
          SysDiaBarChar(data: controller.sysDiaBarCharData),
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
                    'systolic'.tr,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: AppColors().accentColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'diastolic'.tr,
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

  getAllDataList(){
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
              child: record !=null? SysDiaRecord(
                pressureRecord: record,
                onAfterDelete: (bool? isDeleted,
                    PressureRecordModel record) {
                  if (isDeleted != null && isDeleted) {
                    controller
                        .refreshDataBySelectDate();
                  }
                },
              ):Container(),
            )).toList()
          ],
        ),
      ],
    );
  }
}
