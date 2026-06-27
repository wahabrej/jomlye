// =============================================
// FILE: lib/models/subtitle_model.dart
// =============================================

class SubtitleModel {
  final int? id;
  final String? label;
  final String? fileUrl;
  final String? language;

  SubtitleModel({
    this.id,
    this.label,
    this.fileUrl,
    this.language,
  });

  factory SubtitleModel.fromJson(Map<String, dynamic> json) => SubtitleModel(
    id: json["id"],
    label: json["label"],
    fileUrl: json["file_url"],
    language: json["language_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "file_url": fileUrl,
    "language_code": language,
  };
}

// =============================================
// movie_details_model.dart এ এই changes করুন:
// =============================================
//
// 1. Import করুন:
//    import 'subtitle_model.dart';
//
// 2. MovieDetailsModel class এ field যোগ করুন:
//    final List<SubtitleModel>? subtitles;
//
// 3. Constructor এ যোগ করুন:
//    this.subtitles,
//
// 4. fromJson এ যোগ করুন:
//    subtitles: json["subtitles"] == null
//        ? []
//        : List<SubtitleModel>.from(
//            json["subtitles"]!.map((x) => SubtitleModel.fromJson(x))),
// =============================================