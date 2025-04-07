import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/profile/settings/manage_notification_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class ManageDownloadScreen extends StatelessWidget {
 ManageDownloadScreen({super.key});
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
              width: 180,
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
                      ksManageDownload.tr,
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
          ],
        ),
      ),
            body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        child: Column(
          children: [
            kH16sizedBox,
            ManageNotificationContentRow(titleText: ksWifiOnly.tr,switchState: profileController.wifiOnlyState,),
            kH12sizedBox,
            Row(
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
            InkWell(
              onTap: (){
                Get.toNamed(krVideoQualityScreen);
              },
              child: Text(
                ksVideoQuality.tr,
                style: regular16TextStyle(cWhiteColor),
              ),
            ),
            const Expanded(child: SizedBox()),
             const Icon(
            Icons.arrow_forward_ios_rounded,
            size: kIconSize16,
            color: cWhiteColor,
          ),

          ],
        ),
        kH12sizedBox,
          Row(
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
            InkWell(
              onTap: (){
                showDeleteAllPopup(context);
              },
              child: Text(
                ksDeleteAllDownload.tr,
                style: regular16TextStyle(cWhiteColor),
              ),
            ),
          ],
        ),
          ],
        ),
      ),
    );
  }
}


void showDeleteAllPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: k20Padding),
        backgroundColor: cBlackColor2,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: k20Padding, vertical: k25Padding),
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
                      child: SvgPicture.asset(kiDelete,color: cWhiteColor,),
                    ),
                  ),
                  kW12sizedBox,
                   Text(
                ksDeleteAllDownload.tr,
                style: semiBold18TextStyle(cWhiteColor),
              ),
              const Expanded(child: SizedBox()),
               InkWell(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.close,size: kIconSize20,color: cWhiteColor,)),
                ],
              ),
              kH8sizedBox,
              Divider(
              thickness: 1,
              color: cWhiteColor.withOpacity(0.1),
             ),
             kH8sizedBox,
             Text(ksAreYouSureYouDeleteAllVideo,style: regular16TextStyle(cWhiteColor),),
             kH16sizedBox,
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
             CustomElevatedButton(label: ksCancel.tr, onPressed: (){Get.back();},buttonWidth: 80.w,buttonHeight: 30.h,buttonColor: cWhiteColor.withOpacity(0.2),),
             kW12sizedBox,
             CustomElevatedButton(label: ksDeleteAll.tr, onPressed: (){Get.back();},buttonWidth: 110.w,buttonHeight: 30.h,buttonColor: cPrimaryColor2,),
              ],
             ),
            ],
          ),
        ),
      );
    },
  );
}