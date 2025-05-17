import 'package:vidflix_flutter_app/models/common/common_user_model.dart';
class CommonLoginUserModel {
    final CommonUserModel? user;
    final String? token;

    CommonLoginUserModel({
        this.user,
        this.token,
    });

    factory CommonLoginUserModel.fromJson(Map<String, dynamic> json) => CommonLoginUserModel(
        user: json["user"] == null ? null : CommonUserModel.fromJson(json["user"]),
        token: json["token"],
    );
}
