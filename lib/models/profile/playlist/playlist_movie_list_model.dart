import 'package:vidflix_flutter_app/models/home/view_all/movie/movie_details_model.dart';

class PlaylistMovieListModel {
  final PlaylistDetails? playlistDetails;
  final List<PlayListMovie>? playListMovies;

  PlaylistMovieListModel({
    this.playlistDetails,
    this.playListMovies,
  });

  factory PlaylistMovieListModel.fromJson(Map<String, dynamic> json) =>
      PlaylistMovieListModel(
        playlistDetails: json["playlist_details"] == null
            ? null
            : PlaylistDetails.fromJson(json["playlist_details"]),
        playListMovies: json["play_list_movies"] == null
            ? []
            : List<PlayListMovie>.from(json["play_list_movies"]!
                .map((x) => PlayListMovie.fromJson(x))),
      );
}

class PlayListMovie {
  // final int? id;
  // final String? title;
  // final String? thumbnail;
  // final String? poster;
  // final String? slug;
  // final String? seoTitle;
  // final String? description;
  // final String? stars;
  // final String? director;
  // final String? writer;
  // final dynamic rating;
  // final DateTime? release;
  // final String? country;
  // final String? genre;
  // final String? language;
  // final dynamic videoType;
  // final String? runtime;
  // final String? videoQuality;
  // final int? isPaid;
  // final int? isOriginal;
  // final int? isTrending;
  // final int? isFeatured;
  // final int? isRecommended;
  // final int? isBlockbuster;
  // final int? isRealLifeStory;
  // final int? status;
  // final int? trailer;
  // final dynamic traillerYoutubeSource;
  // final int? enableDownload;
  // final String? focusKeyword;
  // final String? metaDescription;
  // final String? tags;
  // final String? imdbRating;
  // final int? isTvseries;
  // final int? totalRating;
  // final int? todayView;
  // final int? weeklyView;
  // final int? monthlyView;
  // final int? totalView;
  // final DateTime? lastEpAdded;
  // final String? imdbid;
  // final int? tmdbId;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;
  // final Pivot? pivot;
  final int? id;
  final dynamic name;
  final String? slug;
  final String? description;
  final dynamic releaseDate;
  final int? status;
  final String? thumbnail;
  final String? coverPhoto;
  final List<Cast>? cast;
  final List<Cast>? director;
  final List<Cast>? writer;
  final List<MovieDetails>? relatedMovies;

  PlayListMovie({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.releaseDate,
    this.status,
    this.thumbnail,
    this.coverPhoto,
    this.cast,
    this.director,
    this.writer,
    this.relatedMovies,
  });

  // PlayListMovie({
  //     this.id,
  //     this.title,
  //     this.thumbnail,
  //     this.poster,
  //     this.slug,
  //     this.seoTitle,
  //     this.description,
  //     this.stars,
  //     this.director,
  //     this.writer,
  //     this.rating,
  //     this.release,
  //     this.country,
  //     this.genre,
  //     this.language,
  //     this.videoType,
  //     this.runtime,
  //     this.videoQuality,
  //     this.isPaid,
  //     this.isOriginal,
  //     this.isTrending,
  //     this.isFeatured,
  //     this.isRecommended,
  //     this.isBlockbuster,
  //     this.isRealLifeStory,
  //     this.status,
  //     this.trailer,
  //     this.traillerYoutubeSource,
  //     this.enableDownload,
  //     this.focusKeyword,
  //     this.metaDescription,
  //     this.tags,
  //     this.imdbRating,
  //     this.isTvseries,
  //     this.totalRating,
  //     this.todayView,
  //     this.weeklyView,
  //     this.monthlyView,
  //     this.totalView,
  //     this.lastEpAdded,
  //     this.imdbid,
  //     this.tmdbId,
  //     this.createdAt,
  //     this.updatedAt,
  //     this.pivot,
  // });

  // factory PlayListMovie.fromJson(Map<String, dynamic> json) => PlayListMovie(
  //       id: json["id"],
  //       title: json["title"],
  //       thumbnail: json["thumbnail"],
  //       poster: json["poster"],
  //       slug: json["slug"],
  //       seoTitle: json["seo_title"],
  //       description: json["description"],
  //       stars: json["stars"],
  //       director: json["director"],
  //       writer: json["writer"],
  //       rating: json["rating"],
  //       release:
  //           json["release"] == null ? null : DateTime.parse(json["release"]),
  //       country: json["country"],
  //       genre: json["genre"],
  //       language: json["language"],
  //       videoType: json["video_type"],
  //       runtime: json["runtime"],
  //       videoQuality: json["video_quality"],
  //       isPaid: json["is_paid"],
  //       isOriginal: json["is_original"],
  //       isTrending: json["is_trending"],
  //       isFeatured: json["is_featured"],
  //       isRecommended: json["is_recommended"],
  //       isBlockbuster: json["is_blockbuster"],
  //       isRealLifeStory: json["is_real_life_story"],
  //       status: json["status"],
  //       trailer: json["trailer"],
  //       traillerYoutubeSource: json["trailler_youtube_source"],
  //       enableDownload: json["enable_download"],
  //       focusKeyword: json["focus_keyword"],
  //       metaDescription: json["meta_description"],
  //       tags: json["tags"],
  //       imdbRating: json["imdb_rating"],
  //       isTvseries: json["is_tvseries"],
  //       totalRating: json["total_rating"],
  //       todayView: json["today_view"],
  //       weeklyView: json["weekly_view"],
  //       monthlyView: json["monthly_view"],
  //       totalView: json["total_view"],
  //       lastEpAdded: json["last_ep_added"] == null
  //           ? null
  //           : DateTime.parse(json["last_ep_added"]),
  //       imdbid: json["imdbid"],
  //       tmdbId: json["tmdb_id"],
  //       createdAt: json["created_at"] == null
  //           ? null
  //           : DateTime.parse(json["created_at"]),
  //       updatedAt: json["updated_at"] == null
  //           ? null
  //           : DateTime.parse(json["updated_at"]),
  //       pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  //     );
    factory PlayListMovie.fromJson(Map<String, dynamic> json) => PlayListMovie(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        releaseDate: json["release_date"],
        status: json["status"],
        thumbnail: json["thumbnail"],
        coverPhoto: json["cover_photo"],
        cast: json["cast"] == null ? [] : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
        director: json["director"] == null ? [] : List<Cast>.from(json["director"]!.map((x) => Cast.fromJson(x))),
        writer: json["writer"] == null ? [] : List<Cast>.from(json["writer"]!.map((x) => Cast.fromJson(x))),
        // relatedMovies: json["related_movies"] == null ? [] : List<dynamic>.from(json["related_movies"]!.map((x) => x)),
        relatedMovies: json["related_movies"] == null ? [] : List<MovieDetails>.from(json["related_movies"]!.map((x) => x)),
    );
}

// class Pivot {
//   final int? playListId;
//   final int? movieId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   Pivot({
//     this.playListId,
//     this.movieId,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//         playListId: json["play_list_id"],
//         movieId: json["movie_id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
// }

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

  factory PlaylistDetails.fromJson(Map<String, dynamic> json) =>
      PlaylistDetails(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        totalVideo: json["total_video"],
      );
}
