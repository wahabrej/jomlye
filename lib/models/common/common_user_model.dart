
class CommonUserModel {
    final int? id;
    final String? email;
    final String? password;
    final dynamic username;
    final String? firstName;
    final String? lastName;
    final String? phone;
    final dynamic image;
    final dynamic dateOfBirth;
    final String? userType;
    final dynamic gender;
    final dynamic token;
    final String? theme;
    final String? themeColor;
    final dynamic joinDate;
    final dynamic deactivateReason;
    final dynamic firebaseAuthUid;
    final String? permissions;
    final dynamic interests;
    final dynamic lastLogin;
    final int? isUserBanned;
    final int? isPasswordSet;
    final dynamic socials;
    final int? status;
    final int? roleId;
    final dynamic subscriptionId;
    final dynamic rememberToken;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    CommonUserModel({
        this.id,
        this.email,
        this.password,
        this.username,
        this.firstName,
        this.lastName,
        this.phone,
        this.image,
        this.dateOfBirth,
        this.userType,
        this.gender,
        this.token,
        this.theme,
        this.themeColor,
        this.joinDate,
        this.deactivateReason,
        this.firebaseAuthUid,
        this.permissions,
        this.interests,
        this.lastLogin,
        this.isUserBanned,
        this.isPasswordSet,
        this.socials,
        this.status,
        this.roleId,
        this.subscriptionId,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
    });

    factory CommonUserModel.fromJson(Map<String, dynamic> json) => CommonUserModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        image: json["image"],
        dateOfBirth: json["date_of_birth"],
        userType: json["user_type"],
        gender: json["gender"],
        token: json["token"],
        theme: json["theme"],
        themeColor: json["theme_color"],
        joinDate: json["join_date"],
        deactivateReason: json["deactivate_reason"],
        firebaseAuthUid: json["firebase_auth_uid"],
        permissions: json["permissions"],
        interests: json["interests"],
        lastLogin: json["last_login"],
        isUserBanned: json["is_user_banned"],
        isPasswordSet: json["is_password_set"],
        socials: json["socials"],
        status: json["status"],
        roleId: json["role_id"],
        subscriptionId: json["subscription_id"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );
}