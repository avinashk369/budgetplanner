import 'package:budgetplanner/ad/ad_helper.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends GetxController {
  static AdController tagged(String name) => Get.find<AdController>(tag: name);
  var isBannerAdReady = false.obs;
  setBannerAdReady(bool ready) => isBannerAdReady(ready);
  // TODO: Add _isInterstitialAdReady
  var isInterstitialAdReady = false.obs;
  setInterstitialAdReady(bool ready) => isInterstitialAdReady(ready);
  var isRewardedAdReady = false.obs;
  setRewardedAdReady(bool ready) => isRewardedAdReady(ready);

  var isNativeAdReady = false.obs;
  setNativeAdReady(bool ready) => isNativeAdReady(ready);

  @override
  void onInit() {
    // TODO: implement onInit
    loadBannerAd();
    //loadNativeAd();
    loadInterstitialAd();
    //_loadRewardedAd();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    interstitialAd?.dispose();
    bannerAd?.dispose();
    //ad?.dispose();
    rewardedAd?.dispose();
  }

  // TODO: Add _bannerAd
  BannerAd? bannerAd;

  void loadBannerAd() {
    // TODO: Initialize _bannerAd
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setBannerAdReady(true);
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          setBannerAdReady(false);
          ad.dispose();
        },
      ),
    );

    bannerAd?.load();
  }

// TODO: Add _interstitialAd
  InterstitialAd? interstitialAd;
  // TODO: Implement _loadInterstitialAd()
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this.interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //_moveToHome();
              print("What to do now");
              Future.delayed(Duration(seconds: 5), () async {
                //loadInterstitialAd();
              });
            },
          );

          setInterstitialAdReady(true);
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          setInterstitialAdReady(false);
        },
      ),
    );
  }

// TODO: Add _rewardedAd
  RewardedAd? rewardedAd;
  // TODO: Add _isRewardedAdReady

  // TODO: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this.rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setRewardedAdReady(false);
              _loadRewardedAd();
            },
          );

          setRewardedAdReady(true);
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setRewardedAdReady(false);
        },
      ),
    );
  }

  /// need rework here to make this native ad work
  // NativeAd? ad;
  // void loadNativeAd() {
  //   ad = NativeAd(
  //     adUnitId: AdHelper.nativeAdUnitId,
  //     factoryId: 'listTile',
  //     request: AdRequest(),
  //     listener: NativeAdListener(
  //       onAdLoaded: (_) {
  //         setNativeAdReady(true);
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         // Releases an ad resource when it fails to load
  //         ad.dispose();
  //         setNativeAdReady(false);
  //         print('Ad load failed (code=${error.code} message=${error.message})');
  //       },
  //     ),
  //   );

  //   ad?.load();
  // }
}
