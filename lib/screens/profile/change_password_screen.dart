import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class ChangePasswordScreen extends StatelessWidget {
 ChangePasswordScreen({super.key});
 final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              width: 175.w,
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
                      ksChangePassword.tr,
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
        child: Obx(() => Column(
                  children: [
                    kH12sizedBox,
                    Divider(
                                thickness: 1,
                                color: cWhiteColor.withOpacity(0.2),
                                height: 1,
                              ),
                              kH20sizedBox,
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
                            controller: profileController.oldPasswordTextEditingController,
                            fillColor: cBlackColor,
                            textInputStyle: regular14TextStyle(cWhiteColor),
                            obscureText: profileController.isOldPasswordShow.value ? false : true,
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
                          suffixIcon: profileController.isOldPasswordShow.value ?  Icons.visibility:Icons.visibility_off,
                          onSuffixPress: (){
                            profileController.isOldPasswordShow.value = ! profileController.isOldPasswordShow.value;
                  },
                    ),
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
                    controller: profileController.newPasswordTextEditingController,
                    fillColor: cBlackColor,
                    textInputStyle: regular14TextStyle(cWhiteColor),
                    obscureText: profileController.isNewPasswordShow.value ? false : true,
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
                  suffixIcon: profileController.isNewPasswordShow.value ?  Icons.visibility:Icons.visibility_off,
                  onSuffixPress: (){
                    profileController.isNewPasswordShow.value = ! profileController.isNewPasswordShow.value;
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
                    controller: profileController.confirmNewPasswordTextEditingController,
                    fillColor: cBlackColor,
                    textInputStyle: regular14TextStyle(cWhiteColor),
                    obscureText: profileController.isConfirmNewPasswordShow.value ? false : true,
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
                  suffixIcon: profileController.isConfirmNewPasswordShow.value ?  Icons.visibility:Icons.visibility_off,
                  onSuffixPress: (){
                    profileController.isConfirmNewPasswordShow.value = ! profileController.isConfirmNewPasswordShow.value;
                  },
                    ),
                ),
                     kH40sizedBox,
                CustomElevatedButton(
                    label: ksGetStarted.tr,
                    onPressed: () {
                      showSnackBar(title: "Success", message: "Password Changed Successfully", color: cGreenColor);
                    },
                    buttonWidth: width - 40,
                    buttonColor: cPrimaryColor2),
                    kH40sizedBox,
          ],
        ),
      ),
      ),
    );
  }
}