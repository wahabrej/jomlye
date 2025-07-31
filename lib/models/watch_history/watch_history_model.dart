class WatchHistoryModel {
    final Histories? histories;

    WatchHistoryModel({
        this.histories,
    });

    factory WatchHistoryModel.fromJson(Map<String, dynamic> json) => WatchHistoryModel(
        histories: json["histories"] == null ? null : Histories.fromJson(json["histories"]),
    );
}

class Histories {
    final int? currentPage;
    final List<WatchHistoryData>? data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link>? links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    Histories({
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

    factory Histories.fromJson(Map<String, dynamic> json) => Histories(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<WatchHistoryData>.from(json["data"]!.map((x) => WatchHistoryData.fromJson(x))),
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

class WatchHistoryData {
    final int? id;
    final int? userId;
    final String? watchableType;
    final int? watchableId;
    final String? duration;
    final WatchableDetails? watchableDetails;
    final String? watchedSeconds;
    final int? watchCount;
    final String? completionPercentage;
    final DateTime? lastWatchedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    WatchHistoryData({
        this.id,
        this.userId,
        this.watchableType,
        this.watchableId,
        this.duration,
        this.watchedSeconds,
        this.watchableDetails,
        this.watchCount,
        this.completionPercentage,
        this.lastWatchedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory WatchHistoryData.fromJson(Map<String, dynamic> json) => WatchHistoryData(
        id: json["id"],
        userId: json["user_id"],
        watchableType: json["watchable_type"],
        watchableId: json["watchable_id"],
        duration: json["duration"],
        watchedSeconds: json["watched_seconds"],
        watchableDetails: json["watchable_details"] == null ? null : WatchableDetails.fromJson(json["watchable_details"]),
        watchCount: json["watch_count"],
        completionPercentage: json["completion_percentage"],
        lastWatchedAt: json["last_watched_at"] == null ? null : DateTime.parse(json["last_watched_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

class WatchableDetails {
    final String? title;
    final String? thumbnail;

    WatchableDetails({
        this.title,
        this.thumbnail,
    });
    factory WatchableDetails.fromJson(Map<String, dynamic> json) => WatchableDetails(
        title: json["title"],
        thumbnail: json["thumbnail"],
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
