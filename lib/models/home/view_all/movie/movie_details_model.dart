class MovieDetailsModel {
    final MovieDetails? details;
    final List<Server>? server;
    final List<Cast>? cast;
    final List<Cast>? director;
    final List<Cast>? writer;
    // final List<Review>? reviews;
    final List<MovieDetails>? relatedMovie;
    final List<MovieDetails>? recommendedMovie;
    final List<int>? playlistIds;
    final Rental? rental;

    MovieDetailsModel({
        this.details,
        this.server,
        this.cast,
        this.director,
        this.writer,
        // this.reviews,
        this.relatedMovie,
        this.recommendedMovie,
        this.playlistIds,
        this.rental,
    });

    factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => MovieDetailsModel(
        details: json["details"] == null ? null : MovieDetails.fromJson(json["details"]),
        server: json["server"] == null ? [] : List<Server>.from(json["server"]!.map((x) => Server.fromJson(x))),
        cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
        director: json["director"] == null ? [] : List<Cast>.from(json["director"]!.map((x) => Cast.fromJson(x))),
        writer: json["writer"] == null ? [] : List<Cast>.from(json["writer"]!.map((x) => Cast.fromJson(x))),
        // reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        relatedMovie: json["related_movie"] == null ? [] : List<MovieDetails>.from(json["related_movie"]!.map((x) => MovieDetails.fromJson(x))),
        recommendedMovie: json["recommended_movie"] == null ? [] : List<MovieDetails>.from(json["recommended_movie"]!.map((x) => MovieDetails.fromJson(x))),
        playlistIds: json["playlist_ids"] == null ? [] : List<int>.from(json["playlist_ids"]!.map((x) => x)),
        rental: json["rental"] == null ? null : Rental.fromJson(json["rental"]),
    );
}

class Cast {
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

    Cast({
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

    factory Cast.fromJson(Map<String, dynamic> json) => Cast(
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

// class Review {
//     final int reviewId;
//     final int userId;
//     final String name;
//     final String review;
//     final int rating;
//     final String image;

//     Review({
//         required this.reviewId,
//         required this.userId,
//         required this.name,
//         required this.review,
//         required this.rating,
//         required this.image,
//     });

//     factory Review.fromJson(Map<String, dynamic> json) => Review(
//         reviewId: json["review_id"],
//         userId: json["user_id"],
//         name: json["name"],
//         review: json["review"],
//         rating: json["rating"],
//         image: json["image"],
//     );
// }

class MovieDetails {
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
    final dynamic focusKeyword;
    final String? metaDescription;
    final dynamic tags;
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
    final bool? isFavorite;
    

    MovieDetails({
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
        this.isFavorite,
    });

    factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
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
        isFavorite: json["is_favorite"],
    );
}

class Server {
    final int? id;
    final dynamic streamKey;
    final int? videoId;
    final String? fileSource;
    final String? sourceType;
    final String? fileUrl;
    final String? label;
    final int? order;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Server({
        this.id,
        this.streamKey,
        this.videoId,
        this.fileSource,
        this.sourceType,
        this.fileUrl,
        this.label,
        this.order,
        this.createdAt,
        this.updatedAt,
    });

    factory Server.fromJson(Map<String, dynamic> json) => Server(
        id: json["id"],
        streamKey: json["stream_key"],
        videoId: json["video_id"],
        fileSource: json["file_source"],
        sourceType: json["source_type"],
        fileUrl: json["file_url"],
        label: json["label"],
        order: json["order"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}


class Rental {
    final String? price;
    final String? validity;
    final DateTime? expireData;

    Rental({
        this.price,
        this.validity,
        this.expireData,
    });

    factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        price: json["price"],
        validity: json["validity"],
        expireData: json["expire_data"] == null ? null : DateTime.parse(json["expire_data"]),
    );
}