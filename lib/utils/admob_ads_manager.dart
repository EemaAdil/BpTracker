import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobAdsManager {
  static const bool isAdsEnabled = true;
  static const bool _testMode = true;



  /// AppID
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5939048168852289~3395426667";
    } else {
      throw UnsupportedError("Unsuported Platform");
    }
  }

  /// BannerAdUnitId
  static String get bannerAdUnitId {
    if (_testMode) {
      // Development
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      }
    } else {
      // Production
      if (Platform.isAndroid) {
        return "ca-app-pub-5939048168852289/3817226354";
      }
    }
    throw UnsupportedError("Unsupported platform");
  }

  /// InterstitialAdUnitId
  static String get intersitialAdUnitId {
    if (_testMode) {
      // Development
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/1033173712';
      }
    } else {
      // Production
      if (Platform.isAndroid) {
        return "ca-app-pub-5939048168852289/9921801405";
      }
    }
    throw UnsupportedError("Unsupported platform");
  }

  /// NativeAdUnitId
  static String get nativeAdUnitId {
    if (_testMode) {
      // Development
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/2247696110';
      }
    } else {
      // Production
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/2247696110";
      }
    }
    throw UnsupportedError("Unsupported platform");
  }

  /// Initialization
  static void admobInit() {
    if (isAdsEnabled) {
      WidgetsFlutterBinding.ensureInitialized();
      MobileAds.instance.initialize();
    }
  }
  //native ad
  NativeAd? nativeAd;
  bool _admobNativeLoaded = false;

  void loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: AdmobAdsManager.nativeAdUnitId,
      factoryId:  "listTileMedium",
      listener: NativeAdListener(onAdLoaded: (ad) {

        _admobNativeLoaded = true;

      }, onAdFailedToLoad: (ad, error) {
        nativeAd!.dispose();
      }),
      request: const AdRequest(),
    );
    nativeAd!.load();
  }

  ///
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  void loadIntertitialAd() {
    if (isAdsEnabled) {
      InterstitialAd.load(
          adUnitId: AdmobAdsManager.intersitialAdUnitId,
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              // Keep a reference to the ad so you can show it later.
              _interstitialAd = ad;
              _isInterstitialAdLoaded = true;
            },
            onAdFailedToLoad: (LoadAdError error) {
              // print('InterstitialAd failed to load: $error');
            },
          ));
    }
  }

  void showAdmobInterAd() {
    if (_isInterstitialAdLoaded && isAdsEnabled) {
      _interstitialAd.show();
    }
  }

  ///
  /// Admob Bannder Ad
  late BannerAd _bannerAd;
  bool _admobBannerLoaded = false;
  void loadBannerAd(Function(bool) onBannerLoaded) {
    if (isAdsEnabled) {
      _bannerAd = BannerAd(
        adUnitId: AdmobAdsManager.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(onAdLoaded: (ad) {
          _admobBannerLoaded = true;
          onBannerLoaded(true);
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        }),
      );

      _bannerAd.load();
    }
  }

  Widget getBannerAd() {
    return _admobBannerLoaded && AdmobAdsManager.isAdsEnabled
        ? SizedBox(
            height: _bannerAd.size.height.toDouble(),
            width: _bannerAd.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : const SizedBox();
  }
  Widget getNativeAd() {
    return _admobNativeLoaded && AdmobAdsManager.isAdsEnabled
        ? Container(
      margin: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: 265,
      child: AdWidget(
        ad: nativeAd!,
      ),
    )
        : SizedBox();
  }

  void disposeBannerAd() {
    if (isAdsEnabled && _admobBannerLoaded) {
      _bannerAd.dispose();
    }
  }
}
