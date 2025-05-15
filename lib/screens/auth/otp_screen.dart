import 'package:vidflix_flutter_app/controllers/auth/auth_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/common_otp_field.dart';
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
                            onChange: (value) async {
                              // registrationHelper.checkCanOTPVerifyNow();
                              // authenticationController.checkCanOTPVerifyNow();
                                if(authController
                                .otpTextEditingController.text.length==6){
                                  await authController.otpVerification();
                                }
                            },
                            // onSubmit: (v)async{
                            //   if(authController
                            //     .otpTextEditingController.text.length==6){
                            //       await authController.otpVerification();
                            //     }
                            // },
                            // onCompleted: (v)async{
                            //   if(authController
                            //     .otpTextEditingController.text.length==6){
                            //       await authController.otpVerification();
                            //     }
                            // },
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