import 'package:shared_preferences/shared_preferences.dart';
import 'package:flixoo_flutter_app/controllers/auth/auth_controller.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/common/sp_controller.dart';
import 'package:flixoo_flutter_app/controllers/payment/payment_controller.dart';
import 'package:flixoo_flutter_app/services/api_services.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import '../home/home_controller.dart';
import '../profile/profile_controller.dart';

class SplashScreenController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();

  @override
  Future<void> onInit() async {
    await getRemember();
    await Get.find<HomeController>().getHomePage();
    startSplashScreen();
    // await Get.find<HomeController>().getLocalAds();
    await globalController.getConfig();
    String? token = await spController.getBearerToken();
    if(token!=null){
    await Get.find<PaymentController>().getSubscriptionCheck();
    await Get.find<ProfileController>().getPlaylistList();
    await Get.find<HomeController>().getWatchHistory();
    }
    super.onInit();
  }

  bool rememberStatus = false;
  // String token = "";
  Future<void> getRemember() async {
    bool? state = await spController.getRememberMe();
    // String? token2 = await spController.getBearerToken();
    globalController.userFirstName.value = await spController.getUserFirstName() ?? "";
    globalController.userLastName.value = await spController.getUserLastName() ?? "";
    globalController.userEmail.value = await spController.getUserEmail() ?? "";
    globalController.userImage.value = await spController.getUserImage() ?? "";
    globalController.userId.value = await spController.getUserId() ?? -1;
    globalController.userToken.value = await spController.getBearerToken() ?? "";
    globalController.userPhone.value = await spController.getUserPhoneNumber() ?? "";
    globalController.userGender.value = await spController.getUserGender() ?? "";
    globalController.currency.value = await spController.getCurrency() ?? "";
    globalController.generalNotificationState.value = await spController.getGeneralNotificationState() ?? true;
    globalController.newReleaseState.value = await spController.getNewReleaseState() ?? true;
    globalController.paymentNotificationState.value = await spController.getPaymentNotificationState() ?? true;
    globalController.appUpdateState.value = await spController.getAppUpdateState() ?? true;
    globalController.subscriptionState.value = await spController.getSubscriptionState() ?? true;
    globalController.wifiOnlyState.value = await spController.getWifiOnlyState() ?? true;
    globalController.subscribedUserCheck.value = await spController.getSubscribedUser() ?? false;
    if (state == null || state == false) {
      rememberStatus = false;
    } else {
      rememberStatus = true;
    }
  }

  Timer startSplashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () async {
        if (globalController.userToken.value != "") {
          Get.offAndToNamed(krHomeScreen);
          Get.put<HomeController>(HomeController());
          Get.put<ProfileController>(ProfileController());
        } else {
          if (rememberStatus == false) {
            Get.find<AuthController>().emailTextEditingController.text = "";
            Get.find<AuthController>().passwordTextEditingController.text = "";
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            //   Get.find<AuthenticationController>().canLogin.value = false;
            //   Get.find<AuthenticationController>().isStayLoggedInChecked.value = false;
          } else {
            Get.find<AuthController>().emailTextEditingController.text =
                await spController.getUserEmail() ?? "";
            Get.find<AuthController>().passwordTextEditingController.text =
                await spController.getUserPassword() ?? "";
            // authController.canLogin.value = true;
            // authController.isStayLoggedInChecked.value = true;
          }
          Get.offAllNamed(krHomeScreen);
        }
      },
    );
  }
}
