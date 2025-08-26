// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
// import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
// import 'package:flixoo_flutter_app/utils/constants/imports.dart';

// class PaymentMethodScreen extends StatelessWidget {
//   PaymentMethodScreen({super.key});
//   final ProfileController profileController = Get.find<ProfileController>();
//   // final String url = "${Environment.apiUrl.replaceFirst(RegExp(r'api/$'), '')}packages?token=${Get.find<GlobalController>().userToken.value}";
//   final String url = "${Environment.apiUrl}packages?token=klsdfksjdlsjflk&payment_type=rental&video_id=1";

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         backgroundColor: cBlackColor,
//          appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kAppBarSize.h),
//         //   //* info:: appBar
//         child: CustomAppBar(
//           hasBackButton: false,
//           title: GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//             child: Container(
//               width: 200.w,
//               height: h32,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100.r),
//                 color: cWhiteColor.withOpacity(0.2),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: k12Padding, vertical: k2Padding),
//                 child: Row(
//                   children: [
//                     const Icon(
//                       Icons.arrow_back_ios,
//                       size: kIconSize12,
//                       color: cWhiteColor,
//                     ),
//                     kW4sizedBox,
//                     SizedBox(
//                       width: 160.w,
//                       child: Center(
//                           child: Text(
//                                                 ksSelectPaymentMethod.tr,
//                                                 style: regular16TextStyle(cWhiteColor),
//                                                 overflow: TextOverflow.ellipsis,
//                                               )),
//                     ),

//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//         body: InAppWebView(
//           initialUrlRequest: URLRequest(url: WebUri(url)),
//           initialOptions: InAppWebViewGroupOptions(
//             crossPlatform: InAppWebViewOptions(
//               useShouldOverrideUrlLoading: true,
//               mediaPlaybackRequiresUserGesture: false,
//             ),
//             android: AndroidInAppWebViewOptions(
//               useHybridComposition: true,
//             ),
//             ios: IOSInAppWebViewOptions(
//               allowsInlineMediaPlayback: true,
//             ),
//           ),
//           onWebViewCreated: (controller) {
//             // You can store the controller if needed
//           },
//           onLoadStart: (controller, url) {
//             debugPrint("Started loading: $url");
//           },
//           onLoadStop: (controller, url) async {
//             debugPrint("Finished loading: $url");
//           },
//           onLoadError: (controller, url, code, message) {
//             debugPrint("Error $code: $message");
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
// import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
// import 'package:flixoo_flutter_app/utils/constants/imports.dart';

// class PaymentMethodScreen extends StatelessWidget {
//   PaymentMethodScreen({super.key,required this.paymentType});
//   final String paymentType;
//   // final String? packageid,videoId;

//   final ProfileController profileController = Get.find<ProfileController>();
//   final GlobalController globalController = Get.find<GlobalController>();

