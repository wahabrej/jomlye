import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class DownloadListScreen extends StatelessWidget {
  DownloadListScreen({super.key});
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
                kH8sizedBox,
              //   ListView.separated(
              //     padding: const EdgeInsets.all(k0Padding),
              //     separatorBuilder: (context, index) => kH16sizedBox,
              //     itemCount: profileController.downloadedMovieList.length,
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return CommonMovieListWidget(
              //         movieImage: profileController.downloadedMovieList[index]
              //             ["movieImage"],
              //         movieName: profileController.downloadedMovieList[index]
              //             ["movieName"],
              //         movieDuration: profileController.downloadedMovieList[index]
              //             ["movieDuration"],
              //         movieSize: profileController.downloadedMovieList[index]
              //             ["movieSize"],
              //         movieTagList: profileController.downloadedMovieList[index]
              //             ["movieTagList"],
              //             deleteonPressed: (){
              //   showDeleteDownloadPopup(context);
              // },
              //       );
              //     },
              //   ),
                kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommonMovieListWidget extends StatelessWidget {
  const CommonMovieListWidget(
      {super.key,
      required this.movieImage,
      this.movieTagList,
      required this.movieName,
      required this.movieDuration,
      required this.movieSize, this.deleteonPressed});
  final String movieImage, movieName, movieDuration, movieSize;
  final List? movieTagList;
  final VoidCallback? deleteonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(k4BorderRadius),
            child: Image.network(
              movieImage,
              width: 150.w,
              height: 90.h,
              fit: BoxFit.cover,
            )),
            kW12sizedBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (int i = 0; i < movieTagList!.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: k6Padding),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cWhiteColor.withOpacity(0.2),
                          border: Border.all(
                              width: 1, color: cPrimaryColor2.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(k4BorderRadius.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: k8Padding, vertical: k2Padding),
                          child: Text(
                            movieTagList?[i],
                            style: regular12TextStyle(cWhiteColor),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              kH4sizedBox,
              Text(movieName,
                  style: medium14TextStyle(cWhiteColor),
                  overflow: TextOverflow.clip),
              kH4sizedBox,
              Text(movieDuration,
                  style: regular8TextStyle(cWhiteColor.withOpacity(0.7)),
                  overflow: TextOverflow.clip),
              kH6sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomElevatedButton(
                    label: movieSize,
                    onPressed: () {},
                    buttonColor: cPrimaryColor2,
                    buttonWidth: 100.w,
                    buttonHeight: 20.h,
                  ),
                ],
              ),
            ],
          ),
        ),
        kW12sizedBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: deleteonPressed,
              child: Container(
                width: h36.w,
                height: h36.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(k8BorderRadius),
                  color: cWhiteColor.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(k10Padding),
                  child: SvgPicture.asset(kiDelete),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}



void showDeleteDownloadPopup(BuildContext context) {
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
                ksDeleteVideo.tr,
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
             Text(ksAreYouSureYouDeleteThisVideo,style: regular16TextStyle(cWhiteColor),),
             kH16sizedBox,
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
             CustomElevatedButton(label: ksCancel.tr, onPressed: (){Get.back();},buttonWidth: 80.w,buttonHeight: 30.h,buttonColor: cWhiteColor.withOpacity(0.2),),
             kW12sizedBox,
             CustomElevatedButton(label: ksDeleteVideo.tr, onPressed: (){Get.back();},buttonWidth: 110.w,buttonHeight: 30.h,buttonColor: cPrimaryColor2,),
              ],
             ),
            ],
          ),
        ),
      );
    },
  );
}



void showDeleteNotificationPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: k20Padding),
        backgroundColor: cBlackColor2,
        child: Container(
          constraints: BoxConstraints(maxWidth: width.w * 0.9),
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
                      child: SvgPicture.asset(kiNotification,color: cWhiteColor,),
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
             kH8sizedBox,
             Text(ksAreYouSureYouDeleteThisNotification.tr,style: regular16TextStyle(cWhiteColor),),
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