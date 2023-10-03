import 'package:bptracker/utils/app_colors.dart';
import 'package:bptracker/widgets/app_card.dart';
import 'package:bptracker/widgets/app_container.dart';
import 'package:bptracker/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_app_bar.dart';
import 'posts_detail_controller.dart';

class PostsDetailsView extends GetView<PostsDetailsController> {
  const PostsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsDetailsController>(initState: (_) {
      Get.put(PostsDetailsController());
    }, builder: (_) {
      return Scaffold(
        backgroundColor: AppColors().white,
        bottomNavigationBar: controller.bannerLoaded
            ? controller.admobAdsManager.getBannerAd()
            : const SizedBox(),
        appBar: CustomAppBar(
          title: 'Details',
          isBack: true,
          space: 10,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            AppTitle(
              txt: controller.post.title,
              maxLine: 3,
              fontSize: 28,
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.post.content,
              ),
            ),
            const SizedBox(height: 10),
          ]),
        ),
      );
    });
  }
}
