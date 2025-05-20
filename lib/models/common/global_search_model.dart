import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/tv_shows/tv_shows_model.dart';

class GlobalSearchModel {
    GlobalSearchedData? searchedData;
    Filter? filter;

    GlobalSearchModel({
        this.searchedData,
        this.filter,
    });

    factory GlobalSearchModel.fromJson(Map<String, dynamic> json) => GlobalSearchModel(
        searchedData: json["searched_data"] == null ? null : GlobalSearchedData.fromJson(json["searched_data"]),
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    );
}

class Filter {
    List<Categories>? categories;
    List<Countries>? country;
    List<Countries>? genre;
    List<int>? year;

    Filter({
        this.categories,
        this.country,
        this.genre,
        this.year,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        categories: json["categories"] == null ? [] : List<Categories>.from(json["categories"]!.map((x) => Categories.fromJson(x))),
        country: json["country"] == null ? [] : List<Countries>.from(json["country"]!.map((x) => Countries.fromJson(x))),
        genre: json["genre"] == null ? [] : List<Countries>.from(json["genre"]!.map((x) => Countries.fromJson(x))),
        year: json["year"] == null ? [] : List<int>.from(json["year"]!.map((x) => x)),
    );
}
class GlobalSearchedData {
    int? currentPage;
    List<SearchData>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    GlobalSearchedData({
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

    factory GlobalSearchedData.fromJson(Map<String, dynamic> json) => GlobalSearchedData(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<SearchData>.from(json["data"]!.map((x) => SearchData.fromJson(x))),
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

class SearchData {
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
    String? videoType;
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
    String? traillerYoutubeSource;
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

    SearchData({
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

    factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
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

class Link {
    String? url;
    String? label;
    bool? active;

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


