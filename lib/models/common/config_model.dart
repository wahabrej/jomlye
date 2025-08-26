class ConfigModel {
    final String? currencySymbol;
    final String? googleDriveApiKey;
    final dynamic bannerAds;
    final dynamic bannerAdsId;
    final dynamic interstitialAds;
    final dynamic interstitialAdsId;
    final dynamic admobPublisherId;

    ConfigModel({
        this.currencySymbol,
        this.googleDriveApiKey,
        this.bannerAds,
        this.bannerAdsId,
        this.interstitialAds,
        this.interstitialAdsId,
        this.admobPublisherId,
    });

    factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        currencySymbol: json["currency_symbol"],
        googleDriveApiKey: json["google_drive_api_key"],
        bannerAds: json["banner_ads"],
        bannerAdsId: json["banner_ads_id"],
        interstitialAds: json["interstitial_ads"],
        interstitialAdsId: json["interstitial_ads_id"],
        admobPublisherId: json["admob_publisher_id"],
    );

    Map<String, dynamic> toJson() => {
        "currency_symbol": currencySymbol,
        "google_drive_api_key": googleDriveApiKey,
        "banner_ads": bannerAds,
        "banner_ads_id": bannerAdsId,
        "interstitial_ads": interstitialAds,
        "interstitial_ads_id": interstitialAdsId,
        "admob_publisher_id": admobPublisherId,
    };
}
