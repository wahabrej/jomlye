import 'package:vidflix_flutter_app/models/home/view_all/artist/artist_model.dart';

class TvChannelListModel {
    final LiveTvs? liveTvs;
    final Filter? filter;

    TvChannelListModel({
        this.liveTvs,
        this.filter,
    });

    factory TvChannelListModel.fromJson(Map<String, dynamic> json) => TvChannelListModel(
        liveTvs: json["live_tvs"] == null ? null : LiveTvs.fromJson(json["live_tvs"]),
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    );
}

class Filter {
    final List<TvChannelCategory>? categories;
    final List<ArtistCountry>? country;

    Filter({
        this.categories,
        this.country,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        categories: json["categories"] == null ? [] : List<TvChannelCategory>.from(json["categories"]!.map((x) => TvChannelCategory.fromJson(x))),
        country: json["country"] == null ? [] : List<ArtistCountry>.from(json["country"]!.map((x) => ArtistCountry.fromJson(x))),
    );
}

class TvChannelCategory {
    final int? id;
    final String? liveTvCategory;
    final String? slug;
    final String? liveTvCategoryDesc;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    TvChannelCategory({
        this.id,
        this.liveTvCategory,
        this.slug,
        this.liveTvCategoryDesc,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory TvChannelCategory.fromJson(Map<String, dynamic> json) => TvChannelCategory(
        id: json["id"],
        liveTvCategory: json["live_tv_category"],
        slug: json["slug"],
        liveTvCategoryDesc: json["live_tv_category_desc"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}

class LiveTvs {
    final int? currentPage;
    final List<TvChannelData>? data;
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

    LiveTvs({
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

    factory LiveTvs.fromJson(Map<String, dynamic> json) => LiveTvs(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<TvChannelData>.from(json["data"]!.map((x) => TvChannelData.fromJson(x))),
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

class TvChannelData {
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

    TvChannelData({
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
        this.isPaid,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory TvChannelData.fromJson(Map<String, dynamic> json) => TvChannelData(
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
        isPaid: json["is_paid"],
        status: json["status"],
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
