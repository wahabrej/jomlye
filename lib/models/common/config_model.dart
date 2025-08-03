class ConfigModel {
    final String? currencySymbol;
    final String? googleDriveApiKey;

    ConfigModel({
        this.currencySymbol,
        this.googleDriveApiKey,
    });

    factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        currencySymbol: json["currency_symbol"],
        googleDriveApiKey: json["google_drive_api_key"],
    );
}
