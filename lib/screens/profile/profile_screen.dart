import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/profile/edit_profile_screen.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/widgets/common/common_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Obx(
            () => Column(
              children: [
                kH40sizedBox,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
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
                                ksProfile.tr,
                                style: regular16TextStyle(cWhiteColor),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    SvgPicture.asset(
                      kiVidflix,
                      width: h24.w,
                      height: h24.h,
                      color: cPrimaryColor2,
                    ),
                    kW4sizedBox,
                    Text(
                      ksVidflix.tr,
                      style: semiBold20TextStyle(cWhiteColor),
                    ),
                  ],
                ),
                kH8sizedBox,
                Divider(
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH40sizedBox,
                profileController.profileImageFile.value == null
                    ? Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                backgroundColor: cWhiteColor.withOpacity(0.2),
                                child: ClipOval(
                                  child: Image.network(
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                    "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  showImageSourcePopup(context);
                                },
                                child: Container(
                                  width: 30.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cWhiteColor,
                                    border: Border.all(
                                        width: 1, color: cPrimaryColor2),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                    kiEditProfile,
                                    width: 14.w,
                                    height: 14.w,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                backgroundColor: cWhiteColor.withOpacity(0.2),
                                child: ClipOval(
                                  child: Image.file(
                                    width: 100.w,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                    profileController.profileImageFile.value!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 60.w,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                profileController.isProfileImageChnaged.value =
                                    false;
                                profileController.profileImageLink.value = "";
                                profileController.profileImageFile.value = null;
                              },
                              child: Container(
                                width: 16.w,
                                height: 16.h,
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 1, color: cRedColor),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 12,
                                  color: cRedColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                kH20sizedBox,
                Text(
                  "Angelica Mark",
                  style: medium18TextStyle(cWhiteColor),
                ),
                kH6sizedBox,
                Text(
                  "info@spagreen.net",
                  style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),
                ),
                kH30sizedBox,
                ProfileCommonWidget(
                  image: kiUser2,
                  title: ksEditProfile.tr,
                  onPressed: () {
                    Get.toNamed(krEditProfileScreen);
                  },
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiLock,
                  title: ksChangePassword.tr,
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiLanguage,
                  title: ksLanguage.tr,
                  selectedLanguage: "English (US)",
                  onPressed: () {
                    Get.toNamed(krLanguageScreen);
                  },
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiNotification,
                  title: ksNotification.tr,
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiCrown,
                  title: ksSubscriptionPlan.tr,
                  selectedSubscription: "Free",
                  onPressed: (){
                    Get.toNamed(krSubscriptionPlanScreen);
                  },
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiMoney,
                  title: ksPaymentHistory.tr,
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiFavorite,
                  title: ksFavorite.tr,
                  onPressed: (){
                    Get.toNamed(krFavoriteScreen);
                  },
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiAdd,
                  title: ksPlaylist.tr,
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiDownload,
                  title: ksDownload.tr,
                  onPressed: (){
                    Get.toNamed(krDownloadListScreen);
                  },
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiInfo,
                  title: ksTermsAndConditions.tr,
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiPrivacyPolicy,
                  title: ksPrivacyPolicy.tr,
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiContactUs,
                  title: ksContactUs.tr,
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiFaq,
                  title: ksFaq.tr,
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiSettings,
                  title: ksSettings.tr,
                  onPressed: () {},
                ),
                kH16sizedBox,
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.1),
                ),
                kH8sizedBox,
                ProfileCommonWidget(
                  image: kiLogout,
                  title: ksLogout.tr,
                  containerColor: cPrimaryColor2,
                ),
                kH8sizedBox,
                Text(
                  "Version 0.0.2",
                  style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),
                ),
                kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        width: width,
        selectedIndex: 4,
      ),
    );
  }
}

class ProfileCommonWidget extends StatelessWidget {
  const ProfileCommonWidget(
      {super.key,
      required this.image,
      required this.title,
      this.containerColor,
      this.onPressed,
      this.selectedLanguage,
      this.selectedSubscription});
  final String image, title;
  final Color? containerColor;
  final VoidCallback? onPressed;
  final String? selectedLanguage, selectedSubscription;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: cTransparentColor,
      highlightColor: cTransparentColor,
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            width: h36.w,
            height: h36.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(k8BorderRadius),
              color: containerColor ?? cWhiteColor.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(k10Padding),
              child: SvgPicture.asset(
                image,
                width: h16.w,
                height: h16.h,
                color: cWhiteColor,
              ),
            ),
          ),
          kW16sizedBox,
          Text(
            title,
            style: regular16TextStyle(cWhiteColor),
          ),
          const Expanded(child: SizedBox()),
          if (selectedLanguage != null)
            Text(
              selectedLanguage ?? "",
              style: semiBold14TextStyle(cWhiteColor),
            ),
          if (selectedLanguage != null) kW16sizedBox,
          if (selectedSubscription != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: cWhiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: k10Padding, vertical: k4Padding),
                child: Text(
                  selectedSubscription ?? "",
                  style: regular14TextStyle((cBlackColor3)),
                ),
              ),
            ),
          if (selectedSubscription != null) kW16sizedBox,
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: kIconSize16,
            color: cWhiteColor,
          ),
        ],
      ),
    );
  }
}
