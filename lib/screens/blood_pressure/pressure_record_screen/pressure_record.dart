import 'dart:ui';

import 'package:bptracker/models/blood_pressure_info.dart';
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

import 'export.dart';

class PressureRecord extends GetView<PressureRecordController> {
  const PressureRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PressureRecordController>(
      initState: (_) {
        Get.put(PressureRecordController());
      },
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
                GestureDetector(
                  onTap: () {
                    bloodPressureInfoDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 22,
                    ),
                    decoration: BoxDecoration(
                      color: controller.crrbpStatus.color,
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
                        const SizedBox(width: 10),
                        AppTitle(
                          txt: controller.crrbpStatus.label,
                          maxLine: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              controller.crrbpStatus.color == AppColors.elevated
                                  ? Colors.black
                                  : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTitle(
                      txt: controller.crrbpStatus.msg,
                      fontSize: 16,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                getNumberDropDown(),
                const SizedBox(height: 20),
                DateTimePicker(
                  date: controller.date,
                  onDateChanged: controller.onDateChanged,
                  time: controller.time,
                  onTimeChanged: controller.onTimeChanged,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    AppTitle(
                      txt: "Note",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.7),
                    ),
                    const SizedBox(width: 5),
                    AppTitle(
                      txt: "(optional)",
                      fontSize: 13,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.5),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                AppCard(
                  padding: 5,
                  child: TextFormField(
                    controller: controller.noteController,
                    textInputAction: TextInputAction.done,
                    enableSuggestions: false,
                    autocorrect: false,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        focusColor: AppColors().primary,
                        hintText: 'Write a Note'),
                  ),
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

  getAppBar(){
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
        "New Record",
        style: TextStyle(
          fontSize: 16,
          color: AppColors().onBoarding,
        ),
      ),
    );
  }

  getDialogAppBar(){
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: AppColors().onBoarding,
            ),
          ),
          Text(
            "Blood Pressure Types",
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

  getNumberDropDown() {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              AppTitle(
                txt: "Systolic",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              AppTitle(
                txt: "mmHg",
                fontSize: 16,
                color: AppColors().onBoarding,
              ),
              SizedBox(
                width: 40,
                child: NumberPicker(
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
                    value: controller.sysVal,
                    minValue: 20,
                    maxValue: 200,
                    selectedTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors().black,
                    ),
                    textStyle: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(.2)),
                    onChanged: (value) {
                      controller.sysVal = value;
                      controller.observeCrrStatus();
                    }),
              ),
            ],
          ),
          Column(
            children: [
              AppTitle(
                txt: "Diastolic",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              AppTitle(
                txt: "mmHg",
                fontSize: 16,
                color: AppColors().onBoarding,
              ),
              SizedBox(
                width: 40,
                child: NumberPicker(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: Colors.black.withOpacity(0.3),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(.3),
                        width: 1,
                      ),
                    )),
                    value: controller.diaVal,
                    minValue: 20,
                    maxValue: 200,
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
                      controller.diaVal = value;
                      controller.observeCrrStatus();
                    }),
              ),
            ],
          ),
          Column(
            children: [
              AppTitle(
                txt: "Pulse",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              AppTitle(
                txt: "BMP",
                fontSize: 16,
                color: AppColors().onBoarding,
              ),
              SizedBox(
                width: 40,
                child: NumberPicker(
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
                  value: controller.pulseVal,
                  minValue: 20,
                  maxValue: 200,
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
                    controller.pulseVal = value;
                    controller.update();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bloodPressureInfoDialog(context) {
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
                    getDialogAppBar(),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.list.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return infoCards(context, controller.list[index]);
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

  infoCards(context, BloodPressureInfo list) {
    return Column(
      children: [
        Container(
          height: 100,
          padding: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: AppColors().labelColors,
            borderRadius: const BorderRadius.all(
                Radius.circular(20)
            ),
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
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTitle(
                      txt: list.startValue,
                      fontSize: 14,
                      color: AppColors().black,
                      fontWeight: FontWeight.w600,
                    ),
                    AppTitle(
                      txt: list.centerValue,
                      fontSize: 14,
                      color: AppColors().onBoarding,
                    ),
                    AppTitle(
                      txt: list.endValue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors().black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
