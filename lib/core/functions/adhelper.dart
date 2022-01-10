import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
   bool isBannerAdReady = false;
  static String getbannerAdUnitId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  BannerAd getbanner() {
    return BannerAd(
      size: AdSize.largeBanner,
      adUnitId: getbannerAdUnitId(),
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
            isBannerAdReady = true;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
  }
}
