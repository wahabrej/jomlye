
class ArtistModel {
    final int? currentPage;
    final List<ArtistData>? data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link>? links;
    final String? nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    ArtistModel({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ArtistData>.from(json["data"]!.map((x) => ArtistData.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );
}

class ArtistData {
    final int? id;
    final String? starName;
    final String? slug;
    final String? starType;
    final String? starImage;
    final dynamic starDesc;
    final int? view;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    ArtistData({
        this.id,
        this.starName,
        this.slug,
        this.starType,
        this.starImage,
        this.starDesc,
        this.view,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory ArtistData.fromJson(Map<String, dynamic> json) => ArtistData(
        id: json["id"],
        starName: json["star_name"],
        slug: json["slug"],
        starType: json["star_type"],
        starImage: json["star_image"],
        starDesc: json["star_desc"],
        view: json["view"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}


class Link {
    final String? url;
    final String? label;
    final bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );
}
