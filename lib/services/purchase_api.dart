import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi{
  static const androidRevenueCatApiKey = "goog_lMCUdhQUqyRayrgmScTVACjoNGL";//!your android revenuecat api key
 static Future<void> initRevenueCat() async {
  await Purchases.setDebugLogsEnabled(true);
  await Purchases.setup(androidRevenueCatApiKey);
}
}