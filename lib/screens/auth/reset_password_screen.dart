import 'package:vidflix_flutter_app/controllers/auth/auth_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/images.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
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
                      padding: const EdgeInsets.all(k20Padding),
                      child: SvgPicture.asset(
                        kiVidflix,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                kH40sizedBox,
                Center(
                    child: Text(
                  "${ksCreateNewPassword.tr}?",
                  style: medium28TextStyle(cWhiteColor),
                )),
                kH12sizedBox,
                Text(
                  "${ksMakeANewPasswordAndContinueExploring.tr}.",
                  style: regular16TextStyle(cWhiteColor.withOpacity(0.8)),
                ),
                kH16sizedBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ksNewPassword.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                kH8sizedBox,
                 SizedBox(
                  height: 46,
                  child: CustomModifiedTextField(
                    hint: ksEnterNewPassword.tr,
                    controller: authController.passwordTextEditingController,
                    fillColor: cBlackColor,
                    textInputStyle: regular14TextStyle(cWhiteColor),
                    obscureText: authController.isPasswordShow.value ? false : true,
                    focusBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(k6BorderRadius),
                      borderSide: const BorderSide(
                        width: 1,
                        color: cPrimaryColor2,
                      ),
                    ),
                     border: 
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(k6BorderRadius),
                    borderSide:  BorderSide(width: 1,color: cWhiteColor.withOpacity(0.3), style: BorderStyle.solid,),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  suffixIcon: authController.isPasswordShow.value ?  Icons.visibility:Icons.visibility_off,
                  onSuffixPress: (){
                    authController.isPasswordShow.value = ! authController.isPasswordShow.value;
                  },
                    ),
                ),
                          kH16sizedBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ksConfirmPassword.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                kH8sizedBox,
                 SizedBox(
                  height: 46,
                  child: CustomModifiedTextField(
                    hint: ksConfirmPassword.tr,
                    controller: authController.confirmPasswordTextEditingController,
                    fillColor: cBlackColor,
                    textInputStyle: regular14TextStyle(cWhiteColor),
                    obscureText: authController.isConfirmPasswordShow.value ? false : true,
                    focusBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(k6BorderRadius),
                      borderSide: const BorderSide(
                        width: 1,
                        color: cPrimaryColor2,
                      ),
                    ),
                     border: 
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(k6BorderRadius),
                    borderSide:  BorderSide(width: 1,color: cWhiteColor.withOpacity(0.3), style: BorderStyle.solid,),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  suffixIcon: authController.isConfirmPasswordShow.value ?  Icons.visibility:Icons.visibility_off,
                  onSuffixPress: (){
                    authController.isConfirmPasswordShow.value = ! authController.isConfirmPasswordShow.value;
                  },
                    ),
                ),
                kH16sizedBox,
                CustomElevatedButton(
                    label: ksGetStarted.tr,
                    onPressed: () {
                       authController.resetAuth();
                      showSnackBar(title: "Success", message: "Password Changed Successfully", color: cGreenColor);
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
