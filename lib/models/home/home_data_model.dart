import 'package:flixoo_flutter_app/models/home/view_all/artist/artist_details_model.dart';
class HomeDataModel {
    final List<FeaturedMovie>? sliders;
    final List<Country>? genres;
    final List<FeaturedMovie>? newReleaseMovies;
    final List<FeaturedMovie>? trendingMovies;
    final List<FeaturedMovie>? recommendedMovies;
    final List<FeaturedMovie>? featuredMovies;
    final List<TvShow>? popularTvShows;
    final String? promoVideos;
    final String? historySliders;
    final List<FeaturedTvChannel>? featuredTvChannels;
    final List<TvShow>? tvShows;
    final List<TopArtist>? topArtists;
    final List<LatestBlog>? latestBlogs;
    final String? privacyPolicy;
    final String? paymentPolicy;
    final String? termsAndConditions;
    final List<Country>? countries;
    final List<LiveTvCategory>? liveTvCategories;

    HomeDataModel({
        this.sliders,
        this.genres,
        this.newReleaseMovies,
        this.trendingMovies,
        this.recommendedMovies,
        this.featuredMovies,
        this.popularTvShows,
        this.promoVideos,
        this.historySliders,
        this.featuredTvChannels,
        this.tvShows,
        this.topArtists,
        this.latestBlogs,
        this.privacyPolicy,
        this.paymentPolicy,
        this.termsAndConditions,
        this.countries,
        this.liveTvCategories,
    });

    factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        sliders: json["sliders"] == null ? [] : List<FeaturedMovie>.from(json["sliders"]!.map((x) => FeaturedMovie.fromJson(x))),
        genres: json["genres"] == null ? [] : List<Country>.from(json["genres"]!.map((x) => Country.fromJson(x))),
        newReleaseMovies: json["new_release_movies"] == null ? [] : List<FeaturedMovie>.from(json["new_release_movies"]!.map((x) => FeaturedMovie.fromJson(x))),
        trendingMovies: json["trending_movies"] == null ? [] : List<FeaturedMovie>.from(json["trending_movies"]!.map((x) => FeaturedMovie.fromJson(x))),
        recommendedMovies: json["recommended_movies"] == null ? [] : List<FeaturedMovie>.from(json["recommended_movies"]!.map((x) => FeaturedMovie.fromJson(x))),
        featuredMovies: json["featured_movies"] == null ? [] : List<FeaturedMovie>.from(json["featured_movies"]!.map((x) => FeaturedMovie.fromJson(x))),
        popularTvShows: json["popular_tv_shows"] == null ? [] : List<TvShow>.from(json["popular_tv_shows"]!.map((x) => TvShow.fromJson(x))),
        promoVideos: json["promo_videos"],
        historySliders: json["history_sliders"],
        featuredTvChannels: json["featured_tv_channels"] == null ? [] : List<FeaturedTvChannel>.from(json["featured_tv_channels"]!.map((x) => FeaturedTvChannel.fromJson(x))),
        tvShows: json["tv_shows"] == null ? [] : List<TvShow>.from(json["tv_shows"]!.map((x) => TvShow.fromJson(x))),
        topArtists: json["top_artists"] == null ? [] : List<TopArtist>.from(json["top_artists"]!.map((x) => TopArtist.fromJson(x))),
        latestBlogs: json["latest_blogs"] == null ? [] : List<LatestBlog>.from(json["latest_blogs"]!.map((x) => LatestBlog.fromJson(x))),
        privacyPolicy: json["privacy_policy"],
        paymentPolicy: json["payment_policy"],
        termsAndConditions: json["terms_and_conditions"],
        countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
        liveTvCategories: json["live_tv_categories"] == null ? [] : List<LiveTvCategory>.from(json["live_tv_categories"]!.map((x) => LiveTvCategory.fromJson(x))),
    );
}
class FeaturedMovie {
    final int? id;
    final String? title;
    final String? thumbnail;
    final String? poster;
    final bool? isFree;
    final bool? isRental;
    final String? price;
    final String? validity;
    final DateTime? expireData;
    final List<String>? tags;

