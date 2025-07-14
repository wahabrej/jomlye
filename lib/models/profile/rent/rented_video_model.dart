class RentedVideoModel {
    final List<Rent>? rents;

    RentedVideoModel({
        this.rents,
    });

    factory RentedVideoModel.fromJson(Map<String, dynamic> json) => RentedVideoModel(
        rents: json["rents"] == null ? [] : List<Rent>.from(json["rents"]!.map((x) => Rent.fromJson(x))),
    );
}

class Rent {
    final int? id;
    final int? userId;
    final int? videoId;
    final String? videoType;
    final String? transactionId;
    final int? price;
    final int? duration;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? title;
    final String? image;

    Rent({
        this.id,
        this.userId,
        this.videoId,
        this.videoType,
        this.transactionId,
        this.price,
        this.duration,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.image,
    });

    factory Rent.fromJson(Map<String, dynamic> json) => Rent(
        id: json["id"],
        userId: json["user_id"],
        videoId: json["video_id"],
        videoType: json["video_type"],
        transactionId: json["transaction_id"],
        price: json["price"],
        duration: json["duration"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        title: json["title"],
        image: json["image"],
    );
}
