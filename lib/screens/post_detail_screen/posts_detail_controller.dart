import 'package:get/get.dart';

import '../../core/base/base_controller.dart';
import '../../models/post_model.dart';
import '../../utils/admob_ads_manager.dart';

class PostsDetailsController extends BaseController {

  late AdmobAdsManager admobAdsManager;
  bool bannerLoaded = false;

  PostModel post = Get.arguments["post"];

  @override
  void onInit() {
    super.onInit();
    admobAdsManager = AdmobAdsManager();
    admobAdsManager.loadBannerAd((val) {
      bannerLoaded = val;
      update();
    });
    admobAdsManager.loadIntertitialAd();
  }

  @override
  void dispose() {
    admobAdsManager.disposeBannerAd();
    super.dispose();
  }
}
