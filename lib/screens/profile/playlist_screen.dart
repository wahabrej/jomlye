import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class PlayListScreen extends StatelessWidget {
  PlayListScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              width: 100.w,
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
                      ksPlaylist.tr,
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
            kW20sizedBox,
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                thickness: 1,
                color: cWhiteColor.withOpacity(0.2),
              ),
              kH16sizedBox,
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(() => InkWell(
                      onTap: ()async{
                        profileController.selectedPlayListId.value = profileController.playlistList[index].id??-1;
                        await profileController.getPlaylisMovieList(playListId: profileController.playlistList[index].id??-1);
                        if(profileController.playlistList.isNotEmpty){
                        profileController.selectedPlayListMovieIndex.value = 0;
                        await Get.find<HomeController>().getMovieDetails(movieId: profileController.playlistList[index].id.toString());
                                    Get.find<HomeController>().resetRatingData();
                                        await Get.find<HomeController>().getMovieDetails(
                                        movieId: profileController.playlistList[index].id
                                            .toString());
                                    profileController.isFavoriteAdded.value = Get.find<HomeController>().movieDetailsData.value?.isFavorite??false;
                                    Get.find<HomeController>().selectedServer.value = 0;
                                    if(Get.find<HomeController>().movieServerList.isNotEmpty ){
                                   Get.find<AllVideoPlayerController>().videoPlayerFunction(isFree: Get.find<HomeController>().movieDetailsData.value?.isFree==1?true:false,isRental: Get.find<HomeController>().movieDetailsData.value?.isRental==1?true:false,isRented: Get.find<HomeController>().movieDetailsModel.value?.isRented, isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value, fileUrl: Get.find<HomeController>().movieServerList[0]?.fileUrl, fileSource: Get.find<HomeController>().movieServerList[0]?.fileSource);
                                    }
                                 if(Get.find<GlobalController>().subscribedUserCheck.value==false){
                                    Get.find<HomeController>().showInterstitialAd();
                                    }
                        }
                        Get.toNamed(krPlaylistPlayerScreen);
                      },
                      child: PlayListWidget(
                            image:
                                profileController.playlistList[index].thumbnail ??
                                    "",
                            name:
                                profileController.playlistList[index].name ?? "",
                            videoCount: profileController
                                    .playlistList[index].totalVideo ??
                                0,
                            onPressed: () {
                              profileController
                                      .editPlayListTextEditingController.text =
                                  profileController.playlistList[index].name ??
                                      "";
                              profileController.selectedPlayListId.value =
                                  profileController.playlistList[index].id ?? -1;
                              Get.find<GlobalController>().commonBottomSheet(
                                context: context,
                                content: PlayListBottomSheetContent(),
                                onPressCloseButton: () {
                                  Get.back();
                                },
                                onPressRightButton: () {},
                                rightText: "",
                                rightTextStyle: medium14TextStyle(cWhiteColor),
                                title: ksPlaylist.tr,
                                isRightButtonShow: false,
                                bottomSheetColor: cBlackColor2,
                                bottomSheetHeight: height * 0.12.h,
                                isTitleShow: false,
                              );
                            },
                          ),
                    ));
                  },
                  separatorBuilder: (context, index) => kH16sizedBox,
                  itemCount: profileController.playlistList.length)
            ],
          ),
        ),
      ),
    );
  }
}

class PlayListWidget extends StatelessWidget {
  const PlayListWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.videoCount,
      this.onPressed});
  final String image, name;
  final int? videoCount;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(k8BorderRadius),
            child: Image.network(
              image,
              width: width - 40,
              height: 225.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => SizedBox(
                width: width,
                child: SvgPicture.asset(
                  kiDummyMovie,
                  height: 225.h,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
            )),
        kH16sizedBox,
        Text(
          name,
          style: medium16TextStyle(cWhiteColor),
        ),
        kH10sizedBox,
        Row(
          children: [
            SvgPicture.asset(
              kiPlay,
              color: cGreyColor,
            ),
            kW8sizedBox,
            if (videoCount != null)
              Text(
                "$videoCount Videos",
                style: regular14TextStyle(cGreyColor.withOpacity(0.8)),
              ),
            const Expanded(child: SizedBox()),
            InkWell(
                splashColor: cTransparentColor,
                highlightColor: cTransparentColor,
                onTap: onPressed,
                child: const Icon(
                  Icons.more_vert,
                  color: cWhiteColor,
                  size: kIconSize20,
                )),
          ],
        ),
      ],
    );
  }
}

class PlayListBottomSheetContent extends StatelessWidget {
  PlayListBottomSheetContent({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            kH8sizedBox,
            ListView.separated(
                separatorBuilder: (context, index) => kH8sizedBox,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profileController.playListValueList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      profileController.selectedPlayListValue.value =
                          profileController.playListValueList[index]["title"];
                      Get.back();
                      if (profileController.selectedPlayListValue.value ==
                          ksEdit.tr) {
                        showEditPlayListPopup(context);
                      }
                      if (profileController.selectedPlayListValue.value ==
                          ksDelete.tr) {
                        showDeletePlayListPopup(context);
                      }
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: k20Padding),
                      child: Row(
                        children: [
                          Icon(
                            profileController.playListValueList[index]["icon"],
                            size: kIconSize16,
                            color: cWhiteColor,
                          ),
                          kW8sizedBox,
                          Padding(
                            padding: const EdgeInsets.all(k8Padding),
                            child: Text(
                              profileController.playListValueList[index]
                                  ["title"],
                              style: medium14TextStyle(cWhiteColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ));
  }
}

void showEditPlayListPopup(BuildContext context) {
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
                      child: SvgPicture.asset(
                        kiEdit,
                        color: cWhiteColor,
                      ),
                    ),
                  ),
                  kW12sizedBox,
                  Text(
                    ksEditPlaylist.tr,
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
              SizedBox(
                height: 40.h,
                child: CustomModifiedTextField(
                  controller: Get.find<ProfileController>()
                      .editPlayListTextEditingController,
                  hint: ksEditPlaylist.tr,
                  contentPadding: const EdgeInsets.all(8),
                  fillColor: cBlackColor,
                  textInputStyle: regular14TextStyle(cWhiteColor),
                  focusBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(k6BorderRadius),
                    borderSide: const BorderSide(
                      width: 1,
                      color: cPrimaryColor2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(k6BorderRadius),
                    borderSide: BorderSide(
                      width: 1,
                      color: cWhiteColor.withOpacity(0.3),
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
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
                    buttonHeight: 30.h,
                    buttonColor: cWhiteColor.withOpacity(0.2),
                  ),
                  kW12sizedBox,
                  CustomElevatedButton(
                    label: ksSave.tr,
                    onPressed: () async {
                      Get.back();
                      await Get.find<ProfileController>().editPlaylist();
                    },
                    buttonWidth: 110.w,
                    buttonHeight: 30.h,
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

void showDeletePlayListPopup(BuildContext context) {
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
                      child: SvgPicture.asset(
                        kiDelete,
                        color: cWhiteColor,
                      ),
                    ),
                  ),
                  kW12sizedBox,
                  Text(
                    ksDeletePlaylist.tr,
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
                ksAreYouSureYouDeleteThisPlaylist.tr,
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
                    buttonHeight: 30.h,
                    buttonColor: cWhiteColor.withOpacity(0.2),
                  ),
                  kW12sizedBox,
                  CustomElevatedButton(
                    label: ksDeletePlaylist.tr,
                    onPressed: () async{
                      Get.back();
                      await Get.find<ProfileController>().deletePlaylist();
                    },
                    buttonWidth: 110.w,
                    buttonHeight: 30.h,
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
