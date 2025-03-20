import 'dart:io';

import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
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
}