import 'package:flixoo_flutter_app/controllers/auth/auth_controller.dart';
import 'package:flixoo_flutter_app/screens/auth/sign_in_screen.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class PhoneSignInScreen extends StatelessWidget {
  PhoneSignInScreen({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Padding(
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
                          Get.back();
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
                      padding: const EdgeInsets.all(k20Padding),
                      child: SvgPicture.asset(
                        kiFlixoo,
                        width: 40,
                        height: 40,
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
                const Row(
                  children: [
                    CommonContainer(
                      image: kiPhone,
                      isSelected: true,
                    ),
                    kW12sizedBox,
                    CommonContainer(image: kiGoogle),
                    kW12sizedBox,
                    CommonContainer(image: kiFacebook),
                  ],
                ),
                kH16sizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: (width-80)/2,
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
                      width: (width-80)/2,
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
                      ksPhoneNumber.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                kH8sizedBox,
                SizedBox(
                  height: 46,
                  child: CustomModifiedTextField(
                    hint: ksEnterHere.tr,
                    controller: authController.phoneNumberTextEditingController,
                    fillColor: cBlackColor,
                    textInputStyle: regular14TextStyle(cWhiteColor),
                    inputType: TextInputType.number,
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                kH16sizedBox,
                CustomElevatedButton(
                    label: ksSendOTP.tr,
                    onPressed: () async{
                      await authController.phoneLogin();
                      // authController.resetAuth();
                      Get.toNamed(krOTPScreen);
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
