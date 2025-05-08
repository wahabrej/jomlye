class ArtistModel {
    final Artists? artists;
    final Filter? filter;

    ArtistModel({
        this.artists,
        this.filter,
    });

    factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
        artists: json["artists"] == null ? null : Artists.fromJson(json["artists"]),
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    );
}

class Artists {
    final int? currentPage;
    final List<ArtistData>? data;
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

    Artists({
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

    factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ArtistData>.from(json["data"]!.map((x) => ArtistData.fromJson(x))),
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

class ArtistData {
    final int? id;
    final String? starName;
    final String? slug;
    final String? starType;
    final int? countryId;
    final DateTime? starDob;
    final String? ranking;
    final String? gender;
    final String? background;
    final int? totalMovies;
    final String? starImage;
    final String? starDesc;
    final int? view;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? countryName;
    final String? country;

    ArtistData({
        this.id,
        this.starName,
        this.slug,
        this.starType,
        this.countryId,
        this.starDob,
        this.ranking,
        this.gender,
        this.background,
        this.totalMovies,
        this.starImage,
        this.starDesc,
        this.view,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.countryName,
        this.country,
    });

    factory ArtistData.fromJson(Map<String, dynamic> json) => ArtistData(
        id: json["id"],
        starName: json["star_name"],
        slug: json["slug"],
        starType: json["star_type"],
        countryId: json["country_id"],
        starDob: json["star_dob"],
        ranking: json["ranking"],
        gender: json["gender"],
        background: json["background"],
        totalMovies: json["total_movies"],
        starImage: json["star_image"],
        starDesc: json["star_desc"],
        view: json["view"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        countryName: json["country_name"],
        country: json["country"],
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

class Filter {
    final List<ArtistCountry>? countries;
    final List<MovieIndustry>? movieIndustries;

    Filter({
        this.countries,
        this.movieIndustries,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        countries: json["countries"] == null ? [] : List<ArtistCountry>.from(json["countries"]!.map((x) => ArtistCountry.fromJson(x))),
        movieIndustries: json["movie_industries"] == null ? [] : List<MovieIndustry>.from(json["movie_industries"]!.map((x) => MovieIndustry.fromJson(x))),
    );
}

class ArtistCountry {
    final int? id;
    final String? name;
    final String? slug;
    final dynamic description;
    final dynamic flag;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    ArtistCountry({
        this.id,
        this.name,
        this.slug,
        this.description,
        this.flag,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory ArtistCountry.fromJson(Map<String, dynamic> json) => ArtistCountry(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        flag: json["flag"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

class MovieIndustry {
    final int? id;
    final String? name;
    final int? status;

    MovieIndustry({
        this.id,
        this.name,
        this.status,
    });

    factory MovieIndustry.fromJson(Map<String, dynamic> json) => MovieIndustry(
        id: json["id"],
        name: json["name"],
        status: json["status"],
    );
}