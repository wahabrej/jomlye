
class LocalAdsModel {
    final List<Ads> ads;

    LocalAdsModel({
        required this.ads,
    });

    factory LocalAdsModel.fromJson(Map<String, dynamic> json) => LocalAdsModel(
        ads: List<Ads>.from(json["ads"].map((x) => Ads.fromJson(x))),
    );
}

class Ads {
    final int? id;
    final String? title;
    final String? type;
    final String? position;
    final int? status;
    final String? startDate;
    final String? endDate;
    final String? redirectUrl;
    final String? size;
    final String? banner;
    final dynamic content;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? poster;

    Ads({
        required this.id,
        required this.title,
        required this.type,
        required this.position,
        required this.status,
        required this.startDate,
        required this.endDate,
        required this.redirectUrl,
        required this.size,
        required this.banner,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
        required this.poster,
    });

    factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        position: json["position"],
        status: json["status"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        redirectUrl: json["redirect_url"],
        size: json["size"],
        banner: json["banner"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        poster: json["poster"],
    );
}
