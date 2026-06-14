import 'package:flixoo_flutter_app/models/common/common_user_model.dart';

class SignInModel {
    final String? token;
    final String? type;
    final CommonUserModel? user;

    SignInModel({
        this.token,
        this.type,
        this.user,
    });

    factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        token: json["token"],
        type: json["type"],
        user: json["user"] == null ? null : CommonUserModel.fromJson(json["user"]),
    );
}
