
class InterestListModel {
    final List<Interest>? interests;

    InterestListModel({
        this.interests,
    });

    factory InterestListModel.fromJson(Map<String, dynamic> json) => InterestListModel(
        interests: json["interests"] == null ? [] : List<Interest>.from(json["interests"]!.map((x) => Interest.fromJson(x))),
    );
}

class Interest {
    final int? id;
    final String? title;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Interest({
        this.id,
        this.title,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}
