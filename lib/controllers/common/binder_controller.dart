import 'package:vidflix_flutter_app/controllers/auth/auth_controller.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/intro/splash_controller.dart';

class BinderController implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
    Get.put<GlobalController>(GlobalController());
    Get.put<AuthController>(AuthController());
    Get.put<ProfileController>(ProfileController());
  }
}
