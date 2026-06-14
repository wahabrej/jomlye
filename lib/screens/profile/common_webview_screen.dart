import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class CommonWebViewScreen extends StatelessWidget {
   CommonWebViewScreen({super.key,required this.commonUrl});
   final String commonUrl;
  //  final String ? titleText,urlLink;
  // late bool? isLoading;
  // late InAppWebViewController webViewController;
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body:  Padding(
          padding: const EdgeInsets.all(k10Padding),
          child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(commonUrl))), //* profileController.privacyPolicyUrl
                onWebViewCreated: (controller) {
                  profileController.privacyWebViewController = controller; //*profileController.webViewController
                },
                onLoadStart: (controller, url) {
                  profileController.privacyIsLoading.value = true; //isLoading
                },
                onLoadStop: (controller, url) {
                  profileController.privacyIsLoading.value = false;//isLoading
                },
              ),
        ),
      ),
    );
  }
}
