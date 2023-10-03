import 'package:bptracker/models/languages.dart';
import 'package:bptracker/screens/home_screen/home_view.dart';
import 'package:bptracker/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:bptracker/main.dart';


import '../../widgets/app_button.dart';
import '../../widgets/custom_app_bar.dart';
import 'languages_controller.dart';
int myIndex = 0;


class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LanguageController>(
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors().white,
          bottomNavigationBar: controller.bannerLoaded
              ? controller.admobAdsManager.getBannerAd()
              : const SizedBox(),
          appBar: CustomAppBar(
            title: "Language",
            isBack: true,
            space: 4,
          ),
          body: ListView(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.languagesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return languageCards(
                        context, controller.languagesList[index], index);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 84.w,
                    height: 40,
                    child: AppButton(
                      label: "Save",
                      onTap: ()  {
                        //MyApp.setLocale(context, Locale(controller.languagesList[myIndex].countryCode.toString()));
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView()));
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          SystemNavigator.pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  languageCards(
    context,
    Languages list,
    int index,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          myIndex = index;
          controller.setLanguages(index,context);
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
                  color: controller.selectedLang.value == index
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
                  Row(
                    children: [
                      Image.asset(
                        list.countryFlag,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        list.countryName.tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: controller.selectedLang.value == index
                              ? AppColors().white
                              : AppColors().black,
                        ),
                      ),
                    ],
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
