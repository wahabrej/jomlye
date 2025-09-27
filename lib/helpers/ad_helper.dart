import 'dart:io';

import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';

import '../utils/constants/imports.dart';

class AdHelper{
  static String get bannerAdUnitId{
    if(Platform.isAndroid){
      return Get.find<GlobalController>().configModelData.value?.bannerAdsId??"";
    }
    else if(Platform.isIOS){
      return "ca-app-pub-8804541030596323/2426710878";
    }
    else{
      throw UnsupportedError("UnSupported Platform");
    }
  } 
  static String get interestitialAdUnitId{
    if(Platform.isAndroid){
      return Get.find<GlobalController>().configModelData.value?.interstitialAdsId??"";
    }
    else if(Platform.isIOS){
      return "ca-app-pub-8804541030596323/6149515225";
    }
    else{
      throw UnsupportedError("UnSupported Platform");
    }
  } 
}