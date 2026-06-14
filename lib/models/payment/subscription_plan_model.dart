class SubscriptionPlanModel {
    final List<Packages>? packages;

    SubscriptionPlanModel({
        this.packages,
    });

    factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => SubscriptionPlanModel(
        packages: json["packages"] == null ? [] : List<Packages>.from(json["packages"]!.map((x) => Packages.fromJson(x))),
    );
}

class Packages {
    final int? id;
    final String? name;
    final int? day;
    final int? screens;
    final String? type;
    final String? priceId;
    final String? price;
    final dynamic discount;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? storeSubscriptionId;

    Packages({
        this.id,
        this.name,
        this.day,
        this.screens,
        this.type,
        this.priceId,
        this.price,
        this.discount,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.storeSubscriptionId,
    });

    factory Packages.fromJson(Map<String, dynamic> json) => Packages(
        id: json["id"],
        name: json["name"],
        day: json["day"],
        screens: json["screens"],
        type: json["type"],
        priceId: json["price_id"],
        price: json["price"],
        discount: json["discount"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        storeSubscriptionId: json["storeSubscriptionId"],
    );
}
