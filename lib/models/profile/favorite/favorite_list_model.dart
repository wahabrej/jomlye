
class FavoriteListModel {
    final List<Movie>? movies;
    final List<Movie>? tvShows;
    final List<LiveTv>? liveTvs;

    FavoriteListModel({
        this.movies,
        this.tvShows,
        this.liveTvs,
    });

    factory FavoriteListModel.fromJson(Map<String, dynamic> json) => FavoriteListModel(
        movies: json["movies"] == null ? [] : List<Movie>.from(json["movies"]!.map((x) => Movie.fromJson(x))),
        tvShows: json["tv_shows"] == null ? [] : List<Movie>.from(json["tv_shows"]!.map((x) => Movie.fromJson(x))),
        liveTvs: json["live_tvs"] == null ? [] : List<LiveTv>.from(json["live_tvs"]!.map((x) => LiveTv.fromJson(x))),
    );
}

class LiveTv {
    final int? id;
    final dynamic title;
    final String? thumbnail;

    LiveTv({
        this.id,
        this.title,
        this.thumbnail,
    });

    factory LiveTv.fromJson(Map<String, dynamic> json) => LiveTv(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
    );
}

class Movie {
    final int? id;
    final String? title;
    final String? thumbnail;
    final int? isFree;
    final int? isRental;
    final int? rentalPrice;
    final int? rentalDuration;

    Movie({
        this.id,
        this.title,
        this.thumbnail,
        this.isFree,
        this.isRental,
        this.rentalPrice,
        this.rentalDuration,
    });

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        isFree: json["is_free"],
        isRental: json["is_rental"],
        rentalPrice: json["rental_price"],
        rentalDuration: json["rental_duration"],
    );
}