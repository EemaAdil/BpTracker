import 'package:bptracker/core/base/export.dart';
import 'package:bptracker/utils/export.dart';
import 'package:bptracker/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/post_model.dart';
import '../../widgets/custom_app_bar.dart';
import '../post_detail_screen/post_detail_view.dart';
import 'posts_controller.dart';

class PostsView extends GetView<PostsController> {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      initState: (_) {
        Get.put(PostsController());
      },
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors().white,
          bottomNavigationBar: controller.bannerLoaded
              ? controller.admobAdsManager.getBannerAd()
              : const SizedBox(),
          appBar: CustomAppBar(
            title: "Info & Knowledge",
            isBack: false,
            space: 4,
          ),
          body: ListView(
            shrinkWrap: true,
            physics:const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(controller.posts.length, (index) {
                      return Center(
                        child: SelectCard(
                          post: controller.posts[index],
                          controller: controller,
                        ),
                      );
                    })),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class SelectCard extends StatelessWidget {
  SelectCard({
    Key? key,
    required this.post,
    required this.controller,
  }) : super(key: key);

  final PostModel post;
  PostsController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.admobAdsManager.showAdmobInterAd();
        Get.to(
          () => const PostsDetailsView(),
          binding: Appbindings(),
          arguments: {"post": post},
          duration: const Duration(seconds: 1),
          transition: Transition.leftToRightWithFade,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets().imgGuideBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              post.icon,
              height: 28,
              width: 28,
            ),
            Text(
              post.title,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors().white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class H4 extends StatelessWidget {
  H4({Key? key, required this.txt}) : super(key: key);
  String txt;

  @override
  Widget build(BuildContext context) {
    return AppTitle(
      txt: txt,
      maxLine: 2,
      fontSize: 18,
      color: Colors.black.withOpacity(.7),
      fontWeight: FontWeight.bold,
    );
  }
}

class Para extends StatelessWidget {
  Para({
    Key? key,
    required this.txt,
  }) : super(key: key);
  String txt;

  final TextStyle styles = TextStyle(
    color: Colors.black.withOpacity(.7),
    fontSize: 16,
    wordSpacing: 1.w,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Text(
        txt,
        style: styles,
      ),
    );
  }
}
