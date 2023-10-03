import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/base/base_controller.dart';
import '../../../utils/export.dart';
import '../../models/bmi_info.dart';

class BMIController extends BaseController {
  List<BMIInfo> bmiList = [];
  List<String> heightList = [];
  List<String> weightList = [];
  RxString height = "ft.in".obs;
  RxString weight = "Kg".obs;

  RxInt ft = 5.obs;
  RxInt inc = 50.obs;
  RxInt cm = 170.obs;
  RxInt kgLb = 50.obs;

  double? bmi=0.0;
  String? finalBmi="17.5";

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
    //
    getBmiList();
    getHeightList();
    getWeightList();
  }

  getBmiList() {
    bmiList.add(BMIInfo(
      color: AppColors.normal,
      title: "Normal",
      value: "< 18-24.9",
    ));
    bmiList.add(BMIInfo(
      color: AppColors.elevated,
      title: "Underweight",
      value: "<18.0",
    ));
    bmiList.add(BMIInfo(
      color: AppColors.hts1,
      title: "Overweight",
      value: "<25.0-29.9",
    ));
    bmiList.add(BMIInfo(
      color: AppColors.hts1_1,
      title: "Obesede Class I",
      value: "<30.0-34.9",
    ));
    bmiList.add(BMIInfo(
      color: AppColors.hts2,
      title: "Obesede Class II",
      value: "<35.0-39.9",
    ));
    bmiList.add(BMIInfo(
      color: AppColors().primary,
      title: "Obesede Class III",
      value: ">40",
    ));
  }

  getHeightList() {
    heightList.add("ft.in");
    heightList.add("cm");
  }

  getWeightList() {
    weightList.add("Kg");
    weightList.add("Lb");
  }

  setHeight(String value) {
    height.value = value;
    update();
  }

  setWeight(String value) {
    weight.value = value;
    update();
  }

  setFt(int value) {
    ft.value = value;
    update();
  }

  setInc(int value) {
    inc.value = value;
    update();
  }

  setCm(int value) {
    cm.value = value;
    update();
  }

  setKgLbNumber(int value) {
    kgLb.value = value;
    update();
  }

   calculateBMI() {
    if(height.value=="ft.in" && weight.value=="Kg"){
      cm.value = (ft.value * 30.48 + inc.value * 2.54).toInt();
      bmi = kgLb.value / pow(cm.value / 100, 2);
      finalBmi=bmi!.toStringAsFixed(1);
      update();
    }else if(height.value=="ft.in" && weight.value=="Lb"){
      cm.value = (ft.value * 30.48 + inc.value * 2.54).toInt();
      bmi = convertKGtoLB(double.parse(kgLb.value.toString())) / pow(cm.value / 100, 2);
      finalBmi=bmi!.toStringAsFixed(1);
      update();
    }else if(height.value=="ft.in" && weight.value=="Kg"){
      cm.value = (ft.value * 30.48 + inc.value * 2.54).toInt();
      bmi = kgLb.value / pow(cm.value / 100, 2);
      finalBmi=bmi!.toStringAsFixed(1);
      update();
    }else{
      bmi = kgLb.value / pow(cm.value / 100, 2);
      finalBmi=bmi!.toStringAsFixed(1);
      update();
    }

    AppUtils().showMessage("BMI Calculated", "Your BMI IS = $finalBmi");

  }

  double convertKGtoLB(double kg) => kg * 2.20462;

  String getResult() {
    if (bmi! >= 25) {
      return 'Overweight';
    } else if (bmi! > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (bmi! >= 25) {
      return 'You have a higher than normal body weight.\n Try to exercise more.';
    } else if (bmi! >= 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight.\n You can eat a bit more.';
    }
  }

  @override
  void dispose() {
    super.dispose();
    admobAdsManager.disposeBannerAd();
  }
}
