class GlobalSearchModel {
    List<SearchedData>? searchedData;

    GlobalSearchModel({
        this.searchedData,
    });

    factory GlobalSearchModel.fromJson(Map<String, dynamic> json) => GlobalSearchModel(
        searchedData: json["searched_data"] == null ? [] : List<SearchedData>.from(json["searched_data"]!.map((x) => SearchedData.fromJson(x))),
    );
}

class SearchedData {
    int? id;
    String? title;
    String? thumbnail;
    String? poster;
    String? slug;
    String? seoTitle;
    String? description;
    String? stars;
    String? director;
    String? writer;
    dynamic rating;
    DateTime? release;
    String? country;
    String? genre;
    String? language;
    dynamic videoType;
    String? runtime;
    String? videoQuality;
    int? isPaid;
    int? isOriginal;
    int? isTrending;
    int? isFeatured;
    int? isRecommended;
    int? isBlockbuster;
    int? isRealLifeStory;
    int? status;
    int? trailer;
    dynamic traillerYoutubeSource;
    int? enableDownload;
    String? focusKeyword;
    String? metaDescription;
    String? tags;
    String? imdbRating;
    int? isTvseries;
    int? totalRating;
    int? todayView;
    int? weeklyView;
    int? monthlyView;
    int? totalView;
    DateTime? lastEpAdded;
    String? imdbid;
    int? tmdbId;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? type;

    SearchedData({
        this.id,
        this.title,
        this.thumbnail,
        this.poster,
        this.slug,
        this.seoTitle,
        this.description,
        this.stars,
        this.director,
        this.writer,
        this.rating,
        this.release,
        this.country,
        this.genre,
        this.language,
        this.videoType,
        this.runtime,
        this.videoQuality,
        this.isPaid,
        this.isOriginal,
        this.isTrending,
        this.isFeatured,
        this.isRecommended,
        this.isBlockbuster,
        this.isRealLifeStory,
        this.status,
        this.trailer,
        this.traillerYoutubeSource,
        this.enableDownload,
        this.focusKeyword,
        this.metaDescription,
        this.tags,
        this.imdbRating,
        this.isTvseries,
        this.totalRating,
        this.todayView,
        this.weeklyView,
        this.monthlyView,
        this.totalView,
        this.lastEpAdded,
        this.imdbid,
        this.tmdbId,
        this.createdAt,
        this.updatedAt,
        this.type,
    });

    factory SearchedData.fromJson(Map<String, dynamic> json) => SearchedData(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        poster: json["poster"],
        slug: json["slug"],
        seoTitle: json["seo_title"],
        description: json["description"],
        stars: json["stars"],
        director: json["director"],
        writer: json["writer"],
        rating: json["rating"],
        release: json["release"] == null ? null : DateTime.parse(json["release"]),
        country: json["country"],
        genre: json["genre"],
        language: json["language"],
        videoType: json["video_type"],
        runtime: json["runtime"],
        videoQuality: json["video_quality"],
        isPaid: json["is_paid"],
        isOriginal: json["is_original"],
        isTrending: json["is_trending"],
        isFeatured: json["is_featured"],
        isRecommended: json["is_recommended"],
        isBlockbuster: json["is_blockbuster"],
        isRealLifeStory: json["is_real_life_story"],
        status: json["status"],
        trailer: json["trailer"],
        traillerYoutubeSource: json["trailler_youtube_source"],
        enableDownload: json["enable_download"],
        focusKeyword: json["focus_keyword"],
        metaDescription: json["meta_description"],
        tags: json["tags"],
        imdbRating: json["imdb_rating"],
        isTvseries: json["is_tvseries"],
        totalRating: json["total_rating"],
        todayView: json["today_view"],
        weeklyView: json["weekly_view"],
        monthlyView: json["monthly_view"],
        totalView: json["total_view"],
        lastEpAdded: json["last_ep_added"] == null ? null : DateTime.parse(json["last_ep_added"]),
        imdbid: json["imdbid"],
        tmdbId: json["tmdb_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        type: json["type"],
    );
}
