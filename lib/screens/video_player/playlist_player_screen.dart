import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
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
          () => profileController.playlistMovieList.isEmpty
              ? SizedBox(
                  height: (height),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kiSearchResultPng,
                        width: 200.w,
                        height: 200.h,
                      ),
                      Text(
                        ksNoVideoFound.tr,
                        style: medium16TextStyle(cPrimaryColor2),
                      ),
                      kH16sizedBox,
                      Text(
                        ksNoVideosFoundPleaseCheckFilter.tr,
                        style: regular14TextStyle(cWhiteColor.withOpacity(
                          0.5,
                        )),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //!youtube player
                    YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: allVideoPlayerController.youtubeController!,
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
                      padding: const EdgeInsets.only(
                          left: k20Padding, right: k20Padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 3.h),
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
                                      // profileController.playlistMovieList[profileController.selectedPlayListMovieIndex.value].imdbRating ??//!Change here
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
                                      // profileController.playlistMovieList[profileController.selectedPlayListMovieIndex.value].runtime ??//!Change here
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
                                      DateFormat('d MMM, yyyy').format(
                                          DateTime.parse(profileController
                                              .playlistMovieList[profileController.selectedPlayListMovieIndex.value].releaseDate
                                              .toString())),
                                      style: regular12TextStyle(cWhiteColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          kH16sizedBox,
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: List.generate(
                          //       allVideoPlayerController.movieTypeList.length *
                          //               2 -
                          //           1,
                          //       (index) {
                          //         if (index.isOdd) return kW8sizedBox;
                          //         final itemIndex = index ~/ 2;
                          //         final movieType = allVideoPlayerController
                          //             .movieTypeList[itemIndex];
                          //         return Container(
                          //           decoration: BoxDecoration(
                          //             border: Border.all(
                          //               width: 1,
                          //               color: cPrimaryColor2.withOpacity(0.5),
                          //             ),
                          //             borderRadius:
                          //                 BorderRadius.circular(k4BorderRadius),
                          //           ),
                          //           padding: const EdgeInsets.symmetric(
                          //             horizontal: k4Padding,
                          //             vertical: k4Padding,
                          //           ),
                          //           child: Text(
                          //             movieType,
                          //             style: regular14TextStyle(cWhiteColor),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                          kH16sizedBox,
                          Text(
                            ksTitle,
                            style: regular14TextStyle(
                              cWhiteColor.withOpacity(0.5),
                            ),
                          ),
                          kH12sizedBox,
                          Text(
                            profileController.playlistMovieList[profileController.selectedPlayListMovieIndex.value].name ?? "",
                            style: medium20TextStyle(cWhiteColor),
                          ),
                          kH12sizedBox,
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: profileController
                                          .playlistMovieList[profileController.selectedPlayListMovieIndex.value].description ??
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
                                onPressed: () {
                                  showDeletePlayListMoviePopup(
                                      context: context,
                                      movieId: profileController
                                          .playlistMovieList[profileController.selectedPlayListMovieIndex.value].id!);
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
                                  Share.share(
                                      'Share data from flixoo app! 🚀');
                                },
                              ),
                            ],
                          ),
                          // Text("hdsvg",style: semiBold16TextStyle(cWhiteColor),),
                          kH20sizedBox,
                          Container(
                            width: width,
                            // height: 100,
                            decoration: BoxDecoration(
                              color: cBlackColor2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(k20Padding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        profileController.playlistDetailsData
                                                .value?.name ??
                                            "",
                                        style: medium16TextStyle(cWhiteColor),
                                      ),
                                      profileController
                                              .isplaylistListExpand.value
                                          ? InkWell(
                                              onTap: () {
                                                profileController
                                                        .isplaylistListExpand
                                                        .value =
                                                    !profileController
                                                        .isplaylistListExpand
                                                        .value;
                                              },
                                              child: SvgPicture.asset(
                                                kiMinus,
                                                width: 10.w,
                                                height: 10.h,
                                              ))
                                          : InkWell(
                                              onTap: () {
                                                profileController
                                                        .isplaylistListExpand
                                                        .value =
                                                    !profileController
                                                        .isplaylistListExpand
                                                        .value;
                                              },
                                              child: SvgPicture.asset(
                                                kiAdd,
                                                width: 10.w,
                                                height: 10.h,
                                              )),
                                    ],
                                  ),
                                  kH10sizedBox,
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        kiPlay,
                                        color: cWhiteColor.withOpacity(0.8),
                                        width: 10.w,
                                        height: 10.h,
                                      ),
                                      kW4sizedBox,
                                      Text(
                                        "${profileController.playlistDetailsData.value?.totalVideo ?? ''} ${ksVideos.tr}",
                                        style: regular10TextStyle(cWhiteColor),
                                      ),
                                    ],
                                  ),
                                  kH16sizedBox,
                                  Divider(
                                    height: 1,
                                    color: cWhiteColor.withOpacity(0.1),
                                  ),
                                  kH16sizedBox,
                                  if (profileController
                                          .isplaylistListExpand.value ==
                                      true)
                                    ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          kH10sizedBox,
                                      itemCount: profileController
                                          .playlistMovieList.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Image.network(
                                              profileController
                                                      .playlistMovieList[index]
                                                      .thumbnail ??
                                                  "",
                                              height: 80.h,
                                              width: 150.w,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Center(
                                                child: SvgPicture.asset(
                                                  kiDummyMovie,
                                                  height: 80.h,
                                                  width: 150.w,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            kW8sizedBox,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  profileController
                                                      .playlistMovieList[index]
                                                      .id
                                                      .toString(),
                                                  style: medium14TextStyle(
                                                      cWhiteColor),
                                                ),
                                                kH4sizedBox,
                                                SizedBox(
                                                    width: width * 0.55,
                                                    child: Text(
                                                      profileController
                                                              .playlistMovieList[
                                                                  index]
                                                              .name ??
                                                          "",
                                                      style: medium14TextStyle(
                                                          cWhiteColor),
                                                    )),
                                                kH4sizedBox,
                                                Text(
                                                  // "${ksTimeDuration.tr}: ${profileController.playlistMovieList[index].runtime}",//!Change here
                                                  "",
                                                  style: medium14TextStyle(
                                                      cWhiteColor),
                                                ),
                                                kH4sizedBox,
                                                Container(
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    // color: profileController.playlistMovieList[index].isPaid == 1 ? cPrimaryColor : cWhiteColor.withOpacity(0.1),//!Change here
                                                    color: cPrimaryColor,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: k8Padding,
                                                        vertical: k2Padding),
                                                    child: Center(
                                                        child: Text(
                                                      // profileController.playlistMovieList[index].isPaid == 1 ? ksPremium.tr : ksFree.tr,//!Change here
                                                      "",
                                                      style: regular12TextStyle(
                                                          cWhiteColor),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
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

void showDeletePlayListMoviePopup(
    {required BuildContext context, required int movieId}) {
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
                  // CustomElevatedButton(
                  //   label: ksCancel.tr,
                  //   onPressed: () {
                  //     Get.back();
                  //   },
                  //   buttonWidth: 80.w,
                  //   buttonHeight: 30.h,
                  //   buttonColor: cWhiteColor.withOpacity(0.2),
                  // ),
                  // kW12sizedBox,
                  CustomElevatedButton(
                    label: ksDeleteVideo.tr,
                    onPressed: () async {
                      Get.back();
                      await Get.find<ProfileController>()
                          .deletePlaylistMovie(movieId: movieId);
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
