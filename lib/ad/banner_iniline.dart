import 'package:budgetplanner/ad/ad_helper.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/settings/language_data.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerInlinePage extends StatefulWidget {
  const BannerInlinePage({Key? key}) : super(key: key);

  @override
  _BannerInlinePageState createState() => _BannerInlinePageState();
}

class _BannerInlinePageState extends State<BannerInlinePage> {
  // TODO: Add _kAdIndex
  static final _kAdIndex = 2;

  // TODO: Add a NativeAd instance
  late NativeAd _ad;

  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;

  // TODO: Add _getDestinationItemIndex()
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();

    // TODO: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        // TODO: Adjust itemCount based on the ad load state
        itemCount:
            LanguageData.getLanguageList().length + (_isAdLoaded ? 1 : 0),
        itemBuilder: (context, index) {
          // TODO: Render a banner ad
          if (_isAdLoaded && index == _kAdIndex) {
            return Container(
              child: AdWidget(ad: _ad),
              height: 72.0,
              alignment: Alignment.center,
            );
          } else {
            // TODO: Get adjusted item index from _getDestinationItemIndex()
            LanguageDataModel item =
                LanguageData.getLanguageList()[_getDestinationItemIndex(index)];

            return ListTile(
              title: Text(item.name),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: Dispose a NativeAd object
    _ad.dispose();

    super.dispose();
  }
}
