import 'package:vidflix_flutter_app/models/home/view_all/movie/movie_details_model.dart';

class TvShowDetailsModel {
    final TvShows? shows;
    final List<Cast>? cast;
    final List<Cast>? director;
    final List<Cast>? writer;
    final List<TvShows>? relatedTvShows;
    final List<String>? videoTags;
    TvShowDetailsModel({
        this.shows,
        this.cast,
        this.director,
        this.writer,
        this.relatedTvShows,
        this.videoTags,
    });
    factory TvShowDetailsModel.fromJson(Map<String, dynamic> json) => TvShowDetailsModel(
        shows: json["shows"] == null ? null : TvShows.fromJson(json["shows"]),
        cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
        director: json["director"] == null ? [] : List<Cast>.from(json["director"]!.map((x) => Cast.fromJson(x))),
        writer: json["writer"] == null ? [] : List<Cast>.from(json["writer"]!.map((x) => Cast.fromJson(x))),
        relatedTvShows: json["related_tv_shows"] == null ? [] : List<TvShows>.from(json["related_tv_shows"]!.map((x) => TvShows.fromJson(x))),
        videoTags: json["video_tags"] == null ? [] : List<String>.from(json["video_tags"]!.map((x) => x)),
    );
}

class TvShows {
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
    final dynamic rating;
    final DateTime? release;
    final String? country;
    final String? genre;
    final String? language;
    final dynamic videoType;
    final dynamic runtime;
    final String? videoQuality;
    final int? isPaid;
    final int? isOriginal;
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
    final List<Season>? seasons;

    TvShows({
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
        this.seasons,
    });

    factory TvShows.fromJson(Map<String, dynamic> json) => TvShows(
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
        seasons: json["seasons"] == null ? [] : List<Season>.from(json["seasons"]!.map((x) => Season.fromJson(x))),
    );
}

class Season {
    final int? id;
    final int? tvShowId;
    final String? seasonName;
    final int? order;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Episode>? episodes;

    Season({
        this.id,
        this.tvShowId,
        this.seasonName,
        this.order,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.episodes,
    });

    factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        tvShowId: json["tv_show_id"],
        seasonName: json["season_name"],
        order: json["order"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        episodes: json["episodes"] == null ? [] : List<Episode>.from(json["episodes"]!.map((x) => Episode.fromJson(x))),
    );
}

class Episode {
    final int? id;
    final dynamic streamKey;
    final dynamic videoId;
    final int? seasonId;
    final String? episodeName;
    final String? description;
    final dynamic fileSource;
    final String? sourceType;
    final String? fileUrl;
    final int? order;
    final DateTime? dateAdded;
    final DateTime? lastEpAdded;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Episode({
        this.id,
        this.streamKey,
        this.videoId,
        this.seasonId,
        this.episodeName,
        this.description,
        this.fileSource,
        this.sourceType,
        this.fileUrl,
        this.order,
        this.dateAdded,
        this.lastEpAdded,
        this.createdAt,
        this.updatedAt,
    });

    factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        streamKey: json["stream_key"],
        videoId: json["video_id"],
        seasonId: json["season_id"],
        episodeName: json["episode_name"],
        description: json["description"],
        fileSource: json["file_source"],
        sourceType: json["source_type"],
        fileUrl: json["file_url"],
        order: json["order"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
        lastEpAdded: json["last_ep_added"] == null ? null : DateTime.parse(json["last_ep_added"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}
