import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';

class BannerAdView extends StatefulWidget {
  const BannerAdView({Key? key}) : super(key: key);

  @override
  _BannerAdViewState createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
  final controller = AdController.tagged(newAdController);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Obx(() => (controller.isBannerAdReady.value)
          ? Container(
              width: controller.bannerAd.size.width.toDouble(),
              height: controller.bannerAd.size.height.toDouble(),
              child: AdWidget(ad: controller.bannerAd),
            )
          : Container(
              height: 1,
              width: 1,
            )),
    );
  }
}
