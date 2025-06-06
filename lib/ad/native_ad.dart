import 'package:budgetplanner/controllers/ad_controller.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdView extends StatefulWidget {
  const NativeAdView({Key? key}) : super(key: key);

  @override
  _NativeAdViewState createState() => _NativeAdViewState();
}

class _NativeAdViewState extends State<NativeAdView> {
  final controller = AdController.tagged(newAdController);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.isNativeAdReady.value)
          ? Container(
              // child: AdWidget(ad: controller.ad!),
              height: 72.0,
              alignment: Alignment.center,
            )
          : Container(),
    );
  }
}
