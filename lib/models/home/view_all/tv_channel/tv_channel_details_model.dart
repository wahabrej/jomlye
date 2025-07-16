class TvChannelDetailsModel {
    final LiveTvDetails? liveTvDetails;
    final List<dynamic>? relatedLiveTvs;

    TvChannelDetailsModel({
        this.liveTvDetails,
        this.relatedLiveTvs,
    });

    factory TvChannelDetailsModel.fromJson(Map<String, dynamic> json) => TvChannelDetailsModel(
        liveTvDetails: json["live_tv_details"] == null ? null : LiveTvDetails.fromJson(json["live_tv_details"]),
        relatedLiveTvs: json["related_live_tvs"] == null ? [] : List<dynamic>.from(json["related_live_tvs"]!.map((x) => x)),
    );
}

class LiveTvDetails {
    final int? id;
    final String? tvName;
    final String? slug;
    final String? description;
    final int? liveTvCategoryId;
    final int? countryId;
    final String? language;
    final String? streamFrom;
    final String? streamLabel;
    final String? streamUrl;
    final String? thumbnail;
    final String? tags;
    final String? seoTitle;
    final String? focusKeyword;
    final String? metaDescription;
    final int? todayView;
    final int? weeklyView;
    final int? monthlyView;
    final int? totalView;
    final int? featured;
    final int? isPaid;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? isFavorite;
    final Stream1? stream1;

    LiveTvDetails({
        this.id,
        this.tvName,
        this.slug,
        this.description,
        this.liveTvCategoryId,
        this.countryId,
        this.language,
        this.streamFrom,
        this.streamLabel,
        this.streamUrl,
        this.thumbnail,
        this.tags,
        this.seoTitle,
        this.focusKeyword,
        this.metaDescription,
        this.todayView,
        this.weeklyView,
        this.monthlyView,
        this.totalView,
        this.featured,
        this.isPaid,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isFavorite,
        this.stream1,
    });

    factory LiveTvDetails.fromJson(Map<String, dynamic> json) => LiveTvDetails(
        id: json["id"],
        tvName: json["tv_name"],
        slug: json["slug"],
        description: json["description"],
        liveTvCategoryId: json["live_tv_category_id"],
        countryId: json["country_id"],
        language: json["language"],
        streamFrom: json["stream_from"],
        streamLabel: json["stream_label"],
        streamUrl: json["stream_url"],
        thumbnail: json["thumbnail"],
        tags: json["tags"],
        seoTitle: json["seo_title"],
        focusKeyword: json["focus_keyword"],
        metaDescription: json["meta_description"],
        todayView: json["today_view"],
        weeklyView: json["weekly_view"],
        monthlyView: json["monthly_view"],
        totalView: json["total_view"],
        featured: json["featured"],
        isPaid: json["is_paid"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isFavorite: json["is_favorite"],
        stream1: json["stream1"] == null ? null : Stream1.fromJson(json["stream1"]),
    );
}
class Stream1 {
    int id;
    String streamKey;
    int liveTvId;
    String urlFor;
    String source;
    String label;
    String quality;
    String url;
    DateTime createdAt;
    DateTime updatedAt;

    Stream1({
        required this.id,
        required this.streamKey,
        required this.liveTvId,
        required this.urlFor,
        required this.source,
        required this.label,
        required this.quality,
        required this.url,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Stream1.fromJson(Map<String, dynamic> json) => Stream1(
        id: json["id"],
        streamKey: json["stream_key"],
        liveTvId: json["live_tv_id"],
        urlFor: json["url_for"],
        source: json["source"],
        label: json["label"],
        quality: json["quality"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );
}