//   // final String url =
//   //   "${Environment.apiUrl.replaceFirst(RegExp(r'api/$'), '')}packages?token=${Get.find<GlobalController>().userToken}&payment_type=rental&video_id=1";
//   //   //  :"http://flixoo.local/packages?token=klsdfksjdlsjflk&payment_type=subscription&package_id=1";
//   // final String url =
//   //   "${Environment.apiUrl.replaceFirst(RegExp(r'api/$'), '')}packages?token=${Get.find<GlobalController>().userToken.value}&payment_type=rental&video_id=1";
//     // : "http://flixoo.local/packages?token=klsdfksjdlsjflk&payment_type=subscription&package_id=1";
//     final String url = Get.find<ProfileController>().paymentTypeSelection("rental");

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         backgroundColor: cBlackColor,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(kAppBarSize.h),
//           child: CustomAppBar(
//             hasBackButton: false,
//             title: GestureDetector(
//               onTap: () {
//                 Get.back();
//               },
//               child: Container(
//                 width: 200.w,
//                 height: h32,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100.r),
//                   color: cWhiteColor.withOpacity(0.2),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: k12Padding, vertical: k2Padding),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.arrow_back_ios,
//                         size: kIconSize12,
//                         color: cWhiteColor,
//                       ),
//                       kW4sizedBox,
//                       SizedBox(
//                         width: 160.w,
//                         child: Center(
//                           child: Text(
//                             ksSelectPaymentMethod.tr,
//                             style: regular16TextStyle(cWhiteColor),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: InAppWebView(
//           initialUrlRequest: URLRequest(
//             url: WebUri(url),
//             headers: {
//               "apiKey": "${Environment.apiKey}",
//             },
//           ),
//           initialOptions: InAppWebViewGroupOptions(
//             crossPlatform: InAppWebViewOptions(
//               useShouldOverrideUrlLoading: true,
//               mediaPlaybackRequiresUserGesture: false,
//             ),
//             android: AndroidInAppWebViewOptions(
//               useHybridComposition: true,
//             ),
//             ios: IOSInAppWebViewOptions(
//               allowsInlineMediaPlayback: true,
//             ),
//           ),
//           onWebViewCreated: (controller) {
//             debugPrint("WebView created");
//           },
//           onLoadStart: (controller, url) {
//             debugPrint("Started loading: $url");
//           },
//           onLoadStop: (controller, url) async {
//             debugPrint("Finished loading: $url");
//           },
//           onLoadError: (controller, url, code, message) {
//             debugPrint("Error $code: $message");
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({
    super.key,
    required this.paymentType,
    required this.planId,
    required this.videoType,
  });
  final String paymentType, planId, videoType;

  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalController globalController = Get.find<GlobalController>();

  // final String url =
  //     Get.find<ProfileController>().paymentTypeSelection("rental");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSize.h),
          child: CustomAppBar(
            hasBackButton: false,
            title: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 200.w,
                height: h32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: cWhiteColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: k12Padding, vertical: k2Padding),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        size: kIconSize12,
                        color: cWhiteColor,
                      ),
                      kW4sizedBox,
                      SizedBox(
                        width: 160.w,
                        child: Center(
                          child: Text(
                            ksSelectPaymentMethod.tr,
                            style: regular16TextStyle(cWhiteColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // body: InAppWebView(
        //   initialUrlRequest: URLRequest(
        //     url: WebUri(url),
        //     headers: {
        //       "apiKey": "${Environment.apiKey}",
        //     },
        //   ),
        //   initialOptions: InAppWebViewGroupOptions(
        //     crossPlatform: InAppWebViewOptions(
        //       useShouldOverrideUrlLoading: true,
        //       mediaPlaybackRequiresUserGesture: false,
        //     ),
        //     android: AndroidInAppWebViewOptions(
        //       useHybridComposition: true,
        //     ),
        //     ios: IOSInAppWebViewOptions(
        //       allowsInlineMediaPlayback: true,
        //     ),
        //   ),
        //   onWebViewCreated: (controller) {
        //     debugPrint("WebView created");
        //   },
        //   onLoadStart: (controller, url) {
        //     debugPrint("Started loading: $url");
        //   },
        //   onLoadStop: (controller, url) async {
        //     ll("Finished loading: $url");

        //     // ✅ Check for success redirect
        //     // if (url != null && url.toString().contains("payment/success")) {
        //     if (url != null && url.toString().contains("home")) {
        //       debugPrint("✅ Payment success detected, redirecting to Home...");
        //       Get.offAllNamed(krHomeScreen);
        //     }
        //   },
        //   onLoadError: (controller, url, code, message) {
        //     ll("Error $code: $message");
        //   },
        // ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH20sizedBox,
                  Obx(() => InkWell(
                        splashColor: cTransparentColor,
                        highlightColor: cTransparentColor,
                        onTap: () {
                          profileController.isPaymentMethodSelected.value =
                              true;
                        },
                        child: Container(
                          width: (width - 70) / 4,
                          height: 60.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(k6BorderRadius),
                            color: cWhiteColor.withOpacity(0.1),
                            border: Border.all(
                              width: 1,
                              color: profileController
                                      .isPaymentMethodSelected.value
                                  ? cPrimaryColor
                                  : cTransparentColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(k16Padding),
                            child: SvgPicture.asset(
                              kiOffline,
                              color: cWhiteColor,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )),
                  kH8sizedBox,
                  Text(
                    "Offline",
                    style: semiBold14TextStyle(cWhiteColor),
                  ),
                  if (profileController.isPaymentMethodSelected.value)
                    kH100sizedBox,
                  if (profileController.isPaymentMethodSelected.value)
                    Text(
                      "Transaction Key",
                      style: semiBold14TextStyle(cWhiteColor),
                    ),
                  if (profileController.isPaymentMethodSelected.value)
                    kH12sizedBox,
                  if (profileController.isPaymentMethodSelected.value)
                    SizedBox(
                      height: kTextFieldHeight.h,
                      child: CustomModifiedTextField(
                        hint: ksEnterHere.tr,
                        controller: profileController
                            .transactionKeyTextEditingController,
                        fillColor: cBlackColor,
                        textInputStyle: regular14TextStyle(cWhiteColor),
                        focusBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k6BorderRadius),
                          borderSide: const BorderSide(
                            width: 1,
                            color: cPrimaryColor2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k6BorderRadius),
                          borderSide: BorderSide(
                            width: 1,
                            color: cWhiteColor.withOpacity(0.3),
                            style: BorderStyle.solid,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  kH30sizedBox,
                  CustomElevatedButton(
                    label: ksStartPlan.tr,
                    onPressed: () {
                      // Get.toNamed(krPaymentSuccessScreen);
                      profileController.offlinePaymentMethod(
                          paymentType: paymentType,
                          planId: planId,
                          videoType: videoType);
                    },
                    buttonColor: cPrimaryColor2,
                    buttonHeight: 40.h,
                    buttonWidth: width - 40,
                    textStyle: regular14TextStyle(cWhiteColor),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
