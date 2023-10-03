import '../../core/base/base_controller.dart';
import '../../utils/admob_ads_manager.dart';


class HomeController extends BaseController {

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
    admobAdsManager.loadNativeAd();
  }


  @override
  void dispose() {
    admobAdsManager.disposeBannerAd();
    super.dispose();
  }


}
