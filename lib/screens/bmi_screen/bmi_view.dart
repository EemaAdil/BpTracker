import 'dart:ui';

import 'package:bptracker/utils/ads_manager.dart';
import 'package:bptracker/utils/app_colors.dart';
import 'package:bptracker/widgets/app_button.dart';
import 'package:bptracker/widgets/app_card.dart';
import 'package:bptracker/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';

import '../../models/bmi_info.dart';
import 'export.dart';

class BMIView extends GetView<BMIController> {
  const BMIView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BMIController>(
      initState: (_) {
        Get.put(BMIController());
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
                getNormalBtn(context),
                const SizedBox(height: 20),
                getInformation(),
                const SizedBox(height: 20),
                getHeightWeight(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80.w,
                      height: 40,
                      child: AppButton(
                        label: "Calculate",
                        onTap: () {
                          controller.calculateBMI();
                        },
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
        "BMI",
        style: TextStyle(
          fontSize: 16,
          color: AppColors().onBoarding,
        ),
      ),
    );
  }

  getNormalBtn(context) {
    return GestureDetector(
      onTap: () {
        bmiInfoDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 22,
        ),
        decoration: const BoxDecoration(
          color: AppColors.normal,
          borderRadius: BorderRadius.all(
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
              txt: "Normal",
              maxLine: 2,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  getInformation() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTitle(
              txt: controller.finalBmi.toString(),
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppColors().primaryColor,
            ),
            const SizedBox(width: 10),
            AppTitle(
              txt: "BMI",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(.3),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTitle(
              txt: "Healthy weight range for you:",
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors().black.withOpacity(0.3),
            ),
            AppTitle(
              txt: "50kg to 80 kg",
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors().black.withOpacity(0.3),
            ),
          ],
        )
      ],
    );
  }

  getHeightWeight() {
    return AppCard(
      padding: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTitle(
                txt: "Height",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(.7),
              ),
              const SizedBox(width: 20),
              heightDropDown(),
            ],
          ),
          const SizedBox(height: 10),
          Obx(
            () => Container(
              width: 80.w,
              height: 160,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: controller.height.value == "ft.in"
                  ? getFtIncNumber()
                  : getCmNumber(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTitle(
                txt: "Weight",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(.7),
              ),
              const SizedBox(width: 20),
              weightDropDown(),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: 80.w,
            height: 160,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: getKbLbNumber(),
          ),
        ],
      ),
    );
  }

  heightDropDown() {
    return SizedBox(
      height: 40,
      width: 50,
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              controller.height.value,
              style: TextStyle(
                color: Colors.black.withOpacity(0.3),
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors().primaryColor,
            ),
            iconSize: 24,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? newValue) {
              controller.setHeight(newValue!);
            },
            items: controller.heightList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  weightDropDown() {
    return SizedBox(
      height: 40,
      width: 50,
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              controller.weight.value,
              style: TextStyle(
                color: Colors.black.withOpacity(0.3),
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors().primaryColor,
            ),
            iconSize: 24,
            isExpanded: true,
            elevation: 16,
            onChanged: (String? newValue) {
              controller.setWeight(newValue!);
            },
            items: controller.weightList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  getFtIncNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                value: controller.ft.value,
                minValue: 1,
                maxValue: 10,
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
                  controller.setFt(value);
                }),
          ),
        ),
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
                value: controller.inc.value,
                minValue: 1,
                maxValue: 100,
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
                  controller.setInc(value);
                }),
          ),
        ),
      ],
    );
  }

  getCmNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
                value: controller.cm.value,
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
                  controller.setCm(value);
                }),
          ),
        ),
      ],
    );
  }

  getKbLbNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
                value: controller.kgLb.value,
                minValue: 1,
                maxValue: 100,
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
                  controller.setKgLbNumber(value);
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

  bmiInfoDialog(context) {
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
                    getDialogAppBar("BMI Types", 50),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.bmiList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return infoCards(
                                context, controller.bmiList[index]);
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

  infoCards(context, BMIInfo list) {
    return Column(
      children: [
        Container(
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
                    txt: "BMI",
                    fontSize: 14,
                    color: AppColors().black,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
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
        const SizedBox(height: 10),
      ],
    );
  }
}
