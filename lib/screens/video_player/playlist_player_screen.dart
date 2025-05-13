import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlaylistVideoPlayerScreen extends StatelessWidget {
  PlaylistVideoPlayerScreen({super.key});
  final AllVideoPlayerController allVideoPlayerController =
      Get.find<AllVideoPlayerController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!youtube player
              YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: allVideoPlayerController.youtubeController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      player,
                      const SizedBox(),
                    ],
                  );
                },
              ),
              //!Flick player
              // AspectRatio(
              //   aspectRatio: 16 / 9,
              //   child: FlickVideoPlayer(
              //     flickManager: allVideoPlayerController.flickManager,
              //   ),
              // ),
              kH20sizedBox,
              Padding(
                padding: const EdgeInsets.only(left: k20Padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: cAmberColor,
                                size: kIconSize16,
                              ),
                              kW6sizedBox,
                              Text(
                                profileController
                                        .playlistMovieList[0].imdbRating ??
                                    "",
                                style: regular12TextStyle(cWhiteColor),
                              ),
                              kW6sizedBox,
                              SizedBox(
                                height: 22.h,
                                child: VerticalDivider(
                                  width: 1,
                                  thickness: 1,
                                  color: cWhiteColor.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          kW6sizedBox,
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_filled_sharp,
                                color: cPrimaryColor2,
                                size: kIconSize20,
                              ),
                              kW6sizedBox,
                              Text(
                                 profileController
                                        .playlistMovieList[0].runtime ??
                                    "",
                                style: regular12TextStyle(cWhiteColor),
                              ),
                              kW6sizedBox,
                              SizedBox(
                                height: 22.h,
                                child: VerticalDivider(
                                  width: 1,
                                  thickness: 1,
                                  color: cWhiteColor.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          kW6sizedBox,
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                color: cPrimaryColor2,
                                size: kIconSize20,
                              ),
                              kW6sizedBox,
                              Text(
                                DateFormat('d MMM, yyyy').format(DateTime.parse(
                                     profileController
                                        .playlistMovieList[0].release
                                        .toString())),
                                style: regular12TextStyle(cWhiteColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    kH16sizedBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          allVideoPlayerController.movieTypeList.length * 2 - 1,
                          (index) {
                            if (index.isOdd) return kW8sizedBox;
                            final itemIndex = index ~/ 2;
                            final movieType = allVideoPlayerController
                                .movieTypeList[itemIndex];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: cPrimaryColor2.withOpacity(0.5),
                                ),
                                borderRadius:
                                    BorderRadius.circular(k4BorderRadius),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: k4Padding,
                                vertical: k4Padding,
                              ),
                              child: Text(
                                movieType,
                                style: regular14TextStyle(cWhiteColor),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    kH16sizedBox,
                    Text(
                      ksTitle,
                      style: regular14TextStyle(
                        cWhiteColor.withOpacity(0.5),
                      ),
                    ),
                    kH12sizedBox,
                    Text(
                       profileController
                                        .playlistMovieList[0].title ?? "",
                      style: medium20TextStyle(cWhiteColor),
                    ),
                    kH12sizedBox,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:  profileController
                                        .playlistMovieList[0].description ??
                                "",
                            style: regular14TextStyle(
                                cWhiteColor.withOpacity(0.5)),
                          ),
                          // if(homeController.movieDetailsData.value!.description.toString().length>200)
                          // TextSpan(
                          //   // text: "Read More",
                          //   text: "\n${homeController.movieDetailsData.value!.description.toString().length}",
                          //   style: regular14TextStyle(cWhiteColor),
                          //   recognizer: TapGestureRecognizer()
                          //     ..onTap = () {
                          //       ll('Read More tapped');
                          //     },
                          // ),
                        ],
                      ),
                    ),
                    kH16sizedBox,
                    Row(
                      children: [
                        const CommonContainer(
                          image: kiCrown,
                        ),
                        kW10sizedBox,
                        const CommonContainer(
                          image: kiFavorite,
                        ),
                        kW10sizedBox,
                         CommonContainer(
                          image: kiMinus,
                          onPressed: (){
                            showDeletePlayListMoviePopup(context: context,movieId:  profileController
                                        .playlistMovieList[0].id!);
                          },
                        ),
                        kW10sizedBox,
                        const CommonContainer(
                          image: kiDownload,
                        ),
                        kW10sizedBox,
                        CommonContainer(
                          image: kiShare,
                          onPressed: () {
                            Share.share('Share data from vidflix app! 🚀');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //!Comment Widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                child: Column(
                  children: [
                    kH20sizedBox,
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: cWhiteColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(k6BorderRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: k16Padding, vertical: k20Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "10 Comments",
                              style: medium16TextStyle(cWhiteColor),
                            ),
                            // kW36sizedBox,
                            Text(
                              "${ksSubmitRating.tr}:",
                              style: regular16TextStyle(cWhiteColor),
                            ),
                            //!temporary(this is not valid)
                            const Row(
                              children: [
                                Icon(
                                  Icons.star_border,
                                  size: kIconSize16,
                                  color: cWhiteColor,
                                ),
                                Icon(
                                  Icons.star_border,
                                  size: kIconSize16,
                                  color: cWhiteColor,
                                ),
                                Icon(
                                  Icons.star_border,
                                  size: kIconSize16,
                                  color: cWhiteColor,
                                ),
                                Icon(
                                  Icons.star_border,
                                  size: kIconSize16,
                                  color: cWhiteColor,
                                ),
                                Icon(
                                  Icons.star_border,
                                  size: kIconSize16,
                                  color: cWhiteColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    kH20sizedBox,
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: cWhiteColor.withOpacity(0.2),
                            child: ClipOval(
                              child: Image.network(
                                  width: 40.w,
                                  height: 40.h,
                                  fit: BoxFit.cover,
                                  "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D"),
                            ),
                          ),
                        ),
                        kW12sizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Saikat Ahmmed",
                                  style: medium16TextStyle(cWhiteColor),
                                ),
                                kW6sizedBox,
                                Container(
                                  width: 6.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cGreyColor.withOpacity(0.8),
                                  ),
                                ),
                                kW6sizedBox,
                                Icon(
                                  Icons.access_time,
                                  color: cGreyColor.withOpacity(0.8),
                                  size: kIconSize16,
                                ),
                                kW6sizedBox,
                                Text(
                                  "2 years ago",
                                  style: regular10TextStyle(
                                      cGreyColor.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            kH10sizedBox,
                            SizedBox(
                              width: width - 96,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_outline,
                                    color: cWhiteColor,
                                    size: kIconSize20,
                                  ),
                                  kW6sizedBox,
                                  Text(
                                    "100K",
                                    style: regular12TextStyle(
                                        cGreyColor.withOpacity(0.8)),
                                  ),
                                  kW12sizedBox,
                                  SizedBox(
                                    height: h8.h,
                                    child: VerticalDivider(
                                      width: 1,
                                      thickness: 1,
                                      color: cWhiteColor.withOpacity(0.14),
                                    ),
                                  ),
                                  kW12sizedBox,
                                  SvgPicture.asset(
                                    kiMessage,
                                    width: 14.w,
                                    height: 14.h,
                                    color: cWhiteColor,
                                  ),
                                  kW6sizedBox,
                                  Text(
                                    "10k replies",
                                    style: regular12TextStyle(
                                        cGreyColor.withOpacity(0.8)),
                                  ),
                                  kW6sizedBox,
                                  const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: cWhiteColor,
                                    size: kIconSize20,
                                  ),
                                  //  Spacer(),
                                  Expanded(child: SizedBox()),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        kiReply,
                                        width: 16.w,
                                        height: 16.h,
                                        color: cPrimaryColor2,
                                      ),
                                      kW14sizedBox,
                                      Text(
                                        ksReply.tr,
                                        style:
                                            regular16TextStyle(cPrimaryColor2),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    kH12sizedBox,
                    Padding(
                      padding: EdgeInsets.only(left: 52.w),
                      child: SizedBox(
                        width: width - 72,
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1,
                              color: cWhiteColor.withOpacity(0.14),
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet consectetur. Eget dictum at ipsum ridiculus nec. Viverra mauris molestie ut rhoncus.",
                              style: regular14TextStyle(cWhiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    kH20sizedBox,
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: cWhiteColor.withOpacity(0.2),
                            child: ClipOval(
                              child: Image.network(
                                  width: 40.w,
                                  height: 40.h,
                                  fit: BoxFit.cover,
                                  "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D"),
                            ),
                          ),
                        ),
                        kW12sizedBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Saikat Ahmmed",
                                  style: medium16TextStyle(cWhiteColor),
                                ),
                                kW6sizedBox,
                                Container(
                                  width: 6.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cGreyColor.withOpacity(0.8),
                                  ),
                                ),
                                kW6sizedBox,
                                Icon(
                                  Icons.access_time,
                                  color: cGreyColor.withOpacity(0.8),
                                  size: kIconSize16,
                                ),
                                kW6sizedBox,
                                Text(
                                  "2 years ago",
                                  style: regular10TextStyle(
                                      cGreyColor.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            kH10sizedBox,
                            SizedBox(
                              width: width - 96,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_outline,
                                    color: cWhiteColor,
                                    size: kIconSize20,
                                  ),
                                  kW6sizedBox,
                                  Text(
                                    "100K",
                                    style: regular12TextStyle(
                                        cGreyColor.withOpacity(0.8)),
                                  ),
                                  kW12sizedBox,
                                  SizedBox(
                                    height: h8.h,
                                    child: VerticalDivider(
                                      width: 1,
                                      thickness: 1,
                                      color: cWhiteColor.withOpacity(0.14),
                                    ),
                                  ),
                                  kW12sizedBox,
                                  SvgPicture.asset(
                                    kiMessage,
                                    width: 14.w,
                                    height: 14.h,
                                    color: cWhiteColor,
                                  ),
                                  kW6sizedBox,
                                  Text(
                                    "10k replies",
                                    style: regular12TextStyle(
                                        cGreyColor.withOpacity(0.8)),
                                  ),
                                  kW6sizedBox,
                                  const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: cWhiteColor,
                                    size: kIconSize20,
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        kiReply,
                                        width: 16.w,
                                        height: 16.h,
                                        color: cPrimaryColor2,
                                      ),
                                      kW14sizedBox,
                                      Text(
                                        ksReply.tr,
                                        style:
                                            regular16TextStyle(cPrimaryColor2),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    kH12sizedBox,
                    Padding(
                      padding: EdgeInsets.only(left: 52.w),
                      child: SizedBox(
                        width: width - 72,
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1,
                              color: cWhiteColor.withOpacity(0.14),
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet consectetur. Eget dictum at ipsum ridiculus nec. Viverra mauris molestie ut rhoncus.",
                              style: regular14TextStyle(cWhiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    kH12sizedBox,
                    Divider(
                      thickness: 1,
                      color: cWhiteColor.withOpacity(0.14),
                    ),
                    kH20sizedBox,
                    Text(
                      ksAddYourComment.tr,
                      style: medium16TextStyle(cWhiteColor),
                    ),
                    kH20sizedBox,
                    CustomModifiedTextField(
                      hint: ksEnterHere.tr,
                      controller:
                          profileController.addCommentTextEditingController,
                      fillColor: cBlackColor,
                      textInputStyle: regular14TextStyle(cWhiteColor),
                      focusBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(k6BorderRadius),
                        borderSide: const BorderSide(
                          width: 1,
                          color: cPrimaryColor2,
                        ),
                      ),
                      maxLines: 4,
                      inputAction: TextInputAction.newline,
                      inputType: TextInputType.multiline,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(k6BorderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: cWhiteColor.withOpacity(0.3),
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    kH12sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 34.w,
                          height: 34.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(k6BorderRadius),
                            color: cWhiteColor.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: SvgPicture.asset(
                              kiEmoji,
                              width: 16.w,
                              height: 16.h,
                              color: cWhiteColor,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            CustomElevatedButton(
                              label: ksCancel.tr,
                              onPressed: () {},
                              buttonColor: cWhiteColor.withOpacity(0.1),
                              textStyle: regular16TextStyle(cWhiteColor),
                              buttonWidth: 70.w,
                              buttonHeight: h36.h,
                            ),
                            kW12sizedBox,
                            CustomElevatedButton(
                              label: ksPostNow.tr,
                              onPressed: () {},
                              buttonColor: cPrimaryColor2,
                              textStyle: regular16TextStyle(cWhiteColor),
                              buttonWidth: 90.w,
                              buttonHeight: h36.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                    kH20sizedBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void showDeletePlayListMoviePopup({required BuildContext context,required int movieId}) {
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
                    ksDeleteVideo.tr,
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
                ksAreYouSureYouDeleteThisVideo.tr,
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
                    label: ksDeleteVideo.tr,
                    onPressed: () async{
                      Get.back();
                      await Get.find<ProfileController>().deletePlaylistMovie(movieId: movieId);
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
