
class HomeDataModel {
    final List<NewReleaseMovie>? slider;
    final List<Genre>? genres;
    final List<NewReleaseMovie>? newReleaseMovies;
    final List<NewReleaseMovie>? trendingMovies;
    final List<NewReleaseMovie>? recommendedMovies;
    final List<NewReleaseMovie>? popularTvShows;
    final String? promoVideo;
    final String? historySlider;
    final List<FeaturedTvChannel>? featuredTvChannels;
    final List<NewReleaseMovie>? tvShows;
    final List<TopArtist>? topArtists;
    final List<LatestBlog>? latestBlogs;

    HomeDataModel({
        this.slider,
        this.genres,
        this.newReleaseMovies,
        this.trendingMovies,
        this.recommendedMovies,
        this.popularTvShows,
        this.promoVideo,
        this.historySlider,
        this.featuredTvChannels,
        this.tvShows,
        this.topArtists,
        this.latestBlogs,
    });

    factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        slider: json["sliders"] == null ? [] : List<NewReleaseMovie>.from(json["sliders"]!.map((x) => NewReleaseMovie.fromJson(x))),
        genres: json["genres"] == null ? [] : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        newReleaseMovies: json["new_release_movies"] == null ? [] : List<NewReleaseMovie>.from(json["new_release_movies"]!.map((x) => NewReleaseMovie.fromJson(x))),
        trendingMovies: json["trending_movies"] == null ? [] : List<NewReleaseMovie>.from(json["trending_movies"]!.map((x) => NewReleaseMovie.fromJson(x))),
        recommendedMovies: json["recommended_movies"] == null ? [] : List<NewReleaseMovie>.from(json["recommended_movies"]!.map((x) => NewReleaseMovie.fromJson(x))),
        popularTvShows: json["popular_tv_shows"] == null ? [] : List<NewReleaseMovie>.from(json["popular_tv_shows"]!.map((x) => NewReleaseMovie.fromJson(x))),
        promoVideo: json["promo_video"],
        historySlider: json["history_slider"],
        featuredTvChannels: json["featured_tv_channels"] == null ? [] : List<FeaturedTvChannel>.from(json["featured_tv_channels"]!.map((x) => FeaturedTvChannel.fromJson(x))),
        tvShows: json["tv_shows"] == null ? [] : List<NewReleaseMovie>.from(json["tv_shows"]!.map((x) => NewReleaseMovie.fromJson(x))),
        topArtists: json["top_artists"] == null ? [] : List<TopArtist>.from(json["top_artists"]!.map((x) => TopArtist.fromJson(x))),
        latestBlogs: json["latest_blogs"] == null ? [] : List<LatestBlog>.from(json["latest_blogs"]!.map((x) => LatestBlog.fromJson(x))),
    );
}

class FeaturedTvChannel {
    final int? id;
    final String? tvName;
    final String? slug;
    final dynamic description;
    final int? liveTvCategoryId;
    final String? language;
    final String? streamFrom;
    final String? streamLabel;
    final String? streamUrl;
    final String? poster;
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

    FeaturedTvChannel({
        this.id,
        this.tvName,
        this.slug,
        this.description,
        this.liveTvCategoryId,
        this.language,
        this.streamFrom,
        this.streamLabel,
        this.streamUrl,
        this.poster,
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
    });

    factory FeaturedTvChannel.fromJson(Map<String, dynamic> json) => FeaturedTvChannel(
        id: json["id"],
        tvName: json["tv_name"],
        slug: json["slug"],
        description: json["description"],
        liveTvCategoryId: json["live_tv_category_id"],
        language: json["language"],
        streamFrom: json["stream_from"],
        streamLabel: json["stream_label"],
        streamUrl: json["stream_url"],
        poster: json["poster"],
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
    );
}

class Genre {
    final int? id;
    final String? name;
    final String? slug;
    final dynamic description;
    final dynamic icon;
    final int? featured;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Genre({
        this.id,
        this.name,
        this.slug,
        this.description,
        this.icon,
        this.featured,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        icon: json["icon"],
        featured: json["featured"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

class LatestBlog {
    final int? id;
    final String? title;
    final String? slug;
    final dynamic description;
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
}

class NewReleaseMovie {
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
    final String? traillerYoutubeSource;
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

    NewReleaseMovie({
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

    factory NewReleaseMovie.fromJson(Map<String, dynamic> json) => NewReleaseMovie(
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

// enum Writer {
//     EMPTY,
//     THE_1170,
//     THE_155156156156,
//     THE_262263264265,
//     THE_6870,
//     THE_69,
//     THE_6972
// }

// final writerValues = EnumValues({
//     "[]": Writer.EMPTY,
//     "[\"1170\"]": Writer.THE_1170,
//     "[\"155\",\"156\",\"156\",\"156\"]": Writer.THE_155156156156,
//     "[\"262\",\"263\",\"264\",\"265\"]": Writer.THE_262263264265,
//     "[\"68\",\"70\"]": Writer.THE_6870,
//     "[\"69\"]": Writer.THE_69,
//     "[\"69\",\"72\"]": Writer.THE_6972
// });

class TopArtist {
    final int? id;
    final String? starName;
    final String? slug;
    final String? starType;
    final String? starImage;
    final String? starDesc;
    final int? view;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    TopArtist({
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

    factory TopArtist.fromJson(Map<String, dynamic> json) => TopArtist(
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

