class PlayListModel {
    final List<PlayList>? playLists;

    PlayListModel({
        this.playLists,
    });

    factory PlayListModel.fromJson(Map<String, dynamic> json) => PlayListModel(
        playLists: json["play_lists"] == null ? [] : List<PlayList>.from(json["play_lists"]!.map((x) => PlayList.fromJson(x))),
    );
}

class PlayList {
    final int? id;
    final int? userId;
    final String? name;
    final int? isPrivate;
    final dynamic thumbnail;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? totalVideo;

    PlayList({
        this.id,
        this.userId,
        this.name,
        this.isPrivate,
        this.thumbnail,
        this.createdAt,
        this.updatedAt,
        this.totalVideo,
    });

    factory PlayList.fromJson(Map<String, dynamic> json) => PlayList(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        isPrivate: json["is_private"],
        thumbnail: json["thumbnail"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        totalVideo: json["total_video"],
    );
}
