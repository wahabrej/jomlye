import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/models/auth/interest_model.dart';
import 'package:vidflix_flutter_app/models/auth/login_model.dart';
import 'package:vidflix_flutter_app/models/common/common_data_model.dart';
import 'package:vidflix_flutter_app/models/common/common_error_model.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/utils/constants/urls.dart';

class AuthController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  final GlobalController globalController = Get.find<GlobalController>();
  //signin
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController forgotEmailTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  //*sign up
  final TextEditingController firstNameTextEditingController =
      TextEditingController();
  final TextEditingController lastNameTextEditingController =
      TextEditingController();
  final TextEditingController userNameTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  //*otp
  final TextEditingController otpTextEditingController =
      TextEditingController();

  //* Create new password
  final TextEditingController newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController confirmNewPasswordTextEditingController =
      TextEditingController();

  final RxBool isPasswordShow = RxBool(false);
  final RxBool isConfirmPasswordShow = RxBool(false);
  final RxBool isRememberMe = RxBool(false);

  void resetAuth() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    forgotEmailTextEditingController.clear();
    phoneNumberTextEditingController.clear();
    firstNameTextEditingController.clear();
    lastNameTextEditingController.clear();
    userNameTextEditingController.clear();
    confirmPasswordTextEditingController.clear();
    isPasswordShow.value = false;
    isConfirmPasswordShow.value = false;
    isRememberMe.value = false;
    selectedInterestIdList.clear();
    selectedInterestList.clear();
  }

  //sign in
  Future<void> signIn() async {
    try {
      Map<String, dynamic> body = {
        'email': emailTextEditingController.text.trim().toString(),
        "password": passwordTextEditingController.text.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuSignIn,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        SignInModel loginData = SignInModel.fromJson(response.data);
        await spController.saveBearerToken(loginData.token);
        await spController.saveRememberMe(isRememberMe.value);
        await spController.saveUserId(loginData.user!.id);
        await spController.saveUserImage(loginData.user!.image);
        await spController.saveUserEmail(loginData.user!.email);
        await spController.saveUserFirstName(loginData.user!.firstName);
        await spController.saveUserLastName(loginData.user!.lastName);
        await spController.saveUserPhoneNumber(loginData.user!.phone);
        Get.offAllNamed(krHomeScreen);
        globalController.userFirstName.value =
            await spController.getUserFirstName() ?? "";
        globalController.userLastName.value =
            await spController.getUserLastName() ?? "";
        globalController.userEmail.value =
            await spController.getUserEmail() ?? "";
        globalController.userImage.value =
            await spController.getUserImage() ?? "";
        globalController.userId.value = await spController.getUserId() ?? -1;
        globalController.userToken.value =
            await spController.getBearerToken() ?? "";
        globalController.userPhone.value =
            await spController.getUserPhoneNumber() ?? "";
      } else {
        showSnackBar(
            title: ksError.tr, message: "signIn Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('signIn error: $e');
    }
  }

//sign up
  Future<void> signUp() async {
    try {
      Map<String, dynamic> body = {
        "first_name": firstNameTextEditingController.text.trim().toString(),
        "last_name": lastNameTextEditingController.text.trim().toString(),
        "username": userNameTextEditingController.text.trim().toString(),
        "email": emailTextEditingController.text.trim().toString(),
        "password": passwordTextEditingController.text.trim().toString(),
        "confirm_password":
            confirmPasswordTextEditingController.text.trim().toString(),
        "user_type": "user",
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuSignUp,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        Get.toNamed(krChooseInterestScreen);
      } else {
        showSnackBar(
            title: ksError.tr, message: "signUp Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll('signUp error: $e');
    }
  }

  // LoginModel loginData = LoginModel.fromJson(response.data);
  // await spController.saveBearerToken(loginData.token);
  // await spController.saveRememberMe(isStayLoggedInChecked.value);
  // await spController.saveUserName(loginData.name.toString());
  // await spController.saveLocation(loginData.location.toString());
  // await spController.saveUserImage(loginData.profileImage.toString());
  // await spController.saveUserEmail(loginData.email.toString());
  // await spController.saveUserPassword(passwordTextEditingController.text.toString());
  // await spController.saveUserPhone(loginData.phone.toString());
  // await spController.saveUserId(loginData.id);
  // bool? isRememberMe = await spController.getRememberMe();
  // final RxBool isProfileLoading = RxBool(false);
  // Future<void> getProfile() async {
  //   try {
  //     isProfileLoading.value = true;
  //     String? token = await spController.getBearerToken();
  //     Map<String, dynamic> body = {};
  //     var response = await apiServices.commonApiCall(
  //       requestMethod: get,
  //       token: token,
  //       url: "profile", //!kuProfile(url here)
  //       body: body,
  //     ) as CommonDM;

  //     if (response.code == 200) {
  //       isProfileLoading.value = false;
  //     } else {
  //       ErrorModel errorModel = ErrorModel.fromJson(response.data);
  //       isProfileLoading.value = false;
  //       if (errorModel.errors.isEmpty) {
  //         showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
  //       } else {
  //         showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
  //       }
  //     }
  //   } catch (e) {
  //     isProfileLoading.value = false;
  //     ll('profile error: $e');
  //   }
  // }
  final RxBool isInterestLoading = RxBool(false);
  final RxList interestList = RxList([]);
  Future<void> getInterestList() async {
    try {
      isInterestLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {};
      var response = await apiServices.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuInterest,
        body: body,
      ) as CommonDM;

      if (response.code == 200) {
        InterestListModel inetrestListModel =
            InterestListModel.fromJson(response.data);
        interestList.clear();
        interestList.addAll(inetrestListModel.interests!);
        isInterestLoading.value = false;
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        isInterestLoading.value = false;
        if (errorModel.errors.isEmpty) {
          showSnackBar(
              title: ksError.tr,
              message: response.message.toString(),
              color: cPrimaryColor2);
        } else {
          showSnackBar(
              title: ksError.tr,
              message: errorModel.errors[0].message,
              color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isInterestLoading.value = false;
      ll('getInterestList error: $e');
    }
  }

  // selectedInterestIdList
  Future<void> interestStore() async {
    try {
      Map<String, dynamic> body = {
        "email": "rokyh459@gmail.com", //!change it(its hard coded)
        for (int i = 0; i < selectedInterestIdList.length; i++)
          "interest_ids[$i]": "${selectedInterestIdList[i]}"
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuInterestStore,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        Get.toNamed(krHomeScreen);
      } else {
        showSnackBar(
            title: ksError.tr,
            message: "interestStore Error!",
            color: cPrimaryColor2);
      }
    } catch (e) {
      ll('interestStore error: $e');
    }
  }

    //! signOut
   void signOut()async{
          await SpController().onLogout();
        // resetLoginScreen();
        bool? isRememberMe = await spController.getRememberMe();
        ll("The remember me value is $isRememberMe");
        await spController.saveRememberMe(isRememberMe);
        if(isRememberMe==null || isRememberMe==false){
            emailTextEditingController.text = "";
            passwordTextEditingController.text = "";
            SharedPreferences preferences = await SharedPreferences.getInstance();
            // canLogin.value = false;
            // Get.find<AuthenticationController>().isStayLoggedInChecked.value = false;
            await preferences.clear();
          }
          else{
            emailTextEditingController.text = await spController.getUserEmail()??"";
            passwordTextEditingController.text = await spController.getUserPassword()??"";
            // canLogin.value = true;
            // isStayLoggedInChecked.value = true;
          }
        Get.offAllNamed(krSignInScreen);
  }
  final RxList selectedInterestList = RxList([]);
  final RxList selectedInterestIdList = RxList([]);
}
