import 'dart:convert';

import 'package:bptracker/Methods/get_sys_dia_status.dart';
import 'package:bptracker/models/bp_status.dart';
import 'package:bptracker/models/pressure_record_model.dart';
import 'package:bptracker/utils/ads_manager.dart';
import 'package:bptracker/utils/app_colors.dart';
import 'package:bptracker/widgets/app_button.dart';
import 'package:bptracker/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/blood_sugar_record_model.dart';

class BloodSugarRecord extends StatelessWidget {
  BloodSugarRecord({
    Key? key,
    required this.pressureRecord,
    this.onAfterDelete,
  }) : super(key: key);

  BloodSugarRecordModel pressureRecord;
  final void Function(bool?, BloodSugarRecordModel)? onAfterDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.black.withOpacity(.4),
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        var r = showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              void _deletePressureRecord() async {
                AdsManager.showInterAd();
                Map dateTime = pressureRecord.dateTime;
                String y = "Sugar_${dateTime["year"].toString()}";
                String mo = dateTime["month"].toString();
                debugPrint(y.toString());
                final prefs = await SharedPreferences.getInstance();
                String? yData = prefs.getString(y);
                Map yDataDecoded = json.decode(yData!);

                Map mData = yDataDecoded[mo];
                print("========");
                // print("$day/$mo/$y");
                print(mData.keys.toList().length);
                mData.remove(pressureRecord.date);
                print(pressureRecord.date);
                // print(mData.keys.toList());
                print(mData.keys.toList().length);
                yDataDecoded[mo] = mData;
                String encodedData = json.encode(yDataDecoded);
                prefs.setString(y, encodedData);
                onAfterDelete!(true, pressureRecord);
                ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
                  backgroundColor: Colors.black.withOpacity(.7),
                  content: const Text('Deleted Successfully'),
                ));
                Get.back();
              }

              return Scaffold(
                backgroundColor: AppColors().white,
                body: Container(
                    height: 100.h,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          pressureRecord.date.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors().black),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 40,
                          width: 80.w,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 30,
                          ),
                          decoration: const BoxDecoration(
                            color:AppColors.normal,
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
                              const SizedBox(width: 60),
                              AppTitle(
                                txt: pressureRecord.selectedSugarType,
                                maxLine: 2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppTitle(
                          txt: pressureRecord.status,
                          maxLine: 2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 20),
                        Divider(
                          height: 5,
                          color: Colors.grey.withOpacity(.3),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 80.w,
                          child: AppButton(
                              label: "Delete",
                              bg: Colors.red,
                              height: 40,
                              onTap: _deletePressureRecord),
                        )
                      ],
                    )),
              );
            });
      },
      child: Container(
        height: 105,
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: AppColors().labelColors,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 15,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.normal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTitle(
                    txt: pressureRecord.date.toString(),
                    fontSize: 14,
                    color: AppColors().onBoarding,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    width: 200,
                    child: AppTitle(
                      txt: pressureRecord.selectedSugarType.toString(),
                      maxLine: 2,
                      fontSize: 18,
                      color: Colors.black.withOpacity(.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stage : ${pressureRecord.status.toString()}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors().onBoarding,
                        ),
                      ),
                      const SizedBox(width: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppTitle(
                            txt: pressureRecord.sugarType.toString(),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors().black.withOpacity(0.7),
                          ),
                          const SizedBox(width: 5),
                          AppTitle(
                            txt: pressureRecord.sugarNumber.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors().black,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox CountReading(Color color, int count) {
    return SizedBox(
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}
