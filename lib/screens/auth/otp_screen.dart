import 'package:vidflix_flutter_app/controllers/auth/auth_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/common_otp_field.dart';
import 'package:vidflix_flutter_app/utils/constants/images.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class OTPScreen extends StatelessWidget {
   OTPScreen({super.key});
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
                SizedBox(height: height*0.15.h,),
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
                  "${ksOTPVerification.tr}!",
                  style: medium28TextStyle(cWhiteColor),
                )),
                kH12sizedBox,
                Text(
                  ksEnterTheVerificationCodeWeJustSentOnYourEmail.tr,
                  style: regular16TextStyle(cWhiteColor.withOpacity(0.8)),
                ),
                kH16sizedBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(ksEnterOTP,style: regular16TextStyle(cWhiteColor),)),
                kH16sizedBox,
                 OtpTextField(
                            controller: authController
                                .otpTextEditingController,
                            onChange: (value) {
                              // registrationHelper.checkCanOTPVerifyNow();
                              // authenticationController.checkCanOTPVerifyNow();
                            },
                            onSubmit: (v){
                              if(authController
                                .otpTextEditingController.text.length==6){
                                   authController.resetAuth();
                                  showSnackBar(title: "Success", message: "Successfully verified!", color: cGreenColor);
                                }
                            },
                          ),
                    kH40sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  
  
  }
}