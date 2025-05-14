class PlaylistMovieListModel {
    final PlaylistDetails? playlistDetails;
    final List<PlayListMovie>? playListMovies;

    PlaylistMovieListModel({
        this.playlistDetails,
        this.playListMovies,
    });

    factory PlaylistMovieListModel.fromJson(Map<String, dynamic> json) => PlaylistMovieListModel(
        playlistDetails: json["playlist_details"] == null ? null : PlaylistDetails.fromJson(json["playlist_details"]),
        playListMovies: json["play_list_movies"] == null ? [] : List<PlayListMovie>.from(json["play_list_movies"]!.map((x) => PlayListMovie.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "playlist_details": playlistDetails?.toJson(),
        "play_list_movies": playListMovies == null ? [] : List<dynamic>.from(playListMovies!.map((x) => x.toJson())),
    };
}

class PlayListMovie {
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
    final Pivot? pivot;

    PlayListMovie({
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
        this.pivot,
    });

    factory PlayListMovie.fromJson(Map<String, dynamic> json) => PlayListMovie(
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
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "poster": poster,
        "slug": slug,
        "seo_title": seoTitle,
        "description": description,
        "stars": stars,
        "director": director,
        "writer": writer,
        "rating": rating,
        "release": "${release!.year.toString().padLeft(4, '0')}-${release!.month.toString().padLeft(2, '0')}-${release!.day.toString().padLeft(2, '0')}",
        "country": country,
        "genre": genre,
        "language": language,
        "video_type": videoType,
        "runtime": runtime,
        "video_quality": videoQuality,
        "is_paid": isPaid,
        "is_original": isOriginal,
        "is_trending": isTrending,
        "is_featured": isFeatured,
        "is_recommended": isRecommended,
        "is_blockbuster": isBlockbuster,
        "is_real_life_story": isRealLifeStory,
        "status": status,
        "trailer": trailer,
        "trailler_youtube_source": traillerYoutubeSource,
        "enable_download": enableDownload,
        "focus_keyword": focusKeyword,
        "meta_description": metaDescription,
        "tags": tags,
        "imdb_rating": imdbRating,
        "is_tvseries": isTvseries,
        "total_rating": totalRating,
        "today_view": todayView,
        "weekly_view": weeklyView,
        "monthly_view": monthlyView,
        "total_view": totalView,
        "last_ep_added": lastEpAdded?.toIso8601String(),
        "imdbid": imdbid,
        "tmdb_id": tmdbId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
    };
}

class Pivot {
    final int? playListId;
    final int? movieId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Pivot({
        this.playListId,
        this.movieId,
        this.createdAt,
        this.updatedAt,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        playListId: json["play_list_id"],
        movieId: json["movie_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "play_list_id": playListId,
        "movie_id": movieId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class PlaylistDetails {
    final int? id;
    final int? userId;
    final String? name;
    final dynamic thumbnail;
    final dynamic totalVideo;

    PlaylistDetails({
        this.id,
        this.userId,
        this.name,
        this.thumbnail,
        this.totalVideo,
    });

    factory PlaylistDetails.fromJson(Map<String, dynamic> json) => PlaylistDetails(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        totalVideo: json["total_video"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "thumbnail": thumbnail,
        "total_video": totalVideo,
    };
}
