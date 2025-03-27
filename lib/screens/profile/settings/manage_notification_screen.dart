import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/utils/custom_app_bar.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class ManageNotificationScreen extends StatelessWidget {
  ManageNotificationScreen({super.key});
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
              width: 190,
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
                      ksManageNotification.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            SvgPicture.asset(
              kiVidflix,
              width: h24.w,
              height: h24.h,
              color: cPrimaryColor2,
            ),
            kW4sizedBox,
            Center(
              child: Text(
                ksVidflix.tr,
                style: semiBold20TextStyle(cWhiteColor),
              ),
            ),
            kW12sizedBox,
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        child: Column(
          children: [
            kH16sizedBox,
            ManageNotificationContentRow(titleText: ksGeneralNotification,switchState: profileController.generalNotificationState,),
            kH12sizedBox,
            ManageNotificationContentRow(titleText: ksNewRelease,switchState: profileController.newReleaseState,),
            kH12sizedBox,
            ManageNotificationContentRow(titleText: ksPaymentNotification,switchState: profileController.paymentNotificationState,),
            kH12sizedBox,
            ManageNotificationContentRow(titleText: ksAppUpdate,switchState: profileController.appUpdateState,),
            kH12sizedBox,
            ManageNotificationContentRow(titleText: ksSubscription,switchState: profileController.subscriptionState,),
          ],
        ),
      ),
    );
  }
}

class ManageNotificationContentRow extends StatelessWidget {
  ManageNotificationContentRow({super.key, required this.titleText,required this.switchState});
  final ProfileController profileController = Get.find<ProfileController>();
  final String titleText;
  final RxBool switchState;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            Container(
              width: 3.w,
              height: 3.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: cGreyBoxColor2,
              ),
            ),
            kW12sizedBox,
            Text(
              titleText.tr,
              style: regular16TextStyle(cWhiteColor),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                switchState.value =
                    !switchState.value;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 36.w,
                height: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: switchState.value
                      ? cPrimaryColor2
                      : cWhiteColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: switchState.value
                          ? k0Padding
                          : 3,
                      right: switchState.value
                          ? 3
                          : k0Padding),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    alignment: switchState.value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 14.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: switchState.value
                            ? cWhiteColor
                            : cWhiteColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // }),
          ],
        ));
  }
}
