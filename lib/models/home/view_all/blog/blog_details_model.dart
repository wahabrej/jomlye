import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_model.dart';

class BlogDetailsModel {
    final Detailes? details;
    final Categories? category;
    final List<Detailes>? latestBlogs;

    BlogDetailsModel({
        this.details,
        this.category,
        this.latestBlogs,
    });

    factory BlogDetailsModel.fromJson(Map<String, dynamic> json) => BlogDetailsModel(
        details: json["details"] == null ? null : Detailes.fromJson(json["details"]),
        category: json["category"] == null ? null : Categories.fromJson(json["category"]),
        latestBlogs: json["latest_blogs"] == null ? [] : List<Detailes>.from(json["latest_blogs"]!.map((x) => Detailes.fromJson(x))),
    );
}
class Detailes {
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

    Detailes({
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

    factory Detailes.fromJson(Map<String, dynamic> json) => Detailes(
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