import 'package:flutter/gestures.dart';
import 'package:vidflix_flutter_app/controllers/auth/auth_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: SvgPicture.asset(kiLandingImage,width: width,
                  fit: BoxFit.cover,)),
                  Positioned(
                    top: height/1.8,
                    right: width/2.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(kiVidflix,width: 40,height: 40,),
                      kW8sizedBox,
                      Text(ksVidflix.tr,style: semiBold20TextStyle(cWhiteColor),),
                    ],
                  ),
                      ],
                    ),
                    ),
                    Positioned(
                      bottom: height/3.2,
                      right: width/7,
                      child: 
                  Center(
                    child: SizedBox(
                      width: width*0.75,
                      child: Text(ksDiscoverAVarietyOfMovies.tr,style: regular20TextStyle(cWhiteColor),textAlign: TextAlign.center,)),
                  ),
                      ),
                    Positioned(
                      // height: height/0.66,
                      bottom: height/4.5,
                      right: width/25,
                      child: 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: k0Padding),
                    child: Center(
                      child: CustomElevatedButton(label: ksOurPackages.tr, onPressed: (){},buttonWidth: width-40,buttonColor: cWhiteColor.withOpacity(0.2),),
                    ),
                  ),
                      ),
                           Positioned(
                      // height: height/0.595,
                       bottom: height/6.5,
                      right: width/25,
                      child: 
                  Center(
                    child: CustomElevatedButton(label: ksSignIn.tr, onPressed: (){
                      Get.find<AuthController>().resetAuth();
                      Get.toNamed(krSignInScreen);},buttonWidth: width-40,buttonColor: cPrimaryColor2),
                  ),
                      ),
                      Positioned(
                         bottom: height/10,
                      left: width/4.5,
                      // right: width/2,
                        child: RichText(
                                text: TextSpan(
                                  text: "${ksDontHaveAnyAccount.tr} ",
                                  style: regular16TextStyle(cWhiteColor),
                                  children: [
                                    TextSpan(
                                      text: ksSignUp.tr,
                                      style: regular16TextStyle(cPrimaryColor2),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                      Get.find<AuthController>().resetAuth();
                                      Get.toNamed(krSignUpScreen);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Positioned(
                        top: 25,
                        right: 20,
                        child: InkWell(
                          onTap: (){
                            Get.offAllNamed(krHomeScreen);
                          },
                          child: Container(
                            width: 75,
                            height: 32,
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.1),
                              // color: cPrimaryColor2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text(ksSkip.tr,style: regular16TextStyle(cWhiteColor),)),
                                   kW6sizedBox,
                                 const Icon(Icons.arrow_forward_ios,size: kIconSize14,color: cWhiteColor,),
                              ],
                            ),
                            ),
                        ),
                      ),
                     
          ],
        ),
      ),
    );
  }
}