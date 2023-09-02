// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:artisian/view/landing.dart';
import 'package:artisian/widget/custombottom.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AdHelper {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 2;
  //if false ads will be shown
  bool isPremiumUser =
      false; // Add the boolean variable to determine premium status
  bool get ispremiumUser => isPremiumUser;

  //AdHelper(this.isPremiumUser);
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7532038627653553/9125070261';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7532038627653553/9125070261';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  BannerAd? get bannerAd {
    if (!isPremiumUser) {
      createBannerAd(); // Create the banner ad if the user is not premium
    }
    return _bannerAd;
  }

  BannerAd createBannerAd() {
    // If the user is not a premium user, show the banner ad
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: 'ca-app-pub-7532038627653553/9125070261',
      listener: AdHelper.bannerListener,
      request: const AdRequest(),
    )..load();

    log("done");

    return _bannerAd!;
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7532038627653553/8340517927';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7532038627653553/8340517927';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/5224354917';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }

//ad create
  void createInterstitialAd(BuildContext context) {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _showInterstitialAd(context);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd(context);
          } else {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const CustomNavigationBar(),
            //   ),
            //   (route) => false,
            // );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Landing()),
                (route) => false);
          }
        },
      ),
    );
  }

  void _showInterstitialAd(BuildContext context) {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        Navigator.pop(context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) =>  CustomAnimatedBottomBar()),
        //   (route) => false,
        // );
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint("Ad loaded"),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint("Ad failed to load: $error");
    },
    onAdOpened: (ad) => debugPrint("Ad opened"),
    onAdClosed: (ad) => debugPrint("Ad closed"),
  );
}
