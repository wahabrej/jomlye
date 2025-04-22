import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidflix_flutter_app/controllers/auth/auth_controller.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import '../home/home_controller.dart';
import '../profile/profile_controller.dart';

class SplashScreenController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();

  @override
  Future<void> onInit() async {
    await getRemember();
    startSplashScreen();
    super.onInit();
  }

  bool rememberStatus = false;
  // String token = "";
  Future<void> getRemember() async {
    bool? state = await spController.getRememberMe();
    // String? token2 = await spController.getBearerToken();
    globalController.userFirstName.value = await spController.getUserFirstName()??"";
    globalController.userLastName.value = await spController.getUserLastName()??"";
    globalController.userEmail.value = await spController.getUserEmail()??"";
    globalController.userImage.value = await spController.getUserImage()??"";
    globalController.userId.value = await spController.getUserId()??-1;
    globalController.userToken.value = await spController.getBearerToken()??"";
    if (state == null || state == false) {
      rememberStatus = false;
      ll("the remember status is $state");
    } else {
      rememberStatus = true;
      ll("the remember status is $state");
    }
  }

  Timer startSplashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () async {
        if (globalController.userToken.value!="") {
          Get.offAndToNamed(krHomeScreen);
          Get.put<HomeController>(HomeController());
          Get.put<ProfileController>(ProfileController());
        } else {
           if(rememberStatus==false){
           Get.find<AuthController>().emailTextEditingController.text = "";
           Get.find<AuthController>().passwordTextEditingController.text = "";
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();
          //   Get.find<AuthenticationController>().canLogin.value = false;
          //   Get.find<AuthenticationController>().isStayLoggedInChecked.value = false;
          }
          else{
            Get.find<AuthController>().emailTextEditingController.text = await spController.getUserEmail()??"";
            Get.find<AuthController>().passwordTextEditingController.text = await spController.getUserPassword()??"";
            // authController.canLogin.value = true;
            // authController.isStayLoggedInChecked.value = true;
          }
          Get.offAllNamed(krHomeScreen);
        }
      },
    );
  }
}
