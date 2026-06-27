import 'package:flick_video_player/flick_video_player.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlaylistVideoPlayerScreen extends StatefulWidget {
  const PlaylistVideoPlayerScreen({
    super.key,
  });

  @override
  State<PlaylistVideoPlayerScreen> createState() =>
      _PlaylistVideoPlayerScreenState();
}

class _PlaylistVideoPlayerScreenState extends State<PlaylistVideoPlayerScreen> {
  final AllVideoPlayerController allVideoPlayerController =
      Get.find<AllVideoPlayerController>();

  final ProfileController profileController = Get.find<ProfileController>();

  final HomeController homeController = Get.find<HomeController>();

  @override
  void dispose() {
    ll("Dispose from video player screen");
    if (Get.find<GlobalController>().userToken.value != "") {
      homeController.watchHistoryStore(
          watchableType: 'movie',
          watchableId: homeController.movieDetailsData.value?.id ?? -1,
          // duration: homeController.movieServerList[homeController.selectedServer.value].,
          duration: Get.find<AllVideoPlayerController>()
              .totalSeconds
              .value
              .toString(),
          watchedSeconds: Get.find<AllVideoPlayerController>()
              .currentSeconds
              .value
              .toString());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await allVideoPlayerController.handlePlayerBack();
      },
      child: Scaffold(
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
                      kH40sizedBox,
                      Builder(
                        builder: (_) {
                          final movieData =
                              homeController.movieDetailsData.value;
                          final movieModel =
                              homeController.movieDetailsModel.value;
                          final serverList = homeController.movieServerList;
                          final selectedServerIndex =
                              homeController.selectedServer.value;
                          final selectedServer = serverList.isNotEmpty
                              ? serverList[selectedServerIndex]
                              : null;
                          final globalController = Get.find<GlobalController>();

                          // ✅ CASE 1: No server or invalid video URL → show poster
                          if (serverList.isEmpty ||
                              selectedServer?.fileUrl == null ||
                              selectedServer?.fileUrl!.isEmpty == true) {
                            return SizedBox(
                              width: width,
                              height: 200,
                              child: Image.network(
                                movieData?.poster ?? "",
                                errorBuilder: (context, error, stackTrace) {
                                  return SvgPicture.asset(
                                    kiDummyMovie,
                                    width: width - 40,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            );
                          }

                          // ✅ CASE 2: Restricted content (not free or not rented while rentable)
                          else if ((movieData?.isFree == 0 &&
                                  globalController.subscribedUserCheck.value ==
                                      false) ||
                              (movieModel?.isRented == false &&
                                  (movieData?.isRental == 1 ? true : false))) {
                            return SizedBox(
                              width: width,
                              height: 200.h,
                              child: Image.network(
                                movieData?.poster ?? "",
                                fit: BoxFit.cover,
                              ),
                            );
                          }

                          // ✅ CASE 3: YouTube video player
                          else if (selectedServer?.fileSource?.toLowerCase() ==
                              "youtube") {
                            return YoutubePlayer(
                              controller:
                                  allVideoPlayerController.youtubeController,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                              onReady: () {
                                allVideoPlayerController.youtubeController
                                    .seekTo(Duration.zero);
                              },
                              bottomActions: const [
                                SizedBox(width: 14.0),
                                CurrentPosition(),
                                kW8sizedBox,
                                ProgressBar(
                                  isExpanded: true,
                                  colors: ProgressBarColors(
                                    playedColor: cPrimaryColor,
                                    handleColor: cPrimaryColor,
                                  ),
                                ),
                                kW8sizedBox,
                                RemainingDuration(),
                                SizedBox(width: 14.0),
                                FullScreenButton(color: cPrimaryColor),
                              ],
                            );
                          }

                          // ✅ CASE 4: Regular Flick player (non-YouTube / non-GDrive)
                          else if (selectedServer?.fileSource?.toLowerCase() !=
                                  "youtube" &&
                              selectedServer?.fileSource?.toLowerCase() !=
                                  "gdrive" &&
                              ((movieModel?.isRented == true &&
                                      (movieData?.isRental == 1
                                          ? true
                                          : false)) ||
                                  movieData?.isFree == 1 ||
                                  (globalController.subscribedUserCheck.value ==
                                          true &&
                                      (movieModel?.isRented == false &&
                                          (movieData?.isRental == 1
                                              ? true
                                              : false))))) {
                            return AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Stack(
                                children: [
                                  FlickVideoPlayer(
                                    flickManager:
                                        allVideoPlayerController.flickManager,
                                  ),
                                  Positioned(
                                    top: 12,
                                    left: 12,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final canPop =
                                            await allVideoPlayerController
                                                .handlePlayerBack();
                                        if (canPop) {
                                          Get.back();
                                        }
                                      },
                                      child: Container(
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(7),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                              size: kIconSize16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          // ✅ CASE 5: Fallback → poster placeholder
                          else {
                            return SizedBox(
                              width: width,
                              height: 200,
                              child: SvgPicture.asset(
                                kiDummyMovie,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                      ),
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
                                        profileController
                                                .playlistMovieList[
                                                    profileController
                                                        .selectedPlayListMovieIndex
                                                        .value]
                                                .imdbRating ??
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
                                                .playlistMovieList[
                                                    profileController
                                                        .selectedPlayListMovieIndex
                                                        .value]
                                                .runtime ??
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
                                      if ((profileController
                                              .playlistMovieList[
                                                  profileController
                                                      .selectedPlayListMovieIndex
                                                      .value]
                                              .releaseDate !=
                                          null))
                                        Text(
                                          DateFormat('d MMM, yyyy').format(
                                              DateTime.parse(profileController
                                                  .playlistMovieList[
                                                      profileController
                                                          .selectedPlayListMovieIndex
                                                          .value]
                                                  .releaseDate
                                                  .toString())),
                                          style:
                                              regular12TextStyle(cWhiteColor),
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
                              homeController.movieDetailsData.value?.title ??
                                  "",
                              style: medium20TextStyle(cWhiteColor),
                            ),
                            kH12sizedBox,
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: profileController
                                            .playlistMovieList[profileController
                                                .selectedPlayListMovieIndex
                                                .value]
                                            .description ??
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
                            kH16sizedBox,
                            Row(
                              children: [
                                CommonContainer(
                                  image: kiCrown,
                                  onPressed: null,
                                  containerColor: (homeController
                                                  .movieDetailsData
                                                  .value
                                                  ?.isFree ==
                                              0 &&
                                          homeController.movieDetailsData.value
                                                  ?.isRental ==
                                              1)
                                      ? cPrimaryColor
                                      : cWhiteColor.withOpacity(0.2),
                                ),
                                kW10sizedBox,
                                CommonContainer(
                                  image: kiFavorite,
                                  containerColor:
                                      profileController.isFavoriteAdded.value
                                          ? cPrimaryColor2
                                          : null,
                                  onPressed: () async {
                                    if (Get.find<GlobalController>()
                                            .userToken
                                            .value ==
                                        "") {
                                      showSnackBar(
                                          title: "Error",
                                          message:
                                              "Please Login first then add favourite",
                                          color: cRedColor);
                                    } else {
                                      profileController.isFavoriteAdded.value =
                                          !profileController
                                              .isFavoriteAdded.value;
                                      await profileController
                                          .favoriteAddOrRemove(
                                              id: homeController
                                                      .movieDetailsData
                                                      .value
                                                      ?.id ??
                                                  -1,
                                              type: "movie");
                                    }
                                  },
                                ),
                                kW10sizedBox,
                                CommonContainer(
                                  image: kiAdd,
                                  onPressed: () async {
                                    if (Get.find<GlobalController>()
                                            .userToken
                                            .value ==
                                        "") {
                                      showSnackBar(
                                          title: "Error",
                                          message:
                                              "Please Login first then add favourite",
                                          color: cRedColor);
                                    } else {
                                      profileController.moviePlayListIds.addAll(
                                          homeController.movieDetailsModel.value
                                                  ?.playlistIds ??
                                              []);
                                      for (int i = 0;
                                          i <
                                              profileController
                                                  .playlistList.length;
                                          i++) {
                                        final currentId =
                                            Get.find<ProfileController>()
                                                .playlistList[i]
                                                .id
                                                .toString();
                                        final bool exists =
                                            Get.find<HomeController>()
                                                .playlistIdsList
                                                .any((element) =>
                                                    currentId.contains(
                                                        element.toString()));
                                        Get.find<ProfileController>()
                                            .temporaryPlayListCheckBoxStateList
                                            .add(exists);
                                      }
                                      showSaveVideoToPlayListPopup(
                                          context,
                                          homeController
                                                  .movieDetailsData.value?.id ??
                                              -1);
                                    }
                                  },
                                ),
                                kW10sizedBox,
                                CommonContainer(
                                  image: kiDownload,
                                  containerColor: homeController
                                              .movieDetailsModel
                                              .value
                                              ?.download
                                              ?.isDownloadable ==
                                          0
                                      ? cWhiteColor.withOpacity(0.1)
                                      : null,
                                  iconColor: homeController
                                              .movieDetailsModel
                                              .value
                                              ?.download
                                              ?.isDownloadable ==
                                          0
                                      ? cWhiteColor.withOpacity(0.2)
                                      : null,
                                  onPressed: homeController
                                              .movieDetailsModel
                                              .value
                                              ?.download
                                              ?.isDownloadable ==
                                          1
                                      ? () {
                                          showDownloadVideoPopup(context);
                                        }
                                      : null,
                                ),
                                kW10sizedBox,
                                CommonContainer(
                                  image: kiShare,
                                  onPressed: () {
                                    Share.share(homeController
                                            .movieServerList[homeController
                                                .selectedServer.value]
                                            ?.fileUrl ??
                                        "");
                                  },
                                ),
                              ],
                            ),

                            if (homeController.movieServerList.isNotEmpty)
                              kH16sizedBox,
                            if (homeController.movieServerList.isNotEmpty)
                              SizedBox(
                                width: width - 60 / 3,
                                height: 40.h,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      kW10sizedBox,
                                  itemCount:
                                      homeController.movieServerList.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() => InkWell(
                                          onTap: () async {
                                            homeController
                                                .selectedServer.value = index;
                                            if (homeController
                                                .movieServerList.isNotEmpty) {
                                              allVideoPlayerController
                                                  .videoPlayerFunction(
                                                isFree: homeController
                                                            .movieDetailsData
                                                            .value
                                                            ?.isFree ==
                                                        1
                                                    ? true
                                                    : false,
                                                isRental: (homeController
                                                                .movieDetailsData
                                                                .value
                                                                ?.isFree ==
                                                            0 &&
                                                        homeController
                                                                .movieDetailsData
                                                                .value
                                                                ?.isRental ==
                                                            1)
                                                    ? true
                                                    : false,
                                                isRented: homeController
                                                    .movieDetailsModel
                                                    .value
                                                    ?.isRented,
                                                isSubscribed:
                                                    Get.find<GlobalController>()
                                                        .subscribedUserCheck
                                                        .value,
                                                fileUrl: homeController
                                                    .movieServerList[
                                                        homeController
                                                            .selectedServer
                                                            .value]
                                                    ?.fileUrl,
                                                fileSource: homeController
                                                    .movieServerList[
                                                        homeController
                                                            .selectedServer
                                                            .value]
                                                    ?.fileSource,
                                                seekToPosition: 0,
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: (width - 50) / 3,
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      k6BorderRadius),
                                              color: homeController
                                                          .selectedServer
                                                          .value ==
                                                      index
                                                  ? cPrimaryColor
                                                  : cWhiteColor
                                                      .withOpacity(0.2),
                                            ),
                                            child: Center(
                                                child: Text(
                                              homeController
                                                      .movieServerList[index]
                                                      ?.label ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              style: medium14TextStyle(
                                                  cWhiteColor),
                                            )),
                                          ),
                                        ));
                                  },
                                ),
                              ),

                            kH16sizedBox,
                            Padding(
                              padding: const EdgeInsets.only(right: k20Padding),
                              child: Divider(
                                thickness: 1,
                                color: cWhiteColor.withOpacity(0.2),
                              ),
                            ),
                            kH20sizedBox,
                            Container(
                              width: width,
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
                                          style:
                                              regular10TextStyle(cWhiteColor),
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
                                        separatorBuilder: (context, index) =>
                                            kH10sizedBox,
                                        itemCount: profileController
                                            .playlistMovieList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () async {
                                              ll("here here");
                                              homeController.resetRatingData();
                                              homeController
                                                  .resetBottomSheetData();
                                              await homeController
                                                  .getMovieDetails(
                                                      movieId: profileController
                                                          .playlistMovieList[
                                                              index]
                                                          .id!
                                                          .toString());
                                              if (homeController
                                                  .movieServerList.isNotEmpty) {
                                                allVideoPlayerController.videoPlayerFunction(
                                                    isFree: homeController.movieDetailsData.value?.isFree == 1
                                                        ? true
                                                        : false,
                                                    isRental: homeController.movieDetailsData.value?.isFree ==
                                                                0 &&
                                                            homeController
                                                                    .movieDetailsData
                                                                    .value
                                                                    ?.isRental ==
                                                                1
                                                        ? true
                                                        : false,
                                                    isRented: homeController
                                                        .movieDetailsModel
                                                        .value
                                                        ?.isRented,
                                                    isSubscribed:
                                                        Get.find<GlobalController>()
                                                            .subscribedUserCheck
                                                            .value,
                                                    fileUrl: homeController
                                                        .movieServerList[0]
                                                        ?.fileUrl,
                                                    fileSource: homeController
                                                        .movieServerList[0]
                                                        ?.fileSource);
                                              }
                                              Get.offUntil(
                                                GetPageRoute(
                                                  page: () =>
                                                      PlaylistVideoPlayerScreen(),
                                                ),
                                                ModalRoute.withName(
                                                    krPlayListScreen),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  profileController
                                                          .playlistMovieList[
                                                              index]
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
                                                          .playlistMovieList[
                                                              index]
                                                          .id
                                                          .toString(),
                                                      style: medium14TextStyle(
                                                          cWhiteColor),
                                                    ),
                                                    kH4sizedBox,
                                                    SizedBox(
                                                        width: width * 0.3,
                                                        child: Text(
                                                          profileController
                                                                  .playlistMovieList[
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          style:
                                                              medium14TextStyle(
                                                                  cWhiteColor),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                    kH4sizedBox,
                                                    Text(
                                                      // "${ksTimeDuration.tr}: ${profileController.playlistMovieList[index].runtime}",//!Change here
                                                      profileController
                                                              .playlistMovieList[
                                                                  index]
                                                              .runtime ??
                                                          ""
                                                              "",
                                                      style: medium14TextStyle(
                                                          cWhiteColor),
                                                    ),
                                                    kH4sizedBox,
                                                    // Container(
                                                    //   height: 20.h,
                                                    //   decoration: BoxDecoration(
                                                    //     borderRadius:
                                                    //         BorderRadius.circular(
                                                    //             2),
                                                    //     // color: profileController.playlistMovieList[index].isPaid == 1 ? cPrimaryColor : cWhiteColor.withOpacity(0.1),//!Change here
                                                    //     color: cPrimaryColor,
                                                    //   ),
                                                    //   child: Padding(
                                                    //     padding: const EdgeInsets
                                                    //         .symmetric(
                                                    //         horizontal: k8Padding,
                                                    //         vertical: k2Padding),
                                                    //     child: Center(
                                                    //         child: Text(
                                                    //       // profileController.playlistMovieList[index].isPaid == 1 ? ksPremium.tr : ksFree.tr,//!Change here
                                                    //       "",
                                                    //       style: regular12TextStyle(
                                                    //           cWhiteColor),
                                                    //     )),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    kH20sizedBox,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      kH40sizedBox,
                    ],
                  ),
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
