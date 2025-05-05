import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_model.dart';
import 'package:vidflix_flutter_app/models/home/view_all/tv_shows/tv_shows_model.dart';

class MovieListModel {
    final Movies? movies;
    final Filter? filter;

    MovieListModel({
        this.movies,
        this.filter,
    });

    factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        movies: json["movies"] == null ? null : Movies.fromJson(json["movies"]),
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    );
}

class Filter {
    final List<Categories>? categories;
    final List<Countries>? languages;
    final List<Countries>? country;
    final List<Countries>? genre;
    final List<int>? year;
    final Map<String, String>? sort;

    Filter({
        this.categories,
        this.languages,
        this.country,
        this.genre,
        this.year,
        this.sort,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        categories: json["categories"] == null ? [] : List<Categories>.from(json["categories"]!.map((x) => Categories.fromJson(x))),
        languages: json["languages"] == null ? [] : List<Countries>.from(json["languages"]!.map((x) => Countries.fromJson(x))),
        country: json["country"] == null ? [] : List<Countries>.from(json["country"]!.map((x) => Countries.fromJson(x))),
        genre: json["genre"] == null ? [] : List<Countries>.from(json["genre"]!.map((x) => Countries.fromJson(x))),
        year: json["year"] == null ? [] : List<int>.from(json["year"]!.map((x) => x)),
        sort: Map.from(json["sort"]!).map((k, v) => MapEntry<String, String>(k, v)),
    );
}


class Movies {
    final int? currentPage;
    final List<MovieData>? data;
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

    Movies({
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

    factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<MovieData>.from(json["data"]!.map((x) => MovieData.fromJson(x))),
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

class MovieData {
    final int? id;
    final String? title;
    final String? thumbnail;
    final String? poster;
    final String? slug;
    final String? seoTitle;
    final String? description;
    final String? stars;
    final String? director;
    final String? writer;
    final String? rating;
    final DateTime? release;
    final String? country;
    final String? genre;
    final String? language;
    final String? videoType;
    final String? runtime;
    final String? videoQuality;
    final int? isPaid;
    final int? isOriginal;
    final int? isTrending;
    final int? isFeatured;
    final int? isRecommended;
    final int? isBlockbuster;
    final int? isRealLifeStory;
    final int? status;
    final int? trailer;
    final dynamic traillerYoutubeSource;
    final int? enableDownload;
    final String? focusKeyword;
    final String? metaDescription;
    final String? tags;
    final String? imdbRating;
    final int? isTvseries;
    final int? totalRating;
    final int? todayView;
    final int? weeklyView;
    final int? monthlyView;
    final int? totalView;
    final DateTime? lastEpAdded;
    final String? imdbid;
    final int? tmdbId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    MovieData({
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
    });

    factory MovieData.fromJson(Map<String, dynamic> json) => MovieData(
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
