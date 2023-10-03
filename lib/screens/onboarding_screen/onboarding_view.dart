import 'package:bptracker/core/services/cache_manager.dart';
import 'package:bptracker/screens/bottom_nav/bottom_nav.dart';
import 'package:bptracker/utils/export.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phlox_animations/phlox_animations.dart';

import 'onboarding_contents_file.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with CacheManager{
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getTopBar(i),
                      const SizedBox(height: 50),
                      getImages(i),
                      const SizedBox(height: 10),
                      getTitle(i),
                      const SizedBox(height: 10),
                      getSubTitle(i),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
          ),

          ///___________________  ElevatedButton ____________________

          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                GestureDetector(
                  onTap: () {

                    if (currentIndex == contents.length - 1) {
                      saveFirstRun(true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BottomNav(),
                        ),
                      );
                    }
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  },
                  child: Container(
                    height: 52,
                    width: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFD4685),
                          Color(0xFFFFA28D),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      currentIndex == contents.length - 1
                          ? AppConstants().create_An_Account
                          : "Next",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: AppColors().white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: currentIndex == index ?10:8,
      width: currentIndex == index ? 10 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: currentIndex == index ? const Color(0xFFFD4685) : Colors.grey.shade400,
      ),
    );
  }

  getTopBar(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        i != 0
            ? Icon(
                Icons.arrow_back_ios,
                color: AppColors().onBoarding,
                size: 24,
              )
            : Container(),
        const SizedBox(width: 80),
        InkWell(
          onTap: () {
            if (currentIndex == contents.length - 1) {
              saveFirstRun(true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const BottomNav(),
                ),
              );
            }
            _controller.nextPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceIn,
            );
          },
          child: Text(
            currentIndex == contents.length - 1 ? " " : AppConstants().skip,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 17,
                color: AppColors().onBoarding,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  getImages(int i) {
    return PhloxAnimations(
      duration: const Duration(seconds: 1),
      fromY: -100,
      // fromX: -50,
      child: Image.asset(
        contents[i].image!,
        height: 220,
        width: 300,
      ),
    );
  }

  getTitle(int i) {
    return PhloxAnimations(
      duration: const Duration(seconds: 1),
      fromY: -100,
      child: Text(
        contents[i].title!,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
            fontSize: 40,
            color: AppColors().black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  getSubTitle(int i) {
    return PhloxAnimations(
      duration: const Duration(seconds: 1),
      fromY: -100,
      child: Text(
        contents[i].subTitle!,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              color: AppColors().onBoarding,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
