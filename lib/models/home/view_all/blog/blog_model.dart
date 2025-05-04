class BlogModel {
    final Blogs? blogs;
    final Filter? filter;

    BlogModel({
        this.blogs,
        this.filter,
    });

    factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        blogs: json["blogs"] == null ? null : Blogs.fromJson(json["blogs"]),
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    );

}

class Blogs {
    final int? currentPage;
    final List<BlogData>? data;
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

    Blogs({
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

    factory Blogs.fromJson(Map<String, dynamic> json) => Blogs(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<BlogData>.from(json["data"]!.map((x) => BlogData.fromJson(x))),
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

class BlogData {
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

    BlogData({
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

    factory BlogData.fromJson(Map<String, dynamic> json) => BlogData(
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
    final List<Categories>? categories;
    final List<int>? year;

    Filter({
        this.categories,
        this.year,
    });

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        categories: json["categories"] == null ? [] : List<Categories>.from(json["categories"]!.map((x) => Categories.fromJson(x))),
        year: json["year"] == null ? [] : List<int>.from(json["year"]!.map((x) => x)),
    );
}

class Categories {
    final int? id;
    final String? videoType;
    final String? videoTypeDesc;
    final int? primaryMenu;
    final int? footerMenu;
    final int? thumbnailStyle;
    final int? order;
    final String? slug;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Categories({
        this.id,
        this.videoType,
        this.videoTypeDesc,
        this.primaryMenu,
        this.footerMenu,
        this.thumbnailStyle,
        this.order,
        this.slug,
        this.createdAt,
        this.updatedAt,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        videoType: json["video_type"],
        videoTypeDesc: json["video_type_desc"],
        primaryMenu: json["primary_menu"],
        footerMenu: json["footer_menu"],
        thumbnailStyle: json["thumbnail_style"],
        order: json["order"],
        slug: json["slug"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}
