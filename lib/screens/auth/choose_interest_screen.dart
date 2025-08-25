import 'package:flixoo_flutter_app/controllers/auth/auth_controller.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class ChooseInterestScreen extends StatelessWidget {
  ChooseInterestScreen({super.key});
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                kH20sizedBox,
                Text(
                  ksChooseYourInterest,
                  style: semiBold20TextStyle(cWhiteColor),
                ),
                kH12sizedBox,
                Text(
                  "${ksPersonalizeYourExperienceBySelectingYourFavoriteMovie.tr}.",
                  style: regular14TextStyle(cWhiteColor.withOpacity(0.8)),
                ),
                kH20sizedBox,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.6,
                  ),
                  itemCount: authController.interestList.length,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            if (authController.selectedInterestIdList.contains(
                                authController.interestList[index].id)) {
                              authController.selectedInterestIdList.remove(
                                  authController.interestList[index].id);
                              authController.selectedInterestList.remove(
                                  authController.interestList[index].title);
                            } else {
                              authController.selectedInterestIdList.add(
                                  authController.interestList[index].id);
                              authController.selectedInterestList.add(
                                  authController.interestList[index].title);
                            }
                          },
                          child: Container(
                            width: (width - 72) / 3,
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(k4BorderRadius),
                              border: Border.all(
                                  width: 1,
                                  color: authController.selectedInterestIdList
                                          .contains(authController
                                              .interestList[index].id)
                                      ? cPrimaryColor2
                                      : cBlackColor),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              authController.interestList[index].title,
                              style: regular14TextStyle(cWhiteColor),
                            ),
                          ),
                        ));
                  },
                ),
               
               
                kH20sizedBox,
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH20sizedBox,
                Row(
                  children: [
                    CustomElevatedButton(
                      label: ksSkip.tr,
                      onPressed: () {
                        Get.toNamed(krEditProfileScreen);
                      },
                      buttonWidth: (width - 56) / 2,
                      buttonHeight: kButtonHeight.h,
                      buttonColor: cWhiteColor.withOpacity(0.2),
                    ),
                    kW16sizedBox,
                    CustomElevatedButton(
                      label: ksContinue.tr,
                      onPressed: () async{
                        await authController.interestStore();
                        // Get.toNamed(krEditProfileScreen);
                      },
                      buttonWidth: (width - 56) / 2,
                      buttonHeight: kButtonHeight.h,
                      buttonColor: cPrimaryColor2,
                    ),
                  ],
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
