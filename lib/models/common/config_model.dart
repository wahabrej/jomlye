class ConfigModel {
    final String? currencySymbol;

    ConfigModel({
        this.currencySymbol,
    });

    factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        currencySymbol: json["currency_symbol"],
    );
}
