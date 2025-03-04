import 'package:vidflix_flutter_app/screens/intro/landing_screen.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/screens/intro/splash_screen.dart';

const String krSplashScreen = '/splash-screen';
const String krHome = '/home-screen';
const String krLandingScreen = '/landing-screen';

List<GetPage<dynamic>>? routes = [
  GetPage(name: krSplashScreen, page: () => const SplashScreen(), transition: Transition.noTransition),
   GetPage(name: krLandingScreen, page: () => LandingScreen(), transition: Transition.noTransition),
];