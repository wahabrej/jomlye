import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi{
  static const revenueCatApiKey = "goog_lMCUdhQUqyRayrgmScTVACjoNGL";//!your revenuecat api key
 static Future<void> initRevenueCat() async {
  await Purchases.setDebugLogsEnabled(true);
  await Purchases.setup(revenueCatApiKey);
}
}