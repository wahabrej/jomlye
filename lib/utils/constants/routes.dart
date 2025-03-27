import 'package:vidflix_flutter_app/screens/auth/choose_interest_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/forgot_password_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/otp_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/phone_sign_in_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/sign_in_screen.dart';
import 'package:vidflix_flutter_app/screens/auth/sign_up_screen.dart';
import 'package:vidflix_flutter_app/screens/home/blog/blog_single_screen.dart';
import 'package:vidflix_flutter_app/screens/home/cast/cast_details_screen.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/screens/home/search_screen.dart';
import 'package:vidflix_flutter_app/screens/home/view_all_screens/all_blogs_view_all_screen.dart';
import 'package:vidflix_flutter_app/screens/home/view_all_screens/top_artists_view_all_screen.dart';
import 'package:vidflix_flutter_app/screens/home/view_all_screens/tv_channels_view_all_screen.dart';
import 'package:vidflix_flutter_app/screens/home/view_all_screens/movie_view_all_screen.dart';
import 'package:vidflix_flutter_app/screens/intro/landing_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/download_list_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/edit_profile_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/favorite_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/language_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/notification_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/payment_history_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/payment_method_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/payment_success_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/profile_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/settings/manage_download_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/settings/manage_notification_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/settings/settings_screen.dart';
import 'package:vidflix_flutter_app/screens/profile/subscription_plan_screen.dart';
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
const String krProfileScreen = "/profile-screen";
const String krLanguageScreen = "/language-screen";
const String krSubscriptionPlanScreen = "/subscription-plan-screen";
const String krPaymentHistoryScreen = "/payment-history-screen";
const String krNotificationScreen = "/notification-screen";
const String krFavoriteScreen = '/favorite-screen';
const String krPaymentMethodScreen = '/payment-method-screen';
const String krPaymentSuccessScreen = '/payment-success-screen';
const String krDownloadListScreen = '/download-list-screen';
const String krSettingsScreen = '/settings-screen';
const String krManageNotificationScreen = '/manage-notification-screen';
const String krManageDownloadScreen = '/manage-download-screen';
//*Home
const String krHomeScreen = '/home-screen';
const String krMovieViewAllScreen = '/movie-viewall-screen';
const String krTvChannelsViewAllScreen = '/tvchannels-viewall-screen';
const String krTopArtistsViewAllScreen = '/topartists-viewall-screen';
const String krAllBlogsViewAllScreen = '/allblogs-viewall-screen';
const String krBlogSingleScreen = '/blog-single-screen';
const String krSearchScreen = '/search-screen';
const String krCastDetailsScreen = '/cast-details-screen';


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
   GetPage(name: krProfileScreen, page: () => ProfileScreen(), transition: Transition.noTransition),
   GetPage(name: krLanguageScreen, page: () => LanguageScreen(), transition: Transition.noTransition),
   GetPage(name: krSubscriptionPlanScreen, page: () => SubscriptionPlanScreen(), transition: Transition.noTransition),
   GetPage(name: krPaymentHistoryScreen, page: () => PaymentHistoryScreen(), transition: Transition.noTransition),
   GetPage(name: krNotificationScreen, page: () => NotificationScreen(), transition: Transition.noTransition),
   GetPage(name: krFavoriteScreen, page: () => FavoriteScreen(), transition: Transition.noTransition),
   GetPage(name: krPaymentMethodScreen, page: () => PaymentMethodScreen(), transition: Transition.noTransition),
   GetPage(name: krPaymentSuccessScreen, page: () => PaymentSuccessScreen(), transition: Transition.noTransition),
   GetPage(name: krDownloadListScreen, page: () => DownloadListScreen(), transition: Transition.noTransition),
   GetPage(name: krDownloadListScreen, page: () => DownloadListScreen(), transition: Transition.noTransition),
   GetPage(name: krSettingsScreen, page: () => SettingsScreen(), transition: Transition.noTransition),
   GetPage(name: krManageNotificationScreen, page: () => ManageNotificationScreen(), transition: Transition.noTransition),
   GetPage(name: krManageDownloadScreen, page: () => ManageDownloadScreen(), transition: Transition.noTransition),
   //*Home 
   GetPage(name: krHomeScreen, page: () => HomeScreen(), transition: Transition.noTransition),
   GetPage(name: krMovieViewAllScreen, page: () => MovieViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krTvChannelsViewAllScreen, page: () => TvChannelsViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krTopArtistsViewAllScreen, page: () => TopArtistsViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krAllBlogsViewAllScreen, page: () => AllBlogsViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krBlogSingleScreen, page: () => BlogSingleScreen(), transition: Transition.noTransition),
   GetPage(name: krSearchScreen, page: () => SearchScreen(), transition: Transition.noTransition),
   GetPage(name: krCastDetailsScreen, page: () => CastDetailsScreen(), transition: Transition.noTransition),

];