import 'package:flixoo_flutter_app/controllers/auth/auth_controller.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/payment/payment_controller.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/widgets/common/common_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSize.h),
          //   //* info:: appBar
          child: CustomAppBar(
            hasBackButton: false,
            title: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: profileController.selectedLanguage.value == "Arabic" ? 130 : 100,
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
            actions: [
              SvgPicture.asset(
                kiFlixoo,
                width: h24.w,
                height: h24.h,
                color: cPrimaryColor2,
              ),
              kW4sizedBox,
              Center(
                child: Text(
                  ksFlixoo.tr,
                  style: semiBold20TextStyle(cWhiteColor),
                ),
              ),
              kW12sizedBox,
            ],
          ),
        ), 
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Obx(
              () => Column(
                children: [
                  kH40sizedBox,
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
                                child: Image.network(
                                  width: 100.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                  globalController.userImage.value,
                                  errorBuilder: (context, error, stackTrace) =>
                                   const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: cPrimaryColor2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  kH20sizedBox,
                  Text(
                    "${globalController.userFirstName.value} ${globalController.userLastName.value}",
                    style: medium18TextStyle(cWhiteColor),
                  ),
                  kH6sizedBox,
                  Text(
                    globalController.userEmail.value,
                    style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),
                  ),
                  kH30sizedBox,
                  ProfileCommonWidget(
                    image: kiUser2,
                    title: ksEditProfile.tr,
                    onPressed: () {
                      profileController.firstNameTextEditingController.text = globalController.userFirstName.value;
                      profileController.lastNameTextEditingController.text = globalController.userLastName.value;
                      profileController.emailTextEditingController.text = globalController.userEmail.value;
                      profileController.phoneTextEditingController.text = globalController.userPhone.value;
                      profileController.getUserImage.value = globalController.userImage.value;
                      profileController.selectedGender.value = globalController.userGender.value=="1" ? "Male" : "Female";
                      profileController.profileImageFile.value = null;
                      profileController.profileImageLink.value = "";
                      profileController.isProfileImageChnaged.value = false;
                      Get.toNamed(krEditProfileScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiLock,
                    title: ksChangePassword.tr,
                    onPressed: () {
                      profileController. resetPassword();
                      Get.toNamed(krChangePasswordScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiLanguage,
                    title: ksLanguage.tr,
                    selectedLanguage: profileController.selectedLanguage.value,
                    onPressed: () {
                      Get.toNamed(krLanguageScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiNotification,
                    title: ksNotification.tr,
                    onPressed: () {
                      Get.toNamed(krNotificationScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiCrown,
                    title: ksSubscriptionPlan.tr,
                    selectedSubscription: profileController.profileData.value?.user.subscriptionPlan??ksFree.tr,
                    onPressed: () async{
                      await Get.find<PaymentController>().getSubscriptionPlan();
                      Get.toNamed(krSubscriptionPlanScreen);
                     await Get.find<PaymentController>().initializeInAppPurchase();
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiMoney,
                    title: ksPaymentHistory.tr,
                    onPressed: () async{
                      await Get.find<PaymentController>().getPaymentHistory();
                      Get.toNamed(krPaymentHistoryScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiMoney,
                    title: ksRentedVideo.tr,
                    onPressed: () async{
                      await profileController.getRentedVideo();
                      Get.toNamed(krRentedVideoScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiFavorite,
                    title: ksFavorite.tr,
                    onPressed: () async{
                      await profileController.getFavoriteList();
                      Get.toNamed(krFavoriteScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiAdd,
                    title: ksPlaylist.tr,
                    onPressed: () async{
                      await profileController.getPlaylistList();
                      Get.toNamed(krPlayListScreen);
                    },
                  ),
                  //! Download widget
                  // kH8sizedBox,
                  // ProfileCommonWidget(
                  //   image: kiDownload,
                  //   title: ksDownload.tr,
                  //   onPressed: () {
                  //     Get.toNamed(krDownloadListScreen);
                  //   },
                  // ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiInfo,
                    title: ksTermsAndConditions.tr,
                    onPressed: () {
                      profileController.openCommonWebView(commonUrl: Get.find<GlobalController>().termsAndConditionUrl.value);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiPrivacyPolicy,
                    title: ksPrivacyPolicy.tr,
                    onPressed: () {
                      profileController.openCommonWebView(commonUrl: Get.find<GlobalController>().privacyPolicyUrl.value);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiContactUs,
                    title: ksContactUs.tr,
                    onPressed: () {
                      Get.toNamed(krContactUsScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiFaq,
                    title: ksFaq.tr,
                    onPressed: () async{
                      profileController.selectedPaymentFaqIndex.value = -1;
                      profileController.selectedOrderFaqIndex.value = -1;
                      await profileController.getFaqList();
                      Get.toNamed(krFaqScreen);
                    },
                  ),
                  kH8sizedBox,
                  ProfileCommonWidget(
                    image: kiSettings,
                    title: ksSettings.tr,
                    onPressed: () {
                      Get.toNamed(krSettingsScreen);
                    },
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
                    onPressed: () {
                      showLogoutPopup(context);
                    },
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

class CustomBackHeader extends StatelessWidget {
  const CustomBackHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
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
                horizontal: k12Padding,
                vertical: k2Padding,
              ),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        SvgPicture.asset(
          kiFlixoo,
          width: h24.w,
          height: h24.h,
          color: cPrimaryColor2,
        ),
        kW4sizedBox,
        Text(
          ksFlixoo.tr,
          style: semiBold20TextStyle(cWhiteColor),
        ),
      ],
    );
  }
}

void showLogoutPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: k20Padding),
        backgroundColor: cBlackColor2,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: k20Padding, vertical: k30Padding),
          width: width.w,
          decoration: BoxDecoration(
            color: cBlackColor2,
            borderRadius: BorderRadius.circular(k16BorderRadius.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: h36.w,
                    height: h36.h,
                    decoration: BoxDecoration(
                      color: cWhiteColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(k10Padding),
                      child: SvgPicture.asset(
                        kiLogout,
                        color: cWhiteColor,
                      ),
                    ),
                  ),
                  kW12sizedBox,
                  Text(
                    ksLogout.tr,
                    style: semiBold18TextStyle(cWhiteColor),
                  ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        size: kIconSize20,
                        color: cWhiteColor,
                      )),
                ], 
              ),
              kH8sizedBox,
              Divider(
                thickness: 1,
                color: cWhiteColor.withOpacity(0.1),
              ),
              kH8sizedBox,
              Text(
                ksAreYouSureYouWantToLogoutNow.tr,
                style: regular16TextStyle(cWhiteColor),
              ),
              kH16sizedBox,
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    label: ksCancel.tr,
                    onPressed: () {
                      Get.back();
                    },
                    buttonWidth: 80.w,
                    buttonHeight: 36.h,
                    buttonColor: cWhiteColor.withOpacity(0.2),
                  ),
                  kW12sizedBox,
                  CustomElevatedButton(
                    label: ksLogout.tr,
                    onPressed: () {
                    Get.find<AuthController>().signOut();
                    },
                    buttonWidth: 80.w,
                    buttonHeight: 36.h,
                    buttonColor: cPrimaryColor2,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
