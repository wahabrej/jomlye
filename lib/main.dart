import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:flixoo_flutter_app/controllers/common/sp_controller.dart';
import 'package:flixoo_flutter_app/language/languages.dart';
import 'package:flixoo_flutter_app/services/purchase_api.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/common/binder_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GlobalController());
  Stripe.publishableKey =  Get.find<GlobalController>().configModelData.value?.stripeKey??"pk_test_51RCwabBLHhtXKxC7Mfsz74GGTVv47g2JkehS3PQBshS3omOnsWanVW6DAEd8mQBIj3ftU1K8Q1x60NqhygNqVAq8005zZaL7p9";
  await Stripe.instance.applySettings();
   MobileAds.instance.initialize();
  await dotenv.load(fileName: Environment.fileName);
  ll("Filename : ${Environment.fileName}");

  await MobileAds.instance.initialize();
  await PurchaseApi.initRevenueCat();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: GetMaterialApp(
          translations: Languages(),
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          initialRoute: krSplashScreen,
          getPages: routes,
          initialBinding: BinderController(),
          theme: ThemeData(useMaterial3: false),
        ),
      ),
    );
  }
}
