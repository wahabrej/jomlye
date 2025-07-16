import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:vidflix_flutter_app/controllers/common/sp_controller.dart';
import 'package:vidflix_flutter_app/language/languages.dart';
import 'package:vidflix_flutter_app/services/purchase_api.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/common/binder_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   MobileAds.instance.initialize();
  await dotenv.load(fileName: Environment.fileName);
  ll("Filename : ${Environment.fileName}");
  // RequestConfiguration requestConfiguration = RequestConfiguration(
  //   testDeviceIds: ["a0824a2e-4a1f-4a6d-b908-6a3ec2c37d1f"],
  // );
//  await MobileAds.instance.updateRequestConfiguration(requestConfiguration);
 //!One Signal Configuration
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(Environment.oneSignalAppId);
  OneSignal.Notifications.requestPermission(true);

 OneSignal.User.addObserver((state)async{
  var userState = state.jsonRepresentation();
  // await OneSignal.User.getExternalId();
    ll('OneSignal user changed: $userState');
    // final String oneSignalSubscriptionId =  OneSignal.User.pushSubscription.id!;
    // log("The oneSignalSubscriptionId is $oneSignalSubscriptionId");

   await OneSignal.User.pushSubscription.optIn();
   OneSignal.consentRequired(true);
   OneSignal.consentGiven(true);
    OneSignal.User.pushSubscription.addObserver((state) async{
  if (state.current.optedIn) {
  String oneSignalSubscriptionId = state.current.id??"";
    final SpController spController = SpController();
  await spController.saveOneSignalSubscriptionId(oneSignalSubscriptionId);
  final subsId = await spController.getOneSignalSubscriptionId();
  ll('OneSignal subsId is: $subsId');
  if(subsId!=null && subsId!="null"){
    // await getOneSignalSubscription();
  }
  }
});
});
  await MobileAds.instance.initialize();
  await PurchaseApi.initRevenueCat();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); //!device default bottom part show

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
