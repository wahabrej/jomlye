import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/models/common/common_data_model.dart';
import 'package:vidflix_flutter_app/models/common/common_error_model.dart';
import 'package:vidflix_flutter_app/models/profile/faq/faq_model.dart';
import 'package:vidflix_flutter_app/models/profile/favorite/favorite_list_model.dart';
import 'package:vidflix_flutter_app/models/profile/playlist/playlist_model.dart';
import 'package:vidflix_flutter_app/models/profile/playlist/playlist_movie_list_model.dart';
import 'package:vidflix_flutter_app/models/profile/profile/update_profile_model.dart';
import 'package:vidflix_flutter_app/screens/profile/common_webview_screen.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/utils/constants/urls.dart';

class ProfileController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  final GlobalController globalController = Get.find<GlobalController>();
  final TextEditingController fullNameTextEditingController =
      TextEditingController();
  final RxString selectedGender = RxString("");
  final RxList<String> genderList = RxList(["Male", "Female"]);

  final RxBool isProfileImageChnaged = RxBool(false);
  final RxString profileImageLink = RxString("");
  final Rx<File?> profileImageFile = Rx<File?>(null);
  final RxList favoriteTvChannelList = RxList([
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0tieg_XmSWY4Er34er592OFueSzMT0OzWQA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSLPK5f26HCqYTxBDwVVj-6OttdrGCI2wuvQ&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrLhtv6ztC-4z0LOeNh-bvvlqcAmHPQf_iP2enwcFqzX3P1oDBIp8e06M&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrLhtv6ztC-4z0LOeNh-bvvlqcAmHPQf_iP2enwcFqzX3P1oDBIp8e06M&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrLhtv6ztC-4z0LOeNh-bvvlqcAmHPQf_iP2enwcFqzX3P1oDBIp8e06M&s"
  ]);
  final RxList<Map<String, dynamic>> moviesList = RxList<Map<String, dynamic>>([
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": true,
      "season": "Season 1"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": true,
      "season": "Season 2"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": false,
      "season": "Season 3",
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": false,
      "season": "Season 1",
    },
  ]);
  final RxList<Map<String, dynamic>> tvSeriesList =
      RxList<Map<String, dynamic>>([
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": true,
      "season": "Season 1"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": true,
      "season": "Season 2"
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": true,
      "isSeason": false,
      "season": "Season 3",
    },
    {
      "movieImage":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMgWX4g09aEYCNiwNF7yFNjLgvoThYfC4XgA&s",
      "isPremium": false,
      "isSeason": false,
      "season": "Season 1",
    },
  ]);
  final RxInt selectedPaymentMethodIndex = RxInt(-1);
  final RxList paymentMethodList = RxList([
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHU4tOI-bAL4XVfQSGS1phLDJNB3QaE7tQvAIy6SlhSzSQ48UhwbllHTCCRZHPQCZEWBE&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHU4tOI-bAL4XVfQSGS1phLDJNB3QaE7tQvAIy6SlhSzSQ48UhwbllHTCCRZHPQCZEWBE&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHU4tOI-bAL4XVfQSGS1phLDJNB3QaE7tQvAIy6SlhSzSQ48UhwbllHTCCRZHPQCZEWBE&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHU4tOI-bAL4XVfQSGS1phLDJNB3QaE7tQvAIy6SlhSzSQ48UhwbllHTCCRZHPQCZEWBE&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyCyJzFJkymecBHNfTCJtUKIb79dTP1NQhWp2cZdx24aeWvrnP2zukxtoX6PGGm59TaHQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyCyJzFJkymecBHNfTCJtUKIb79dTP1NQhWp2cZdx24aeWvrnP2zukxtoX6PGGm59TaHQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyCyJzFJkymecBHNfTCJtUKIb79dTP1NQhWp2cZdx24aeWvrnP2zukxtoX6PGGm59TaHQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyCyJzFJkymecBHNfTCJtUKIb79dTP1NQhWp2cZdx24aeWvrnP2zukxtoX6PGGm59TaHQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOyH__aIgH_qYVbGe-7z_9WHHuPZ0qzVqqZxjohk_QluzBPPBoKi1VrF5dV2cqiRIWc5Y&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOyH__aIgH_qYVbGe-7z_9WHHuPZ0qzVqqZxjohk_QluzBPPBoKi1VrF5dV2cqiRIWc5Y&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOyH__aIgH_qYVbGe-7z_9WHHuPZ0qzVqqZxjohk_QluzBPPBoKi1VrF5dV2cqiRIWc5Y&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOyH__aIgH_qYVbGe-7z_9WHHuPZ0qzVqqZxjohk_QluzBPPBoKi1VrF5dV2cqiRIWc5Y&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8V8uPFT10fPjw59627CgxWeBKWpaaGFLhowPOcO81UExqoLyCwvk9Zq757SbAPbLhA74&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8V8uPFT10fPjw59627CgxWeBKWpaaGFLhowPOcO81UExqoLyCwvk9Zq757SbAPbLhA74&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8V8uPFT10fPjw59627CgxWeBKWpaaGFLhowPOcO81UExqoLyCwvk9Zq757SbAPbLhA74&usqp=CAU",
  ]);
  final RxList movieTagList = RxList(["Action", "2024"]);
  final RxList<Map<String, dynamic>> downloadedMovieList =
      RxList<Map<String, dynamic>>([
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
  ]);
  final RxList<Map<String, dynamic>> notificationMovieList =
      RxList<Map<String, dynamic>>([
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage":
          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
  ]);

  late InAppWebViewController privacyWebViewController;
  final RxBool privacyIsLoading = RxBool(false);
  // final String privacyPolicyUrl =
  //     Get.find<GlobalController>().privacyPolicyUrl.value;
  // final String termsAndConditionUrl =
  //     Get.find<GlobalController>().termsAndConditionUrl.value;

  void openCommonWebView({required String commonUrl}) {
    Get.to(() =>
        CommonWebViewScreen(commonUrl: commonUrl,));
  }

  // final RxBool generalNotificationState = RxBool(false);
  // final RxBool newReleaseState = RxBool(false);
  // final RxBool paymentNotificationState = RxBool(false);
  // final RxBool appUpdateState = RxBool(false);
  // final RxBool subscriptionState = RxBool(false);
  final RxList<Map<String, dynamic>> videoQualityList =
      RxList<Map<String, dynamic>>([
    {
      "quality": "1080p",
      "state": true,
    },
    {
      "quality": "720p",
      "state": false,
    },
    {
      "quality": "440p",
      "state": false,
    },
    {
      "quality": "240p",
      "state": false,
    },
    {
      "quality": "144p",
      "state": false,
    },
  ]);
  final TextEditingController oldPasswordTextEditingController =
      TextEditingController();
  final TextEditingController newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController confirmNewPasswordTextEditingController =
      TextEditingController();
  final RxBool isOldPasswordShow = RxBool(false);
  final RxBool isNewPasswordShow = RxBool(false);
  final RxBool isConfirmNewPasswordShow = RxBool(false);
  //!faq
  final RxInt selectedPaymentFaqIndex = RxInt(0);
  final RxInt selectedOrderFaqIndex = RxInt(0);
  // final TextEditingController fullNameTextEditingController2 = TextEditingController();
    final TextEditingController emailTextEditingController =
      TextEditingController();
    final TextEditingController subjectTextEditingController =
      TextEditingController();
    final TextEditingController messageTextEditingController =
      TextEditingController();
  //!profile update
  final TextEditingController firstNameTextEditingController = TextEditingController();
  final TextEditingController lastNameTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final RxString getUserImage = RxString("");
