import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/screens/profile/common_webview_screen.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class ProfileController extends GetxController{
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  final TextEditingController fullNameTextEditingController = TextEditingController();
  final TextEditingController nickNameTextEditingController = TextEditingController();
  final TextEditingController phoneNumberTextEditingController = TextEditingController();
  final RxString selectedGender = RxString("");
  final RxList<String> genderList = RxList(["Male","Female"]);

    final RxBool isProfileImageChnaged = RxBool(false);
  final RxString profileImageLink = RxString("");
  final Rx<File?> profileImageFile = Rx<File?>(null);
  final RxList languageList = RxList([
    "Bangla",
    "Hindi",
    "Chinese",
    "Russian",
    "Urdu",
    "German",
    "Spanish",
    "French",
    "Arabic",
    "Indonesian"
  ]);
  final RxList favoriteTvChannelList = RxList([
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0tieg_XmSWY4Er34er592OFueSzMT0OzWQA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSLPK5f26HCqYTxBDwVVj-6OttdrGCI2wuvQ&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrLhtv6ztC-4z0LOeNh-bvvlqcAmHPQf_iP2enwcFqzX3P1oDBIp8e06M&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrLhtv6ztC-4z0LOeNh-bvvlqcAmHPQf_iP2enwcFqzX3P1oDBIp8e06M&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrLhtv6ztC-4z0LOeNh-bvvlqcAmHPQf_iP2enwcFqzX3P1oDBIp8e06M&s"
  ]);
   final RxList<Map<String, dynamic>> moviesList =
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
  final RxList<Map<String,dynamic>> downloadedMovieList = RxList<Map<String,dynamic>>([
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "12GB",
    },
  ]);
  final RxList<Map<String,dynamic>> notificationMovieList = RxList<Map<String,dynamic>>([
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
    {
      "movieImage": "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
      "movieTagList": ["Action", "2024"],
      "movieName": "20-Minute Meals: Delicious Recipes.",
      "movieDuration": "Time duration: 1 hour 20 sec",
      "movieSize": "New Released",
    },
  ]);

late InAppWebViewController privacyWebViewController;
final RxBool privacyIsLoading = RxBool(false);
final String privacyPolicyUrl = "https://api.salebot.app/page/privacy-policy"; //!temporary url -> change it

  void openPrivacyPolicy() {
    Get.to(() => CommonWebViewScreen()); //titleText: ksPrivacyPolicy.tr,urlLink: privacyPolicyUrl,isLoading: privacyIsLoading.value,webViewController: privacyWebViewController,
  }
  final RxBool generalNotificationState = RxBool(false);
  final RxBool newReleaseState = RxBool(false);
  final RxBool paymentNotificationState = RxBool(false);
  final RxBool appUpdateState = RxBool(false);
  final RxBool subscriptionState = RxBool(false);
  final RxBool wifiOnlyState = RxBool(false);
  final RxList<Map<String,dynamic>> videoQualityList = RxList<Map<String,dynamic>>([
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
  final TextEditingController oldPasswordTextEditingController = TextEditingController();
  final TextEditingController newPasswordTextEditingController = TextEditingController();
  final TextEditingController confirmNewPasswordTextEditingController = TextEditingController();
  final RxBool isOldPasswordShow = RxBool(false);
  final RxBool isNewPasswordShow = RxBool(false);
  final RxBool isConfirmNewPasswordShow = RxBool(false);
}