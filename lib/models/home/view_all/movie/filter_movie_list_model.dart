import 'package:flixoo_flutter_app/models/home/view_all/movie/movie_list_model.dart';

class FilterMovieListModel {
    final Movies? movies;
    final Filter? filter;

    FilterMovieListModel({
        this.movies,
        this.filter,
    });

    factory FilterMovieListModel.fromJson(Map<String, dynamic> json) => FilterMovieListModel(
        movies: json["movies"] == null ? null : Movies.fromJson(json["movies"]),
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
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
    final dynamic nextPageUrl;
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
