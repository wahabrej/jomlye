class BlogModel {
    final List<Blog>? blogs;
    final List<Categories>? categories;
    final List<int>? year;

    BlogModel({
        this.blogs,
        this.categories,
        this.year,
    });

    factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
        blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
        categories: json["categories"] == null ? [] : List<Categories>.from(json["categories"]!.map((x) => Categories.fromJson(x))),
        year: json["year"] == null ? [] : List<int>.from(json["year"]!.map((x) => x)),
    );
}

class Blog {
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

    Blog({
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

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
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
