import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class ReviewListModel {
    final List<Review>? reviews;

    ReviewListModel({
        this.reviews,
    });

    factory ReviewListModel.fromJson(Map<String, dynamic> json) => ReviewListModel(
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    );
}

class Review {
    final int? id;
    final String? review;
    final int? rating;
    final String? createdAt;
    final String? updatedAt;
    final User? user;
    final RxInt? totalLikes;
    final RxBool? isLiked;

    Review({
        this.id,
        this.review,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.totalLikes,
        this.isLiked,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        review: json["review"],
        rating: json["rating"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        totalLikes: RxInt(json["total_likes"]),
        isLiked: RxBool(json["is_liked"]),
    );
}

class User {
    final int? id;
    final String? userName;
    final String? email;
    final String? profileImage;

    User({
        this.id,
        this.userName,
        this.email,
        this.profileImage,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["user_name"],
        email: json["email"],
        profileImage: json["profile_image"],
    );
}
