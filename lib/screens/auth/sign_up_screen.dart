import 'package:flutter/gestures.dart';
import 'package:vidflix_flutter_app/controllers/auth/auth_controller.dart';
import 'package:vidflix_flutter_app/screens/auth/sign_in_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/utils/custom_checkbox.dart';
import 'package:vidflix_flutter_app/utils/constants/images.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});
   final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Obx(() => Padding(
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
                            CustomElevatedButton(label: ksBack, onPressed: (){Get.back();},prefixIcon: Icons.arrow_back_ios,prefixIconColor: cWhiteColor,buttonWidth: 80,buttonHeight: 32,buttonColor: cWhiteColor.withOpacity(0.1),isCircularHead: true),
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
                      child: SvgPicture.asset(kiVidflix,width: 40,height: 40,),
                    ),
                  ),
                ),
                kH40sizedBox,
                Center(child: Text("${ksCreateYourAccountFree.tr}!",style: medium28TextStyle(cWhiteColor),)),
                kH12sizedBox,
                Text(ksPleaseEnterYourDetailsToSignUp.tr,style: regular16TextStyle(cWhiteColor.withOpacity(0.8)),),
                kH16sizedBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(ksContinueWith.tr,style: regular16TextStyle(cWhiteColor),)),
                kH16sizedBox,
                 Row(
                  children: [
                    CommonContainer(image: kiPhone,onPressed: () {
                      Get.toNamed(krPhoneSignInScreen);
                    },),
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
                      child:  Divider(
                        thickness: 1,
                        color: cWhiteColor.withOpacity(0.2),
                        height: 1,
                      ),
            
                    ),
                    kW8sizedBox,
                    Text(ksOR,style: regular16TextStyle(cWhiteColor),),
                    kW8sizedBox,
                           SizedBox(
                      width: (width-80)/2,
                      child:  Divider(
                        thickness: 1,
                        color: cWhiteColor.withOpacity(0.2),
                        height: 1,
                      ),
                    ),
                  ],
                ),
                kH16sizedBox,
                SizedBox(
                  width: width-40,
                  child: Row(
                    children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(ksFirstName.tr,style: regular16TextStyle(cWhiteColor),),
                                          kH8sizedBox,
                                    SizedBox(
                                      height: kTextFieldHeight.h,
                                      width: (width-54)/2,
                                      child: CustomModifiedTextField(
                                        hint: ksEnterHere.tr,
                                        controller: authController.firstNameTextEditingController,
                                        fillColor: cBlackColor,
                                        textInputStyle: regular14TextStyle(cWhiteColor),
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
                                        ),
                                    ),
                      ],
                    ),
                    kW14sizedBox,
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(ksLastName.tr,style: regular16TextStyle(cWhiteColor),),
                                          kH8sizedBox,
                                    SizedBox(
                                      height: kTextFieldHeight.h,
                                      width: (width-54)/2,
                                      child: CustomModifiedTextField(
                                        hint: ksEnterHere.tr,
                                        controller: authController.lastNameTextEditingController,
                                        fillColor: cBlackColor,
                                        textInputStyle: regular14TextStyle(cWhiteColor),
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
                                        ),
                                    ),
                      ],
                    ),
                    ],
                  ),
                ),
                 kH12sizedBox,             
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(ksUserName.tr,style: regular16TextStyle(cWhiteColor),)),
                kH8sizedBox,
                SizedBox(
                  height: kTextFieldHeight.h,
                  child: CustomModifiedTextField(
                    hint: ksEnterHere.tr,
                    controller: authController.userNameTextEditingController,
                    fillColor: cBlackColor,
                    textInputStyle: regular14TextStyle(cWhiteColor),
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
                    ),
                ),
                kH12sizedBox,
                           Align(
                  alignment: Alignment.centerLeft,
                  child: Text(ksEmail.tr,style: regular16TextStyle(cWhiteColor),)),
                kH8sizedBox,
                SizedBox(
                  height: kTextFieldHeight.h,
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
                     border: 
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(k6BorderRadius),
                    borderSide:  BorderSide(width: 1,color: cWhiteColor.withOpacity(0.3), style: BorderStyle.solid,),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                    ),
                ),
                kH12sizedBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(ksPassword.tr,style: regular16TextStyle(cWhiteColor),)),
                kH8sizedBox,
                SizedBox(
                  height: kTextFieldHeight.h,
                  child: CustomModifiedTextField(
                    hint: ksPassword.tr,
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
                kH12sizedBox,
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(ksConfirmPassword.tr,style: regular16TextStyle(cWhiteColor),)),
                kH8sizedBox,
                SizedBox(
                  height: kTextFieldHeight.h,
                  child: CustomModifiedTextField(
                    hint: ksPassword.tr,
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
                 Align(
                  alignment: Alignment.centerLeft,
                   child: CustomCheckBox(
                     value: authController
                         .isRememberMe.value,
                     label: ksRememberMe.tr,
                     textStyle: regular14TextStyle(cWhiteColor),
                     onChanged: (value) {
                       authController
                               .isRememberMe.value =
                           !authController
                               .isRememberMe.value;
                     },
                   ),
                 ),
                kH16sizedBox,
                CustomElevatedButton(label: ksSignUp.tr, onPressed: (){Get.toNamed(krChooseInterestScreen);},buttonWidth: width-40,buttonColor: cPrimaryColor2),
                kH16sizedBox,
                RichText(
                                text: TextSpan(
                                  text: "${ksAlreadyHaveAnAccount.tr}? ",
                                  style: regular16TextStyle(cWhiteColor),
                                  children: [
                                    TextSpan(
                                      text: ksSignIn.tr,
                                      style: regular16TextStyle(cPrimaryColor2),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          authController.resetAuth();
                                          Get.toNamed(krSignInScreen);
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
    );
  }
}