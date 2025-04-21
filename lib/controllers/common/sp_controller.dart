import 'package:shared_preferences/shared_preferences.dart';

const kBearerToken = 'kBearerToken';
const kRememberMe = "kRememberMe";
const kUserId = 'kUserId';
const kUserImage = "kUserImage";
const kUserEmail = "kUserEmail";
const kFirstName = "kFirstName";
const kLastName = "kLastName";

class SpController {
  //* save Bearer Token
  Future<void> saveBearerToken(token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kBearerToken, token.toString());
  }

  Future<String?> getBearerToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kBearerToken);
  }

  //* Remember me status
  Future<void> saveRememberMe(value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(kRememberMe, value);
  }

  Future<bool?> getRememberMe() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(kRememberMe);
  }

    //* save user id
  Future<void> saveUserId(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(kUserId, id);
  }

  Future<int?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(kUserId);
  }

    //* save user Image
  Future<void> saveUserImage(imageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserImage, imageUrl.toString());
  }

  Future<String?> getUserImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserImage);
  }

  //* save user email
  Future<void> saveUserEmail(email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kUserEmail, email.toString());
  }

  Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kUserEmail);
  }
  //* save user first name
  Future<void> saveUserFirstName(firstName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kFirstName, firstName.toString());
  }

  Future<String?> getUserFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kFirstName);
  }
    //* save user first name
  Future<void> saveUserLastName(lastName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(kLastName, lastName.toString());
  }

  Future<String?> getUserLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(kLastName);
  }


   //* on logout
  Future<void> onLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(kBearerToken);
  }
}