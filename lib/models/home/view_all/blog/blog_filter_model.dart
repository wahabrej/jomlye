import 'package:vidflix_flutter_app/models/home/view_all/blog/blog_model.dart';

class FilterBlogModel {
    final List<Blog>? details;

    FilterBlogModel({
        this.details,
    });

    factory FilterBlogModel.fromJson(Map<String, dynamic> json) => FilterBlogModel(
        details: json["details"] == null ? [] : List<Blog>.from(json["details"]!.map((x) => Blog.fromJson(x))),
    );
}

// class FilteredBlogDetail {
//     final int? id;
//     final String? title;
//     final String? slug;
//     final dynamic description;
//     final int? categoryId;
//     final String? image;
//     final String? seoTitle;
//     final String? metaDescription;
//     final String? focusKeyword;
//     final String? tags;
//     final int? status;
//     final int? isTop;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final String? author;

//     FilteredBlogDetail({
//         this.id,
//         this.title,
//         this.slug,
//         this.description,
//         this.categoryId,
//         this.image,
//         this.seoTitle,
//         this.metaDescription,
//         this.focusKeyword,
//         this.tags,
//         this.status,
//         this.isTop,
//         this.createdAt,
//         this.updatedAt,
//         this.author,
//     });

//     factory FilteredBlogDetail.fromJson(Map<String, dynamic> json) => FilteredBlogDetail(
//         id: json["id"],
//         title: json["title"],
//         slug: json["slug"],
//         description: json["description"],
//         categoryId: json["category_id"],
//         image: json["image"],
//         seoTitle: json["seo_title"],
//         metaDescription: json["meta_description"],
//         focusKeyword: json["focus_keyword"],
//         tags: json["tags"],
//         status: json["status"],
//         isTop: json["is_top"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         author: json["author"],
//     );
// }
