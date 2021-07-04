import 'package:budgetplanner/ad/ad_helper.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends GetxController {
  static AdController tagged(String name) => Get.find<AdController>(tag: name);
  var isBannerAdReady = false.obs;
  setBannerAdReady(bool ready) => isBannerAdReady(ready);

  @override
  void onInit() {
    // TODO: implement onInit
    loadBannerAd();
    super.onInit();
  }

  // TODO: Add _bannerAd
  late BannerAd bannerAd;

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

    bannerAd.load();
  }
}
