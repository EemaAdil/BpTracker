import 'dart:ui';

import 'package:bptracker/utils/ads_manager.dart';
import 'package:bptracker/utils/app_colors.dart';
import 'package:bptracker/widgets/app_button.dart';
import 'package:bptracker/widgets/app_card.dart';
import 'package:bptracker/widgets/app_title.dart';
import 'package:bptracker/widgets/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';

import '../../../models/blood_sugar_info.dart';
import '../export.dart';

class NewSugarRecordView extends GetView<NewSugarRecordController> {
  const NewSugarRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewSugarRecordController>(
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors().white,
          bottomNavigationBar: SizedBox(
            height: 55,
            child: Column(
              children: [
                AdsManager.bannerAd(),
                controller.bannerLoaded
                    ? controller.admobAdsManager.getBannerAd()
                    : const SizedBox()
              ],
            ),
          ),
          appBar: getAppBar(),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 22,
                  ),
                  decoration: BoxDecoration(
                    color: controller.selectedColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors().white,
                      ),
                      const SizedBox(width: 90),
                      AppTitle(
                        txt: controller.selectedSugarType.value,
                        maxLine: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                getState(context),
                const SizedBox(height: 20),
                getMgAndMm(context),
                const SizedBox(height: 20),
                DateTimePicker(
                  date: controller.date,
                  onDateChanged: controller.onDateChanged,
                  time: controller.time,
                  onTimeChanged: controller.onTimeChanged,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80.w,
                      height: 40,
                      child: AppButton(
                        label: "Save",
                        onTap: controller.savePressureRecord,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  getAppBar() {
    return AppBar(
      leading: Container(
        height: 60,
        padding: const EdgeInsets.all(6),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.grey.withOpacity(.2),
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            Get.back();
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: AppColors().onBoarding,
            ),
          ),
        ),
      ),
      elevation: 1,
      backgroundColor: Colors.white,
      title: Text(
        "Blood Sugar Record",
        style: TextStyle(
          fontSize: 16,
          color: AppColors().onBoarding,
        ),
      ),
    );
  }

  getState(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitle(
          txt: "State",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(.7),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            statusInfoDialog(context);
          },
          child: AppCard(
            padding: 10,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors().primary,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTitle(
                      txt: controller.statusValue.value,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(.7),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  getMgAndMm(context) {
    return AppCard(
      padding: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.setSugarType("mg/dL");
                    typesMgDlInfoDialog(context);
                  },
                  child: AppTitle(
                    txt: "mg/dL",
                    fontSize: 16,
                    fontWeight: controller.sugarType.value == "mg/dL"
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: controller.sugarType.value == "mg/dL"
                        ? Colors.black.withOpacity(.7)
                        : Colors.black.withOpacity(.3),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    controller.setSugarType("mmol/l");
                  },
                  child: AppTitle(
                    txt: "mmol/l",
                    fontSize: 16,
                    fontWeight: controller.sugarType.value == "mmol/l"
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: controller.sugarType.value == "mmol/l"
                        ? Colors.black.withOpacity(.7)
                        : Colors.black.withOpacity(.3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Container(
              width: 150,
              height: 130,
              alignment: Alignment.center,
              child: getNumber(),
            ),
          )
        ],
      ),
    );
  }

  getNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          child: Obx(
            () => NumberPicker(
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(.3),
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(.3),
                    width: 1,
                  ),
                )),
                value: controller.sugarNumber.value,
                minValue: 1,
                maxValue: 1000,
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors().black,
                ),
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(.2),
                ),
                onChanged: (value) {
                  controller.setSugarNumber(value);
                }),
          ),
        ),
      ],
    );
  }

  getDialogAppBar(String s, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: AppColors().onBoarding,
            ),
          ),
          SizedBox(width: width),
          Text(
            s,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors().black,
            ),
          )
        ],
      ),
    );
  }

  typesMgDlInfoDialog(context) {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 80.h,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    controller.sugarType.value == "mg/dl"
                        ? getDialogAppBar("Blood Sugar Types (mg/dl)", 10)
                        : getDialogAppBar("Blood Sugar Types (mmol/l))",10),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.sugarType.value == "mg/dl"
                              ? controller.mgDlList.length
                              : controller.mmOlList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return controller.sugarType.value == "mg/dl"
                                ? infoCards(context, controller.mgDlList[index])
                                : infoCards(
                                    context, controller.mmOlList[index]);
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 4), end: const Offset(0, 0))
              .animate(anim),
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 05 * anim.value,
                sigmaY: 05 * anim.value,
              ),
              child: child),
        );
      },
    );
  }

  infoCards(context, BloodSugarInfo list) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            controller.setSelectedSugarType(list.title);
            controller.setSelectedColor(list.color);
            Navigator.of(context).pop();
          },
          child: Container(
            height: 80,
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: AppColors().labelColors,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 15,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: list.color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        list.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: AppColors().black,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 1,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors().onBoarding,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppTitle(
                      txt: list.value,
                      fontSize: 14,
                      color: AppColors().black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  statusInfoDialog(context) {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 80.h,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    getDialogAppBar("State", 90),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.statusList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return statusInfoCards(
                                context, controller.statusList[index], index);
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 84.w,
                          height: 40,
                          child: AppButton(
                            label: "Done",
                            onTap:(){
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 4), end: const Offset(0, 0))
              .animate(anim),
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 05 * anim.value,
                sigmaY: 05 * anim.value,
              ),
              child: child),
        );
      },
    );
  }

  statusInfoCards(context, String list, int index) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.setStatus(index);
          controller.setStatusValue(list);
        },
        child: Column(
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: controller.selectedStatus.value == index
                      ? AppColors().primaryColor
                      : AppColors().white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border: Border.all(
                    width: 1,
                    color: AppColors().black.withOpacity(0.3),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    list,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: controller.selectedStatus.value == index
                          ? AppColors().white
                          : AppColors().black,
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: AppColors().white,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
