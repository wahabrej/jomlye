import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/views/splash/splash_screen.dart';

const String krSplashScreen = '/splash-screen';
const String krHome = '/home';

List<GetPage<dynamic>>? routes = [
  GetPage(name: krSplashScreen, page: () => const SplashScreen(), transition: Transition.noTransition),
  //  GetPage(name: krHome, page: () => HomeScreen(), transition: Transition.noTransition),
];