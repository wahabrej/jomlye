import 'package:flixoo_flutter_app/screens/auth/choose_interest_screen.dart';
import 'package:flixoo_flutter_app/screens/auth/forgot_password_screen.dart';
import 'package:flixoo_flutter_app/screens/auth/otp_screen.dart';
import 'package:flixoo_flutter_app/screens/auth/phone_sign_in_screen.dart';
import 'package:flixoo_flutter_app/screens/auth/reset_password_screen.dart';
import 'package:flixoo_flutter_app/screens/auth/sign_in_screen.dart';
import 'package:flixoo_flutter_app/screens/auth/sign_up_screen.dart';
import 'package:flixoo_flutter_app/screens/home/blog/blog_single_screen.dart';
import 'package:flixoo_flutter_app/screens/home/artist/artist_details_screen.dart';
import 'package:flixoo_flutter_app/screens/home/home_screen.dart';
import 'package:flixoo_flutter_app/screens/home/search_screen.dart';
import 'package:flixoo_flutter_app/screens/home/view_all_screens/all_blogs_view_all_screen.dart';
import 'package:flixoo_flutter_app/screens/home/view_all_screens/top_artists_view_all_screen.dart';
import 'package:flixoo_flutter_app/screens/home/view_all_screens/tv_channels_view_all_screen.dart';
import 'package:flixoo_flutter_app/screens/home/view_all_screens/movie_view_all_screen.dart';
import 'package:flixoo_flutter_app/screens/home/view_all_screens/tv_shows_view_all_screen.dart';
import 'package:flixoo_flutter_app/screens/intro/landing_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/change_password_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/contact_us_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/download_list_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/edit_profile_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/faq_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/favorite_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/language_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/notification_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/payment_history_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/payment_method_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/payment_success_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/playlist_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/profile_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/rented_videos_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/settings/manage_download_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/settings/manage_notification_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/settings/settings_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/settings/video_quality_screen.dart';
import 'package:flixoo_flutter_app/screens/profile/subscription_plan_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/live_tv_player_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/playlist_player_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/tv_show_player_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/screens/intro/splash_screen.dart';
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
const String krResetPasswordScreen = "/reset-password-screen";
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
const String krVideoQualityScreen = '/video-quality-screen';
const String krPlayListScreen = '/playlist-screen';
const String krChangePasswordScreen = '/change-password-screen';
const String krFaqScreen = '/faq-screen';
const String krContactUsScreen = '/contact-us-screen';
const String krRentedVideoScreen = '/rented-video-screen';

//*Home
const String krHomeScreen = '/home-screen';
const String krMovieViewAllScreen = '/movie-viewall-screen';
const String krTvChannelsViewAllScreen = '/tvchannels-viewall-screen';
const String krTopArtistsViewAllScreen = '/topartists-viewall-screen';
const String krAllBlogsViewAllScreen = '/allblogs-viewall-screen';
const String krTvShowsViewAllScreen = '/tv-shows-viewall-screen';
const String krBlogSingleScreen = '/blog-single-screen';
const String krSearchScreen = '/search-screen';
const String krCastDetailsScreen = '/cast-details-screen';

//*Video Player Screen
const String krVideoPlayerScreen = '/video-player-screen';
const String krTvShowPlayerScreen = '/tvshow-player-screen';
const String krPlaylistPlayerScreen = '/playlist-player-screen';
const String krLiveTvPlayerScreen = '/live-tv-player-screen';


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
   GetPage(name: krResetPasswordScreen, page: () => ResetPasswordScreen(), transition: Transition.noTransition),
 //* profile
   GetPage(name: krEditProfileScreen, page: () => EditProfileScreen(), transition: Transition.noTransition),
   GetPage(name: krProfileScreen, page: () => ProfileScreen(), transition: Transition.noTransition),
   GetPage(name: krLanguageScreen, page: () => LanguageScreen(), transition: Transition.noTransition),
   GetPage(name: krSubscriptionPlanScreen, page: () => SubscriptionPlanScreen(), transition: Transition.noTransition),
   GetPage(name: krPaymentHistoryScreen, page: () => PaymentHistoryScreen(), transition: Transition.noTransition),
   GetPage(name: krNotificationScreen, page: () => NotificationScreen(), transition: Transition.noTransition),
   GetPage(name: krFavoriteScreen, page: () => FavoriteScreen(), transition: Transition.noTransition),
  //  GetPage(name: krPaymentMethodScreen, page: () => PaymentMethodScreen(), transition: Transition.noTransition),
   GetPage(name: krPaymentSuccessScreen, page: () => PaymentSuccessScreen(), transition: Transition.noTransition),
   GetPage(name: krDownloadListScreen, page: () => DownloadListScreen(), transition: Transition.noTransition),
   GetPage(name: krDownloadListScreen, page: () => DownloadListScreen(), transition: Transition.noTransition),
   GetPage(name: krSettingsScreen, page: () => SettingsScreen(), transition: Transition.noTransition),
   GetPage(name: krManageNotificationScreen, page: () => ManageNotificationScreen(), transition: Transition.noTransition),
   GetPage(name: krManageDownloadScreen, page: () => ManageDownloadScreen(), transition: Transition.noTransition),
   GetPage(name: krVideoQualityScreen, page: () => VideoQualityScreen(), transition: Transition.noTransition),
   GetPage(name: krPlayListScreen, page: () => PlayListScreen(), transition: Transition.noTransition),
   GetPage(name: krChangePasswordScreen, page: () => ChangePasswordScreen(), transition: Transition.noTransition),
   GetPage(name: krFaqScreen, page: () => FAQScreen(), transition: Transition.noTransition),
   GetPage(name: krContactUsScreen, page: () => ContactUsScreen(), transition: Transition.noTransition),
   GetPage(name: krRentedVideoScreen, page: () => RentedVideoScreen(), transition: Transition.noTransition),
   //*Home 
   GetPage(name: krHomeScreen, page: () => HomeScreen(), transition: Transition.noTransition),
   GetPage(name: krMovieViewAllScreen, page: () => MovieViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krTvChannelsViewAllScreen, page: () => TvChannelsViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krTopArtistsViewAllScreen, page: () => TopArtistsViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krAllBlogsViewAllScreen, page: () => AllBlogsViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krTvShowsViewAllScreen, page: () => TvShowsViewAllScreen(), transition: Transition.noTransition),
   GetPage(name: krBlogSingleScreen, page: () => BlogSingleScreen(), transition: Transition.noTransition),
   GetPage(name: krSearchScreen, page: () => SearchScreen(), transition: Transition.noTransition),
   GetPage(name: krCastDetailsScreen, page: () => CastDetailsScreen(), transition: Transition.noTransition),

   //* video player
   GetPage(name: krVideoPlayerScreen, page: () => VideoPlayerScreen(), transition: Transition.noTransition),
   GetPage(name: krTvShowPlayerScreen, page: () => TvShowPlayerScreen(), transition: Transition.noTransition),
   GetPage(name: krPlaylistPlayerScreen, page: () => PlaylistVideoPlayerScreen(), transition: Transition.noTransition),
   GetPage(name: krLiveTvPlayerScreen, page: () => LiveTvPlayerScreen(), transition: Transition.noTransition),
];