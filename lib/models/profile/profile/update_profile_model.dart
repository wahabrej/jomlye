
import 'package:flixoo_flutter_app/models/common/common_user_model.dart';

class UpdateProfileModel {
    final CommonUserModel? details;

    UpdateProfileModel({
        this.details,
    });

    factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
        details: json["details"] == null ? null : CommonUserModel.fromJson(json["details"]),
    );
}
