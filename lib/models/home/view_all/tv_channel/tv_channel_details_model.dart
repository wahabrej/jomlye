class TvChannelDetailsModel {
    final LiveTvDetails? liveTvDetails;
    final List<LiveTvDetails>? relatedLiveTvs;
    final List<Stream>? stream;
    final String? shareLink;

    TvChannelDetailsModel({
        this.liveTvDetails,
        this.relatedLiveTvs,
        this.stream,
        this.shareLink,
    });

    factory TvChannelDetailsModel.fromJson(Map<String, dynamic> json) => TvChannelDetailsModel(
        liveTvDetails: json["live_tv_details"] == null ? null : LiveTvDetails.fromJson(json["live_tv_details"]),
        relatedLiveTvs: json["related_live_tvs"] == null ? [] : List<LiveTvDetails>.from(json["related_live_tvs"]!.map((x) => LiveTvDetails.fromJson(x))),
        stream: json["stream"] == null ? [] : List<Stream>.from(json["stream"]!.map((x) => Stream.fromJson(x))),
        shareLink: json["share_link"],
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
    final int? isFree;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? isFavorite;

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
        this.isFree,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isFavorite,
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
        isFree: json["is_free"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isFavorite: json["is_favorite"],
    );
}

class Stream {
    final int? id;
    final String? streamUrl;
    final String? streamLabel;

    Stream({
        this.id,
        this.streamUrl,
        this.streamLabel,
    });

    factory Stream.fromJson(Map<String, dynamic> json) => Stream(
        id: json["id"],
        streamUrl: json["stream_url"],
        streamLabel: json["stream_label"],
    );
}
