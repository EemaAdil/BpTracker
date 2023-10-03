
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/base/export.dart';
import '../core/services/cache_manager.dart';
import '../utils/export.dart';
import 'bottom_nav/export.dart';
import 'onboarding_screen/export.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreen createState() => _MySplashScreen();
}

class _MySplashScreen extends State<MySplashScreen> with CacheManager {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        checkUserIsLogin();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors().white,
      child: Padding(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: Image.asset(
            AppAssets().appLogo,
            scale: 4.0,
          ),
        ),
      ),
    );
  }

  checkUserIsLogin() {
    saveFirstRunNull(false);
    debugPrint(getFirstRun().toString());

    var bool = getFirstRun();

    Future.delayed(Duration.zero, () async {
      if (bool == true) {
        Get.offAll(
          () => const BottomNav(),
          binding: Appbindings(),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingView(),
          ),
        );
      }
    });
  }
}
