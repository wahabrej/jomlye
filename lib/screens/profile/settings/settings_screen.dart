import 'package:vidflix_flutter_app/screens/profile/profile_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/utils/custom_app_bar.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
       appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSize.h),
        //* info:: appBar
          child: CustomAppBar(
            hasBackButton: false,
            title:  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 100,
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
                                ksSettings.tr,
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
              ProfileCommonWidget(
                    image: kiNotification,
                    title: ksManageNotification.tr,
                    onPressed: () {
                      Get.toNamed(krManageNotificationScreen);
                    },
                  ),
                  kH16sizedBox,
                    ProfileCommonWidget(
                    image: kiDownload,
                    title: ksManageDownload.tr,
                    onPressed: () {
                      Get.toNamed(krManageDownloadScreen);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}