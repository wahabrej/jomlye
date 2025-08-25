import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/screens/profile/download_list_screen.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Column(
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
                                ksDownloadList.tr,
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
                ),
                kH8sizedBox,
                Divider(
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH8sizedBox,
                ListView.separated(
                  padding: const EdgeInsets.all(k0Padding),
                  separatorBuilder: (context, index) => kH16sizedBox,
                  itemCount: profileController.notificationMovieList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CommonMovieListWidget(
                      movieImage: profileController.notificationMovieList[index]
                          ["movieImage"],
                      movieName: profileController.notificationMovieList[index]
                          ["movieName"],
                      movieDuration: profileController
                          .notificationMovieList[index]["movieDuration"],
                      movieSize: profileController.notificationMovieList[index]
                          ["movieSize"],
                      movieTagList: profileController
                          .notificationMovieList[index]["movieTagList"],
                      deleteonPressed: () {
                        showNotificationDeletePopup(context);
                      },
                    );
                  },
                ),
                kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}




void showNotificationDeletePopup(BuildContext context) {
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
                ksDeleteNotification.tr,
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
            //  kH8sizedBox,
             Text(ksAreYouSureYouDeleteThisNotification,style: regular16TextStyle(cWhiteColor),),
             kH16sizedBox,
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
             CustomElevatedButton(label: ksCancel.tr, onPressed: (){Get.back();},buttonWidth: 80.w,buttonHeight: 30.h,buttonColor: cWhiteColor.withOpacity(0.2),),
             kW12sizedBox,
             CustomElevatedButton(label: ksDelete.tr, onPressed: (){Get.back();},buttonWidth: 80.w,buttonHeight: 30.h,buttonColor: cPrimaryColor2,),
              ],
             ),
            ],
          ),
        ),
      );
    },
  );
}
