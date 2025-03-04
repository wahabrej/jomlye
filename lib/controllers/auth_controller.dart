import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/models/common/common_data_model.dart';
import 'package:vidflix_flutter_app/models/common/common_error_model.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class AuthController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  final RxBool isLoginLoading = RxBool(false);
  Future<void> userLogin() async {
    final TextEditingController emailTextEditingController = TextEditingController();
    final TextEditingController passwordTextEditingController = TextEditingController();
    try {
      isLoginLoading.value = true;
      Map<String, dynamic> body = {
        'email': emailTextEditingController.text.trim().toString(),
        "password": passwordTextEditingController.text.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: 'login url', //!change it
        body: body,
        requestMethod: post,
      ) as CommonDM;

      if (response.success == true) {
        // LoginModel loginData = LoginModel.fromJson(response.data);

        isLoginLoading.value = false;
        // Get.offAllNamed(krHomeScreen);//!needed
      }
      //  else {
      //   if (response.code == 410) {
      //     // CommonUnVerifyModel commonUnVerifyModel = CommonUnVerifyModel.fromJson(response.data);
      //     // verificationToken.value = commonUnVerifyModel.token.toString();
      //     // parentRoute.value = "login";
      //     // resetOTPScreen();
      //     isLoginLoading.value = false;
      //     // Get.toNamed(krOTP);
      //     showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
      //   } else {
      //     ErrorModel errorModel = ErrorModel.fromJson(response.data);
      //     isLoginLoading.value = false;
      //     if (errorModel.errors.isEmpty) {
      //       showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
      //     }
      else {
        showSnackBar(title: ksError.tr, message: "Login Error!", color: cRedColor);
      }
    } catch (e) {
      isLoginLoading.value = false;
      ll('userLogin error: $e');
    }
  }

  final RxBool isProfileLoading = RxBool(false);
  Future<void> getProfile() async {
    try {
      isProfileLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: get,
        token: token,
        url: "profile", //!kuProfile(url here)
        body: body,
      ) as CommonDM;

      if (response.success == true) {
        // profileModel.value = ProfileModel.fromJson(response.data);//!needed
        // await spController.saveUserName(profileModel.value?.name.toString());
        // await spController.saveLocation(profileModel.value?.address.toString());
        // await spController.saveUserImage(profileModel.value?.image.toString());
        // await spController.saveUserEmail(profileModel.value?.email.toString());
        // await spController.saveUserPhone(profileModel.value?.phone.toString());
        // firstNameController.text = profileModel.value?.firstName.toString() ?? "";
        // lastNameTextEditingController.text = profileModel.value?.lastName.toString() ?? "";
        // phoneTextEditingController.text = profileModel.value?.phone.toString() ?? "";
        // locationTextEditingController.text = profileModel.value?.address.toString() ?? "";
        // emailTextEditingController.text = profileModel.value?.email.toString() ?? "";
        isProfileLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isProfileLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cRedColor);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isProfileLoading.value = false;
      ll('profile error: $e');
    }
  }
}
