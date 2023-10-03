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

class SysDiaRecord extends StatelessWidget {
  SysDiaRecord({
    Key? key,
    required this.pressureRecord,
    this.onAfterDelete,
  }) : super(key: key);

  PressureRecordModel pressureRecord;
  final void Function(bool?, PressureRecordModel)? onAfterDelete;

  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
        color: AppColors().labelColors,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ));
    BPStatus bpStatus = getSysDiaStatus(pressureRecord.sys, pressureRecord.dia);
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
                String y = dateTime["year"].toString();
                String mo = dateTime["month"].toString();
                final prefs = await SharedPreferences.getInstance();
                String yData = prefs.getString(y)!;
                Map yDataDecoded = json.decode(yData);

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
                          decoration: BoxDecoration(
                            color: bpStatus.color,
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
                                txt: bpStatus.label,
                                maxLine: 2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: bpStatus.color == AppColors.elevated
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 80,
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: decoration,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppTitle(
                                    txt: "Systolic",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  AppTitle(
                                    txt: "mmHg",
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                  const SizedBox(width: 10),
                                  CountReading(
                                    AppColors.systolic,
                                    pressureRecord.sys,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 100,
                              width: 80,
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: decoration,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppTitle(
                                    txt: "Diastolic",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  AppTitle(
                                    txt: "mmHg",
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                  const SizedBox(width: 20),
                                  CountReading(
                                      AppColors.diastolic, pressureRecord.dia),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 100,
                              width: 80,
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: decoration,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppTitle(
                                    txt: "Pulse",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  AppTitle(
                                    txt: "BPM",
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                  const SizedBox(width: 20),
                                  CountReading(
                                      AppColors.pulse, pressureRecord.pulse),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Divider(
                          height: 5,
                          color: Colors.grey.withOpacity(.3),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: AppTitle(
                                txt: "📔 Note",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        pressureRecord.note == ""
                            ? AppTitle(
                                txt: "No Notes",
                                fontSize: 13,
                                color: Colors.grey,
                              )
                            : Container(
                                height: 100,
                                width: 80.w,
                                margin:
                                    const EdgeInsets.only(left: 5, right: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: decoration,
                                child: Text(
                                  pressureRecord.note,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(.7),
                                    fontSize: 16,
                                  ),
                                ),
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
        height: 110,
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
              decoration: BoxDecoration(
                color: bpStatus.color,
                borderRadius: const BorderRadius.only(
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
                    txt: "Pulse: ${pressureRecord.pulse.toString()} 💗 BPM",
                    fontSize: 14,
                    color: AppColors().onBoarding,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    width: 200,
                    child: AppTitle(
                      txt: bpStatus.label,
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
                        pressureRecord.date.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors().onBoarding,
                        ),
                      ),
                      const SizedBox(width: 120),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppTitle(
                            txt: pressureRecord.sys.toString(),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors().black,
                          ),
                          const SizedBox(width: 5),
                          AppTitle(
                            txt: pressureRecord.dia.toString(),
                            fontSize: 14,
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
