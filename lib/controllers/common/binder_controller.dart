import 'package:vidflix_flutter_app/controllers/auth/auth_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/controllers/payment/payment_controller.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/intro/splash_controller.dart';

class BinderController implements Bindings {
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController());
    Get.put<SplashScreenController>(SplashScreenController());
    Get.put<AuthController>(AuthController());
    Get.put<ProfileController>(ProfileController());
    Get.put<HomeController>(HomeController());
    Get.put<AllVideoPlayerController>(AllVideoPlayerController());
    Get.put<PaymentController>(PaymentController());
  }
}
