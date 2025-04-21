import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/models/auth/login_model.dart';
import 'package:vidflix_flutter_app/models/common/common_data_model.dart';
import 'package:vidflix_flutter_app/models/common/common_error_model.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/utils/constants/urls.dart';

class AuthController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();
  final RxBool isLoginLoading = RxBool(false);
  //signin
    final TextEditingController emailTextEditingController = TextEditingController();
    final TextEditingController passwordTextEditingController = TextEditingController();
    final TextEditingController forgotEmailTextEditingController = TextEditingController();
    final TextEditingController phoneNumberTextEditingController = TextEditingController();
    //*sign up
    final TextEditingController firstNameTextEditingController = TextEditingController();
    final TextEditingController lastNameTextEditingController = TextEditingController();
    final TextEditingController userNameTextEditingController = TextEditingController();
    final TextEditingController confirmPasswordTextEditingController = TextEditingController();

    //*otp
      final TextEditingController otpTextEditingController = TextEditingController();

   //* Create new password
    final TextEditingController newPasswordTextEditingController = TextEditingController();
    final TextEditingController confirmNewPasswordTextEditingController = TextEditingController();



    final RxBool isPasswordShow = RxBool(false);
    final RxBool isConfirmPasswordShow = RxBool(false);
    final RxBool isRememberMe = RxBool(false);

    void resetAuth(){
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
     Future<void> userLogin() async {
    try {
      isLoginLoading.value = true;
      Map<String, dynamic> body = {
        'email': emailTextEditingController.text.trim().toString(),
        "password": passwordTextEditingController.text.toString(),
      };
      ll("body : $body");
      var response = await apiServices.commonApiCall(
        url: kuLogin,
        body: body,
        requestMethod: kPost,
      ) as CommonDM;

      if (response.code == 200) {
        ll("Login success");

         Get.offAllNamed(krHomeScreen);
        // isStayLoggedInChecked.value = false;
      }
      else {
         ll("Login failed");
        showSnackBar(
            title: ksError.tr, message: "Login Error!", color: cPrimaryColor2);
      }
    } catch (e) {
      ll("Login catch");
      isLoginLoading.value = false;
      ll('userLogin error: $e');
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

      if (response.code == 200) {
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
          showSnackBar(title: ksError.tr, message: response.message.toString(), color: cPrimaryColor2);
        } else {
          showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cPrimaryColor2);
        }
      }
    } catch (e) {
      isProfileLoading.value = false;
      ll('profile error: $e');
    }
  }
  final RxList<Map<String,dynamic>> interestList = RxList([
    {"name": "Horror","id":1},
    {"name": "Horror","id":2},
    {"name": "Horror","id":3},
    {"name": "Drama","id":4},
    {"name": "Drama","id":5},
    {"name": "Drama","id":6},
    {"name": "War","id":7},
    {"name": "War","id":8},
    {"name": "War","id":9},
    {"name": "Western","id":10},
    {"name": "Western","id":11},
    {"name": "Western","id":12},
    {"name": "Indian","id":13},
    {"name": "Indian","id":14},
    {"name": "Indian","id":15},
    {"name": "Music","id":16},
    {"name": "Music","id":17},
    {"name": "Music","id":18},
    {"name": "Thriller","id":19},
    {"name": "Thriller","id":20},
    {"name": "Thriller","id":21},
    {"name": "Animation","id":22},
    {"name": "Animation","id":23},
    {"name": "Animation","id":24},
    {"name": "Animation","id":25},
    {"name": "Animation","id":26},
    {"name": "Animation","id":27},
    {"name": "Animation","id":28},
    {"name": "Animation","id":29},
    // "Horror",
    // "Horror",
    // "Drama",
    // "Drama",
    // "Drama",
    // "War",
    // "War",
    // "War",
    // "Western",
    // "Western",
    // "Western",
    // "Indian",
    // "Indian",
    // "Indian",
    // "Music",
    // "Music",
    // "Music",
    // "Thriller",
    // "Thriller",
    // "Thriller",
    // "Animation",
    // "Animation",
    // "Animation",
    // "Animation",
    // "Animation",
    // "Animation",
    // "Animation",
    // "Animation",
  ]);
  final RxList selectedInterestList = RxList([]);
  final RxList selectedInterestIdList = RxList([]);
}
