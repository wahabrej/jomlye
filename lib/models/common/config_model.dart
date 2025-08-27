
class ConfigModel {
    final String? currencySymbol;
    final String? googleDriveApiKey;
    final String? bannerAds;
    final String? bannerAdsId;
    final String? interstitialAds;
    final String? interstitialAdsId;
    final String? admobPublisherId;
    final String? stripeKey;
    final String? stripeSecret;

    ConfigModel({
        this.currencySymbol,
        this.googleDriveApiKey,
        this.bannerAds,
        this.bannerAdsId,
        this.interstitialAds,
        this.interstitialAdsId,
        this.admobPublisherId,
        this.stripeKey,
        this.stripeSecret,
    });

    factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        currencySymbol: json["currency_symbol"],
        googleDriveApiKey: json["google_drive_api_key"],
        bannerAds: json["banner_ads"],
        bannerAdsId: json["banner_ads_id"],
        interstitialAds: json["interstitial_ads"],
        interstitialAdsId: json["interstitial_ads_id"],
        admobPublisherId: json["admob_publisher_id"],
        stripeKey: json["stripe_key"],
        stripeSecret: json["stripe_secret"],
    );
}