    FeaturedMovie({
        this.id,
        this.title,
        this.thumbnail,
        this.poster,
        this.isFree,
        this.isRental,
        this.price,
        this.validity,
        this.expireData,
        this.tags,
    });

    factory FeaturedMovie.fromJson(Map<String, dynamic> json) => FeaturedMovie(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        poster: json["poster"],
        isFree: json["is_free"],
        isRental: json["is_rental"],
        price: json["price"],
        validity: json["validity"],
        expireData: json["expire_data"] == null ? null : DateTime.parse(json["expire_data"]),
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    );
}

class FeaturedTvChannel {
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
    final dynamic tags;
    final dynamic seoTitle;
    final dynamic focusKeyword;
    final dynamic metaDescription;
    final int? todayView;
    final int? weeklyView;
    final int? monthlyView;
    final int? totalView;
    final int? featured;
    final int? isFree;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic poster;

    FeaturedTvChannel({
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
        this.poster,
    });

    factory FeaturedTvChannel.fromJson(Map<String, dynamic> json) => FeaturedTvChannel(
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
        poster: json["poster"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tv_name": tvName,
        "slug": slug,
        "description": description,
        "live_tv_category_id": liveTvCategoryId,
        "country_id": countryId,
        "language": language,
        "stream_from": streamFrom,
        "stream_label": streamLabel,
        "stream_url": streamUrl,
        "thumbnail": thumbnail,
        "tags": tags,
        "seo_title": seoTitle,
        "focus_keyword": focusKeyword,
        "meta_description": metaDescription,
        "today_view": todayView,
        "weekly_view": weeklyView,
        "monthly_view": monthlyView,
        "total_view": totalView,
        "featured": featured,
        "is_free": isFree,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "poster": poster,
    };
}

class LatestBlog {
    final int? id;
    final String? title;
    final String? slug;
    final String? description;
    final int? categoryId;
    final String? image;
    final String? seoTitle;
    final String? metaDescription;
    final String? focusKeyword;
    final String? tags;
    final int? status;
    final int? isTop;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? author;

    LatestBlog({
        this.id,
        this.title,
        this.slug,
        this.description,
        this.categoryId,
        this.image,
        this.seoTitle,
        this.metaDescription,
        this.focusKeyword,
        this.tags,
        this.status,
        this.isTop,
        this.createdAt,
        this.updatedAt,
        this.author,
    });

