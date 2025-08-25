import 'package:flixoo_flutter_app/models/common/common_user_model.dart';

class ProfileModel {
    CommonUserModel user;

    ProfileModel({
        required this.user,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        user: CommonUserModel.fromJson(json["user"]),
    );
}
