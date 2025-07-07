import 'dart:io';

class AdHelper{
  static String get bannerAdUnitId{
    if(Platform.isAndroid){
      return "ca-app-pub-8804541030596323/3997364373";
    }
    else if(Platform.isIOS){
      return "<Your ios banner ad id>";
    }
    else{
      throw UnsupportedError("UnSupported Platform");
    }
  } 
  static String get interestitialAdUnitId{
    if(Platform.isAndroid){
      return "ca-app-pub-8804541030596323/9087438325";
    }
    else if(Platform.isIOS){
      return "<Your ios banner ad id>";
    }
    else{
      throw UnsupportedError("UnSupported Platform");
    }
  } 
}