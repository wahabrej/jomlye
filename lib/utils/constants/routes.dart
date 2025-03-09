import 'package:vidflix_flutter_app/screens/auth/choose_interest_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/forgot_password_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/otp_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/phone_sign_in_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/sign_in_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/sign_up_screen.dart';
import 'package:vidflix_flutter_app/screens/intro/landing_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/edit_profile_screen.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/screens/intro/splash_screen.dart';
//*intro
const String krSplashScreen = '/splash-screen';
const String krLandingScreen = '/landing-screen';
//* auth
const String krSignInScreen = "/signin-screen";
const String krSignUpScreen = "/signup-screen";
const String krPhoneSignInScreen = "/phonesignin-screen";
const String krOTPScreen = "/otp-screen";
const String krForgotPasswordScreen = "/forgotpassword-screen";
const String krChooseInterestScreen = "/chooseinterest-screen";
//*profile
const String krEditProfileScreen = "/editprofile-screen";

const String krHome = '/home-screen';


List<GetPage<dynamic>>? routes = [
  GetPage(name: krSplashScreen, page: () => const SplashScreen(), transition: Transition.noTransition),
   GetPage(name: krLandingScreen, page: () => LandingScreen(), transition: Transition.noTransition),
   //* auth
   GetPage(name: krSignInScreen, page: () => SignInScreen(), transition: Transition.noTransition),
   GetPage(name: krSignUpScreen, page: () => SignUpScreen(), transition: Transition.noTransition),
   GetPage(name: krPhoneSignInScreen, page: () => PhoneSignInScreen(), transition: Transition.noTransition),
   GetPage(name: krOTPScreen, page: () => OTPScreen(), transition: Transition.noTransition),
   GetPage(name: krForgotPasswordScreen, page: () => ForgotPasswordScreen(), transition: Transition.noTransition),
   GetPage(name: krChooseInterestScreen, page: () => ChooseInterestScreen(), transition: Transition.noTransition),
 //* profile
   GetPage(name: krEditProfileScreen, page: () => EditProfileScreen(), transition: Transition.noTransition),
];