import 'package:flutter/gestures.dart';
import 'package:flixoo_flutter_app/controllers/auth/auth_controller.dart';
import 'package:flixoo_flutter_app/controllers/common/sp_controller.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/utils/custom_checkbox.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: WillPopScope(
        onWillPop: () async {
          Get.toNamed(krHomeScreen);
          return false;
        },
        child: Scaffold(
          backgroundColor: cBlackColor,
          body: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kH24sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomElevatedButton(
                            label: ksBack,
                            onPressed: () {
                              Get.toNamed(krHomeScreen);
                            },
                            prefixIcon: Icons.arrow_back_ios,
                            prefixIconColor: cWhiteColor,
                            buttonWidth: 80,
                            buttonHeight: 32,
                            buttonColor: cWhiteColor.withOpacity(0.1),
                            isCircularHead: true),
                      ],
                    ),
                    // const SizedBox(height: 60,),
                    kH40sizedBox,
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
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                    kH40sizedBox,
                    Center(
                        child: Text(
                      "${ksWelcomeBack.tr}!",
                      style: medium28TextStyle(cWhiteColor),
                    )),
                    kH12sizedBox,
                    Text(
                      ksPleaseEnterYourDetailsToSignIn.tr,
                      style: regular16TextStyle(cWhiteColor.withOpacity(0.8)),
                    ),
                    kH16sizedBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ksContinueWith.tr,
                          style: regular16TextStyle(cWhiteColor),
                        )),
                    kH16sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonContainer(
                          image: kiGoogle,
                          onPressed: () async {
                            await authController.signInWithGoogle();
                          },
                        ),
                        kW12sizedBox,
                        // CommonContainer(
                        //   image: kiFacebook,
                        //   onPressed: () async {
                        //   await authController.signInWithFacebook();
                        //   },
                        // ),
                      ],
                    ),
                    kH16sizedBox,
                    Row(
                      children: [
                        SizedBox(
                          width: (width - 80) / 2,
                          child: Divider(
                            thickness: 1,
                            color: cWhiteColor.withOpacity(0.2),
                            height: 1,
                          ),
                        ),
                        kW8sizedBox,
                        Text(
                          ksOR,
                          style: regular16TextStyle(cWhiteColor),
                        ),
                        kW8sizedBox,
                        SizedBox(
                          width: (width - 80) / 2,
                          child: Divider(
                            thickness: 1,
                            color: cWhiteColor.withOpacity(0.2),
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    kH16sizedBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ksUserNameOrEmail.tr,
                          style: regular16TextStyle(cWhiteColor),
                        )),
                    kH8sizedBox,
                    SizedBox(
                      height: 46,
                      child: CustomModifiedTextField(
                        hint: ksEnterHere.tr,
                        controller: authController.emailTextEditingController,
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
                    kH12sizedBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ksPassword.tr,
                          style: regular16TextStyle(cWhiteColor),
                        )),
                    kH8sizedBox,
                    SizedBox(
                      height: 46,
                      child: CustomModifiedTextField(
                        hint: ksEnterPassword.tr,
                        controller:
                            authController.passwordTextEditingController,
                        fillColor: cBlackColor,
                        textInputStyle: regular14TextStyle(cWhiteColor),
                        obscureText:
                            authController.isPasswordShow.value ? false : true,
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
                        suffixIcon: authController.isPasswordShow.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onSuffixPress: () {
                          authController.isPasswordShow.value =
                              !authController.isPasswordShow.value;
                        },
                      ),
                    ),
                    kH16sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCheckBox(
                          value: authController.isRememberMe.value,
                          label: ksRememberMe.tr,
                          textStyle: regular14TextStyle(cWhiteColor),
                          onChanged: (value) {
                            authController.isRememberMe.value =
                                !authController.isRememberMe.value;
                          },
                        ),
                        InkWell(
                            onTap: () {
                              authController.resetAuth();
                              Get.toNamed(krForgotPasswordScreen);
                            },
                            child: Text(
                              "${ksForgotPassword.tr}?",
                              style: regular14TextStyle(cPrimaryColor2),
                            )),
                      ],
                    ),
                    kH16sizedBox,
                    CustomElevatedButton(
                        label: ksSignIn.tr,
                        onPressed: () async {
                          await SpController().saveUserPassword(authController
                              .passwordTextEditingController.text
                              .trim()
                              .toString());
                          await authController.signIn();
                        },
                        buttonWidth: width - 40,
                        buttonColor: cPrimaryColor2),
                    kH16sizedBox,
                    RichText(
                      text: TextSpan(
                        text: "${ksDontHaveAnyAccount.tr} ",
                        style: regular16TextStyle(cWhiteColor),
                        children: [
                          TextSpan(
                            text: ksSignUp.tr,
                            style: regular16TextStyle(cPrimaryColor2),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                authController.resetAuth();
                                Get.toNamed(krSignUpScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                    kH40sizedBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonContainer extends StatelessWidget {
  const CommonContainer(
      {super.key,
      required this.image,
      this.isSelected = false,
      this.onPressed});
  final String image;
  final bool? isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: (width - 64) / 3,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(k8BorderRadius),
          color: cWhiteColor.withOpacity(0.1),
          border: Border.all(
              width: 1, color: isSelected! ? cPrimaryColor2 : cBlackColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.5),
          child: SvgPicture.asset(
            image,
            width: 18,
            height: 18,
          ),
        ),
      ),
    );
  }
}