//sign up
final Rx<UpdateProfileModel?> updateProfileModel = Rx<UpdateProfileModel?>(null);
  Future<void> updateProfile() async {
    try {
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        "user_id": globalController.userId.value.toString(),
        "first_name": firstNameTextEditingController.text.trim().toString(),
        "last_name": lastNameTextEditingController.text.trim().toString(),
        "phone": phoneTextEditingController.text.trim().toString(),
        "email": emailTextEditingController.text.trim().toString(),
        "gender": selectedGender.value == "Male" ? "1" : "2" ,
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuUpdateProfile,
        body: body,
        requestMethod: kPost,
        token: token,
      ) as CommonDM;

      if (response.code == 200) {
        updateProfileModel.value = UpdateProfileModel.fromJson(response.data);
        await spController.saveUserImage(updateProfileModel.value?.details?.image);
        await spController.saveUserEmail(updateProfileModel.value?.details?.email);
        await spController.saveUserFirstName(updateProfileModel.value?.details?.firstName);
        await spController.saveUserLastName(updateProfileModel.value?.details?.lastName);
        await spController.saveUserPhoneNumber(updateProfileModel.value?.details?.phone);
        await spController.saveUserGender(updateProfileModel.value?.details?.gender);
        globalController.userFirstName.value =
            await spController.getUserFirstName() ?? "";
         globalController.userLastName.value =
            await spController.getUserLastName() ?? "";
         globalController.userEmail.value =
            await spController.getUserEmail() ?? "";
         globalController.userImage.value =
            await spController.getUserImage() ?? "";
         globalController.userPhone.value =
            await spController.getUserPhoneNumber() ?? "";
         globalController.userGender.value =
            await spController.getUserGender() ?? "";
         globalController.userGender.value =
            await spController.getUserGender() ?? "";
        Get.back();
      } else {
        showSnackBar(
            title: ksError.tr, message: "signUp Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('updateProfile error: $e');
    }
  }
  
//change Password
  resetPassword(){
      oldPasswordTextEditingController.clear();
      newPasswordTextEditingController.clear();
      confirmNewPasswordTextEditingController.clear();
  }
  Future<void> changePassword() async {
    try {
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        "old_password": oldPasswordTextEditingController.text.trim().toString(),
        "new_password": newPasswordTextEditingController.text.trim().toString(),
        "confirm_password": confirmNewPasswordTextEditingController.text.trim().toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuChangePassword,
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        Get.back();
       resetPassword();
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "signUp Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('changePassword error: $e');
    }
  }
  //!Playlist
  final RxString selectedPlayListValue = RxString("");
  final RxList<Map<String,dynamic>> playListValueList = RxList([
    {
    "icon": Icons.edit,
    "title": ksEdit.tr,
  },
    {
    "icon": Icons.delete,
    "title": ksDelete.tr,
  }
  ]);

   final RxBool isPlayListLoading = RxBool(false);
   final Rx<PlayListModel?> playListModel = Rx<PlayListModel?>(null);
  final RxList<PlayList> playlistList = RxList<PlayList>([]);
  Future<void> getPlaylistList() async {
    try {
      isPlayListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuPlayList,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        playlistList.clear();
        PlayListModel playListModel = PlayListModel.fromJson(response.data);
        playlistList.addAll(playListModel.playLists!);
        isPlayListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isPlayListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          // showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          // showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isPlayListLoading.value = false;
      ll('getPlaylistList error: $e');
    }
  }
 final RxInt selectedPlayListId = RxInt(-1);
 final TextEditingController editPlayListTextEditingController = TextEditingController();
  Future<void> editPlaylist() async {
    // final int userId = await spController.getUserId()??-1;
    try {
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        "name": editPlayListTextEditingController.text.trim().toString(),
        // "user_id": userId.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: "$kuUpdatePlaylist/${selectedPlayListId.value.toString()}",
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "editPlayList Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('editPlayList error: $e');
    }
  }

    Future<void> deletePlaylist() async {
    try {
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: "$kuDeletePlaylist/${selectedPlayListId.value.toString()}",
        body: body,
        token: token,
        requestMethod: kDelete,
      ) as CommonDM;
      if (response.code == 200) {
        for(int i=0;i<playlistList.length;i++){
          if(selectedPlayListId.value == playlistList[i].id){
            playlistList.remove(playlistList[i]);
          }
        }
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "deletePlaylist Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('deletePlaylist error: $e');
    }
  }
  final RxBool isPlaylistMovieListLoading = RxBool(false);
  final Rx<PlaylistMovieListModel?> playlistMovieListModel = Rx<PlaylistMovieListModel?>(null);
  final Rx<PlaylistDetails?> playlistDetailsData = Rx<PlaylistDetails?>(null);
  final RxList<PlayListMovie> playlistMovieList = RxList<PlayListMovie>([]);
  Future<void> getPlaylisMovieList({required int playListId}) async {
    try {
      isPlaylistMovieListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: "$kuPlaylistMovies/${playListId.toString()}",
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        playlistMovieList.clear();
        PlaylistMovieListModel playlistMovieListModel = PlaylistMovieListModel.fromJson(response.data);
        playlistDetailsData.value = playlistMovieListModel.playlistDetails;
        playlistMovieList.addAll(playlistMovieListModel.playListMovies!);
        isPlaylistMovieListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isPlaylistMovieListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isPlaylistMovieListLoading.value = false;
      ll('getPlaylistList error: $e');
    }
  }

   Future<void> deletePlaylistMovie({required int movieId}) async {
    try {
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        "playlist_id": selectedPlayListId.value.toString(),
        "movie_id": movieId.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuDeletePlaylistMovie,
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        await getPlaylisMovieList(playListId: selectedPlayListId.value);
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "deletePlaylistMovie Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('deletePlaylistMovie error: $e');
    }
  }

     Future<void> createPlayList() async {
    try {
      String? token = await spController.getBearerToken();
      // int? userId = await spController.getUserId();
      Map<String, dynamic> body = {
        "name": createPlaylistTextEditingController.text.trim().toString(),
        // "user_id": userId.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuCreatePlaylist,
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "createPlayList Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('createPlayList error: $e');
    }
  }

  final RxList moviePlayListIds = RxList([]); 
     Future<void> playlistAddMovie({required int movieId,}) async {
    try {
      String? token = await spController.getBearerToken();
      // int? userId = await spController.getUserId();
      Map<String, dynamic> body = {
        "movie_id": movieId.toString(),
        for(int i=0;i<moviePlayListIds.length;i++) "playlist_ids[$i]": moviePlayListIds[i].toString(), 
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuPlaylistAddMovie,
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "createPlayList Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('createPlayList error: $e');
    }
  }

  final TextEditingController addCommentTextEditingController = TextEditingController();
  final TextEditingController createPlaylistTextEditingController = TextEditingController();
  // final RxList<Map<String,dynamic>> temporaryPlayListList = RxList<Map<String,dynamic>>([]);  
  final RxList<bool> temporaryPlayListCheckBoxStateList = RxList<bool>([]);  
  final RxList<int> temporaryPlaylistIdList = RxList<int>([]);  

 //! Contact Us
     Future<void> contactUs() async {
    try {
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
       "name": fullNameTextEditingController.text.trim().toString(),
       "email": emailTextEditingController.text.trim().toString(),
       "subject": subjectTextEditingController.text.trim().toString(),
       "message": messageTextEditingController.text.trim().toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuContactUs,
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        fullNameTextEditingController.clear();
        emailTextEditingController.clear();
        subjectTextEditingController.clear();
        messageTextEditingController.clear();
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "contactUs Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('contactUs error: $e');
    }
  }
  //!favorite
  final RxBool isFavoriteAdded = RxBool(false);
   final RxBool isfavoriteListLoading = RxBool(false);
   final Rx<FavoriteListModel?> favoriteListModel = Rx<FavoriteListModel?>(null);
  final RxList<FavoriteMovie> favoriteMovieList = RxList<FavoriteMovie>([]);
  Future<void> getFavoriteList() async {
    try {
      isfavoriteListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuFavoriteList,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        favoriteMovieList.clear();
        FavoriteListModel favoriteListModel = FavoriteListModel.fromJson(response.data);
        favoriteMovieList.addAll(favoriteListModel.movies!);
        isfavoriteListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isfavoriteListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isfavoriteListLoading.value = false;
      ll('getFavoriteList error: $e');
    }
  }

  
    Future<void> favoriteAddOrRemove({required int id,required String type}) async {
    try {
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
       "type": type.toString(),
       "id": id.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuFavoriteAddOrRemove,
        body: body,
        token: token,
        requestMethod: kPost,
      ) as CommonDM;
      if (response.code == 200) {
        showSnackBar(title: "Success", message: response.message??"", color: cGreenColor);
      } else {
        showSnackBar(
            title: ksError.tr, message: "favoriteAddOrRemove Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('favoriteAddOrRemove error: $e');
    }
  }

  //!Faq

  final RxBool isFaqListLoading = RxBool(false);
  final Rx<FaqModel?> faqModel = Rx<FaqModel?>(null); 
  final RxList<Order?> paymentFaqList = RxList<Order?>([]);
  final RxList<Order?> orderFaqList = RxList<Order?>([]);
  Future<void> getFaqList() async {
    try {
      isFaqListLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuFaqs,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        paymentFaqList.clear();
        orderFaqList.clear();
        faqModel.value = FaqModel.fromJson(response.data);
        paymentFaqList.addAll(faqModel.value!.payment!);
        orderFaqList.addAll(faqModel.value!.order!);
        isFaqListLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isFaqListLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isFaqListLoading.value = false;
      ll('getFaqList error: $e');
    }
  }




  //!##Lnaguage##
 static const String LANGUAGE_KEY = 'selected_language';
final RxString selectedLanguage = RxString("English");
  final RxInt selectedLanguageIndex = RxInt(0);
  final RxList languageList = RxList([
    "Bangla",
    "French",
    "Arabic",
  ]);

@override
void onInit() {
  super.onInit();
  loadSavedLanguage();
}

Future<void> loadSavedLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString(LANGUAGE_KEY);
  if (savedLanguage != null) {
    selectedLanguage.value = savedLanguage;
    await changeLanguage(savedLanguage);
  }
}

Future<void> changeLanguage(String language) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANGUAGE_KEY, language);
  
  switch (language) {
    case 'English':
    selectedLanguageIndex.value = 0;
      await Get.updateLocale(const Locale('en', 'US'));
      break;
    case 'Bangla':
    selectedLanguageIndex.value = 1;
      await Get.updateLocale(const Locale('bn', 'BD'));
      break;
    case 'French':
    selectedLanguageIndex.value = 2;
      await Get.updateLocale(const Locale('fr', 'FR'));
      break;
    case 'Arabic':
    selectedLanguageIndex.value = 3;
      await Get.updateLocale(const Locale('ar', 'SA'));
      break;
  }
  
  selectedLanguage.value = language;
}


}
