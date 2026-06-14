import 'package:flixoo_flutter_app/controllers/auth/auth_controller.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSize.h),
        //* info:: appBar
        child: CustomAppBar(
          hasBackButton: false,
          title: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 80.w,
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
                    Center(
                        child: Text(
                      ksBack.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height*0.15.h),
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cWhiteColor.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(k12Padding),
                      child: Image.asset(
                        kiFlixooPng,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
                kH40sizedBox,
                Center(
                    child: Text(
                  "${ksForgotPassword.tr}?",
                  style: medium28TextStyle(cWhiteColor),
                )),
                kH12sizedBox,
                Text(
                  "${ksDontWorryResetItAndGetBackToExploringVideos.tr}.",
                  style: regular16TextStyle(cWhiteColor.withOpacity(0.8)),
                ),
                kH16sizedBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ksEnterEmailAddress.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                kH8sizedBox,
                SizedBox(
                  height: 46,
                  child: CustomModifiedTextField(
                    hint: ksEnterHere.tr,
                    controller: authController.forgotEmailTextEditingController,
                    fillColor: cBlackColor,
                    textInputStyle: regular14TextStyle(cWhiteColor),
                    inputType: TextInputType.name,
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
                kH16sizedBox,
                CustomElevatedButton(
                    label: ksSendOTP.tr,
                    onPressed: () async{
                      await authController.forgotPassword();
                    },
                    buttonWidth: width - 40,
                    buttonColor: cPrimaryColor2),
                    kH40sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
