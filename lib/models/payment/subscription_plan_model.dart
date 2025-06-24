
class SubscriptionPlanModel {
    final List<Package>? packages;

    SubscriptionPlanModel({
        this.packages,
    });

    factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => SubscriptionPlanModel(
        packages: json["packages"] == null ? [] : List<Package>.from(json["packages"]!.map((x) => Package.fromJson(x))),
    );
}

class Package {
    final int? id;
    final String? name;
    final int? day;
    final int? screens;
    final int? price;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Package({
        this.id,
        this.name,
        this.day,
        this.screens,
        this.price,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        name: json["name"],
        day: json["day"],
        screens: json["screens"],
        price: json["price"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}