    factory LatestBlog.fromJson(Map<String, dynamic> json) => LatestBlog(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        categoryId: json["category_id"],
        image: json["image"],
        seoTitle: json["seo_title"],
        metaDescription: json["meta_description"],
        focusKeyword: json["focus_keyword"],
        tags: json["tags"],
        status: json["status"],
        isTop: json["is_top"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "category_id": categoryId,
        "image": image,
        "seo_title": seoTitle,
        "meta_description": metaDescription,
        "focus_keyword": focusKeyword,
        "tags": tags,
        "status": status,
        "is_top": isTop,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "author": author,
    };
}

class LiveTvCategory {
    final int? id;
    final String? liveTvCategory;
    final String? slug;
    final String? liveTvCategoryDesc;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    LiveTvCategory({
        this.id,
        this.liveTvCategory,
        this.slug,
        this.liveTvCategoryDesc,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory LiveTvCategory.fromJson(Map<String, dynamic> json) => LiveTvCategory(
        id: json["id"],
        liveTvCategory: json["live_tv_category"],
        slug: json["slug"],
        liveTvCategoryDesc: json["live_tv_category_desc"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "live_tv_category": liveTvCategory,
        "slug": slug,
        "live_tv_category_desc": liveTvCategoryDesc,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class TvShow {
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
    final int? isOriginal;
    final int? isBlockbuster;
    final int? isRecommended;
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
    final int? isPopular;
    final int? isFeatured;
    final int? totalRating;
    final int? todayView;
    final int? weeklyView;
    final int? monthlyView;
    final int? totalView;
    final DateTime? lastViewReset;
    final DateTime? lastEpAdded;
    final String? imdbid;
    final int? tmdbId;
    final int? isFree;
    final int? isRental;
    final int? rentalPrice;
    final int? rentalDuration;
    final String? rentalType;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    TvShow({
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
        this.isOriginal,
        this.isBlockbuster,
        this.isRecommended,
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
        this.isPopular,
        this.isFeatured,
        this.totalRating,
        this.todayView,
        this.weeklyView,
        this.monthlyView,
        this.totalView,
        this.lastViewReset,
        this.lastEpAdded,
        this.imdbid,
        this.tmdbId,
        this.isFree,
        this.isRental,
        this.rentalPrice,
        this.rentalDuration,
        this.rentalType,
        this.createdAt,
        this.updatedAt,
    });

    factory TvShow.fromJson(Map<String, dynamic> json) => TvShow(
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
        isOriginal: json["is_original"],
        isBlockbuster: json["is_blockbuster"],
        isRecommended: json["is_recommended"],
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
        isPopular: json["is_popular"],
        isFeatured: json["is_featured"],
        totalRating: json["total_rating"],
        todayView: json["today_view"],
        weeklyView: json["weekly_view"],
        monthlyView: json["monthly_view"],
        totalView: json["total_view"],
        lastViewReset: json["last_view_reset"] == null ? null : DateTime.parse(json["last_view_reset"]),
        lastEpAdded: json["last_ep_added"] == null ? null : DateTime.parse(json["last_ep_added"]),
        imdbid: json["imdbid"],
        tmdbId: json["tmdb_id"],
        isFree: json["is_free"],
        isRental: json["is_rental"],
        rentalPrice: json["rental_price"],
        rentalDuration: json["rental_duration"],
        rentalType: json["rental_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

class TopArtist {
    final int? id;
    final String? starName;
    final String? slug;
    final String? starType;
    final dynamic countryId;
    final dynamic starDob;
    final dynamic ranking;
    final dynamic gender;
    final dynamic industries;
    final String? starImage;
    final dynamic starDesc;
    final int? view;
    final int? status;
    final dynamic facebook;
    final dynamic twitter;
    final dynamic instagram;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic countryName;
    final int? totalMovies;
    final int? totalTvShows;
    final List<dynamic>? industryNames;
    final dynamic country;

    TopArtist({
        this.id,
        this.starName,
        this.slug,
        this.starType,
        this.countryId,
        this.starDob,
        this.ranking,
        this.gender,
        this.industries,
        this.starImage,
        this.starDesc,
        this.view,
        this.status,
        this.facebook,
        this.twitter,
        this.instagram,
        this.createdAt,
        this.updatedAt,
        this.countryName,
        this.totalMovies,
        this.totalTvShows,
        this.industryNames,
        this.country,
    });

    factory TopArtist.fromJson(Map<String, dynamic> json) => TopArtist(
        id: json["id"],
        starName: json["star_name"],
        slug: json["slug"],
        starType: json["star_type"],
        countryId: json["country_id"],
        starDob: json["star_dob"],
        ranking: json["ranking"],
        gender: json["gender"],
        industries: json["industries"],
        starImage: json["star_image"],
        starDesc: json["star_desc"],
        view: json["view"],
        status: json["status"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        countryName: json["country_name"],
        totalMovies: json["total_movies"],
        totalTvShows: json["total_tv_shows"],
        industryNames: json["industry_names"] == null ? [] : List<dynamic>.from(json["industry_names"]!.map((x) => x)),
        country: json["country"],
    );
}