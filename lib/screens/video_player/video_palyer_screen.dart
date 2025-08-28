import 'package:flick_video_player/flick_video_player.dart';
import 'package:flixoo_flutter_app/screens/profile/payment_method_screen.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/screens/home/home_screen.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/utils/custom_checkbox.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, this.isRentableVideo = false});

  final bool? isRentableVideo;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final AllVideoPlayerController allVideoPlayerController =
      Get.find<AllVideoPlayerController>();

  final HomeController homeController = Get.find<HomeController>();

  final ProfileController profileController = Get.find<ProfileController>();
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
        try {
          allVideoPlayerController.youtubeController.dispose();
        } catch (_) {}
        try {
          allVideoPlayerController.flickManager.dispose();
        } catch (_) {}
        return true;
      },
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH40sizedBox,
                if (homeController.movieServerList.isEmpty)
                  SizedBox(
                    width: width,
                    height: 200,
                    child: Image.network(
                      homeController.movieDetailsData.value?.poster ?? "",
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                          kiDummyMovie,
                          width: width - 40,
                          height: 200,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                if ((homeController.movieDetailsData.value?.isFree == 0 &&
                        Get.find<GlobalController>()
                                .subscribedUserCheck
                                .value ==
                            false) ||
                    (homeController.movieDetailsModel.value?.isRented ==
                            false &&
                        widget.isRentableVideo == true))
                  SizedBox(
                    width: width,
                    height: 200.h,
                    child: Image.network(
                      homeController.movieDetailsData.value?.poster ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                if (homeController.movieServerList.isNotEmpty &&
                    homeController
                            .movieServerList[
                                homeController.selectedServer.value]
                            ?.fileSource ==
                        "youtube")
                  YoutubePlayer(
                    controller: allVideoPlayerController.youtubeController,
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
                  ),
                // //!flick video player
                if ((homeController.movieServerList.isNotEmpty &&
                        homeController
                                .movieServerList[
                                    homeController.selectedServer.value]
                                ?.fileSource !=
                            "youtube" &&
                        homeController
                                .movieServerList[
                                    homeController.selectedServer.value]
                                ?.fileSource
                                .toString()
                                .toLowerCase() !=
                            "gdrive" &&
                        (homeController.movieDetailsModel.value?.isRented ==
                                true &&
                            widget.isRentableVideo == true)) ||
                    homeController.movieDetailsData.value?.isFree == 1 || (Get.find<GlobalController>()
                                                  .subscribedUserCheck
                                                  .value==true && (homeController.movieDetailsModel.value?.isRented ==
                                false &&
                            widget.isRentableVideo == false)))
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        FlickVideoPlayer(
                          flickManager: allVideoPlayerController.flickManager,
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: GestureDetector(
                            onTap: () {
                              try {
                                allVideoPlayerController.youtubeController
                                    .dispose();
                              } catch (_) {}
                              try {
                                allVideoPlayerController.flickManager.dispose();
                              } catch (_) {}
                              Get.back();
                            },
                            child: Container(
                              width: 24,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(7),
                                  child: const Icon(
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
                  ),
                kH20sizedBox,
                Padding(
                  padding: const EdgeInsets.only(left: k20Padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            Padding(
  padding: EdgeInsets.only(right: 6.w, top: 3.h, bottom: 3.h),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      if (homeController.movieDetailsModel.value?.isRented == true)
        Flexible(
          flex: 2,
          child: Container(
            width: 120.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: cWhiteColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(k4BorderRadius),
              border: Border.all(
                width: 0.65,
                color: cWhiteColor.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k4Padding),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cPurpleColor,
                      borderRadius: BorderRadius.circular(k4BorderRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: k8Padding, vertical: k4Padding),
                      child: Text(
                        ksRented.tr,
                        style: regular10TextStyle(cWhiteColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "$ksExpire: ${homeController.rentalVideoData.value?.expireData.toString()}",
                    style: regular10TextStyle(cWhiteColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      if (homeController.movieDetailsModel.value?.isRented == true)
        kW6sizedBox,
      
      // Wrap the remaining content in Expanded to handle overflow
      Expanded(
        flex: 3,
        child: Row(
          children: [
            // Star Rating Row
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: cAmberColor,
                    size: kIconSize16,
                  ),
                  kW6sizedBox,
                  Flexible(
                    child: Text(
                      homeController.movieDetailsData.value?.imdbRating ?? "",
                      style: regular12TextStyle(cWhiteColor),
                      overflow: TextOverflow.ellipsis,
                    ),
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
            ),
            kW6sizedBox,
            
            // Runtime Row
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.access_time_filled_sharp,
                    color: cPrimaryColor2,
                    size: kIconSize20,
                  ),
                  kW6sizedBox,
                  Flexible(
                    child: Text(
                      homeController.movieDetailsData.value?.runtime ?? "",
                      style: regular12TextStyle(cWhiteColor),
                      overflow: TextOverflow.ellipsis,
                    ),
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
            ),
            kW6sizedBox,
            
            // Date Row
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: cPrimaryColor2,
                    size: kIconSize20,
                  ),
                  kW6sizedBox,
                  Flexible(
                    child: Text(
                      DateFormat('d MMM, yyyy').format(
                          DateTime.parse(homeController
                              .movieDetailsData.value!.release
                              .toString())),
                      style: regular12TextStyle(cWhiteColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                            homeController.movieDetailsModel.value!.videoTags!
                                        .length *
                                    2 -
                                1,
                            (index) {
                              if (index.isOdd) return kW8sizedBox;
                              final itemIndex = index ~/ 2;
                              final movieType = homeController.movieDetailsModel
                                  .value?.videoTags?[itemIndex];
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
                                  movieType ?? "",
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
                        homeController.movieDetailsData.value?.title ?? "",
                        style: medium20TextStyle(cWhiteColor),
                      ),
                      kH12sizedBox,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: homeController
                                      .movieDetailsData.value?.description ??
                                  "",
                              style: regular14TextStyle(
                                  cWhiteColor.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                      kH16sizedBox,
                      Row(
                        children: [
                          CommonContainer(
                            image: kiCrown,
                            onPressed: null,
                            containerColor:
                                homeController.movieDetailsData.value?.isFree ==
                                            0 &&
                                        widget.isRentableVideo == false
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
                                    !profileController.isFavoriteAdded.value;
                                await profileController.favoriteAddOrRemove(
                                    id: homeController
                                            .movieDetailsData.value?.id ??
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
                                    i < profileController.playlistList.length;
                                    i++) {
                                  final currentId =
                                      Get.find<ProfileController>()
                                          .playlistList[i]
                                          .id
                                          .toString();
                                  final bool exists = Get.find<HomeController>()
                                      .playlistIdsList
                                      .any((element) => currentId
                                          .contains(element.toString()));
                                  Get.find<ProfileController>()
                                      .temporaryPlayListCheckBoxStateList
                                      .add(exists);
                                }
                                showSaveVideoToPlayListPopup(
                                    context,
                                    homeController.movieDetailsData.value?.id ??
                                        -1);
                              }
                            },
                          ),
                          kW10sizedBox,
                          CommonContainer(
                            image: kiDownload,
                            containerColor: homeController.movieDetailsModel
                                        .value?.download?.isDownloadable ==
                                    0
                                ? cWhiteColor.withOpacity(0.1)
                                : null,
                            iconColor: homeController.movieDetailsModel.value
                                        ?.download?.isDownloadable ==
                                    0
                                ? cWhiteColor.withOpacity(0.2)
                                : null,
                            onPressed: homeController.movieDetailsModel.value
                                        ?.download?.isDownloadable ==
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
                                      .movieServerList[
                                          homeController.selectedServer.value]
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
                            physics: const AlwaysScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => kW10sizedBox,
                            itemCount: homeController.movieServerList.length,
                            itemBuilder: (context, index) {
                              return Obx(() => InkWell(
                                    onTap: () async {
                                      homeController.selectedServer.value =
                                          index;
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
                                          isRental: widget.isRentableVideo,
                                          isRented: homeController
                                              .movieDetailsModel
                                              .value
                                              ?.isRented,
                                          isSubscribed:
                                              Get.find<GlobalController>()
                                                  .subscribedUserCheck
                                                  .value,
                                          fileUrl: homeController
                                              .movieServerList[homeController
                                                  .selectedServer.value]
                                              ?.fileUrl,
                                          fileSource: homeController
                                              .movieServerList[homeController
                                                  .selectedServer.value]
                                              ?.fileSource,
                                          seekToPosition: 0,
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: (width - 50) / 3,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            k6BorderRadius),
                                        color: homeController
                                                    .selectedServer.value ==
                                                index
                                            ? cPrimaryColor
                                            : cWhiteColor.withOpacity(0.2),
                                      ),
                                      child: Center(
                                          child: Text(
                                        homeController.movieServerList[index]
                                                ?.label ??
                                            "",
                                        textAlign: TextAlign.center,
                                        style: medium14TextStyle(cWhiteColor),
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
                      //! For rental video this widget(RentProductDetailsContentContainer)
                      if (widget.isRentableVideo == true) kH16sizedBox,
                      if (widget.isRentableVideo == true && homeController.movieDetailsModel.value?.isRented==false)
                        RentProductDetailsContentContainer(
                          rentPrice:
                              homeController.rentalVideoData.value?.price ?? "",
                          rentValidity:
                              homeController.rentalVideoData.value?.validity ??
                                  "",
                          rentExpireDate: homeController
                                  .rentalVideoData.value?.expireData
                                  .toString() ??
                              "",
                              id: homeController.movieDetailsData.value?.id.toString(),
                              videoType: "movie",
                        ),
                      kH12sizedBox,
                      Container(
                        width: width - 40,
                        height: 46.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: cWhiteColor.withOpacity(0.1),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: k4Padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                homeController.movieDetailsTabs.length,
                                (index) {
                              return GestureDetector(
                                onTap: () async {
                                  homeController.videoDetailsChangeTab(index);
                                  if (homeController
                                          .movietSelectedIndex.value ==
                                      3) {
                                    await homeController.getUserReview(
                                        reviewableId: homeController
                                            .movieDetailsModel
                                            .value!
                                            .details!
                                            .id!,
                                        reviewableType: "movie");
                                  }
                                },
                                child: Obx(() => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: homeController
                                                    .movietSelectedIndex
                                                    .value ==
                                                index
                                            ? Colors.grey[800]
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: (width - 40) /
                                                  homeController
                                                      .movieDetailsTabs.length -
                                              14.w,
                                        ),
                                        child: Text(
                                          homeController
                                              .movieDetailsTabs[index],
                                          style:
                                              regular14TextStyle(cWhiteColor),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )),
                              );
                            }),
                          ),
                        ),
                      ),

                      kH12sizedBox,
                      if (homeController.movietSelectedIndex.value == 0)
                        SizedBox(
                          width: width - 20,
                          height: 50.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => kW8sizedBox,
                            itemCount: homeController.movieCastList.length,
                            itemBuilder: (context, index) {
                              return VideoDetailsContentWidget(
                                imageUrl: homeController
                                        .movieCastList[index]?.starImage ??
                                    "",
                                title: homeController
                                        .movieCastList[index]?.starName ??
                                    "",
                                subTitle: homeController
                                        .movieCastList[index]?.starType ??
                                    "",
                                onPressed: () async {
                                  await homeController.getArtistDetails(
                                      homeController.movieCastList[index]?.id);
                                  homeController.castSelectedIndex.value = 0;
                                  Get.toNamed(krCastDetailsScreen);
                                },
                              );
                            },
                          ),
                        ),
                      if (homeController.movietSelectedIndex.value == 1)
                        SizedBox(
                          width: width - 20,
                          height: 50.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => kW8sizedBox,
                            itemCount: homeController.movieDirectorList.length,
                            itemBuilder: (context, index) {
                              return VideoDetailsContentWidget(
                                imageUrl: homeController
                                        .movieDirectorList[index]?.starImage ??
                                    "",
                                title: homeController
                                        .movieDirectorList[index]?.starName ??
                                    "",
                                subTitle: homeController
                                        .movieDirectorList[index]?.starType ??
                                    "",
                                onPressed: () async {
                                  await homeController.getArtistDetails(
                                      homeController
                                          .movieDirectorList[index]?.id);
                                  homeController.castSelectedIndex.value = 0;
                                  Get.toNamed(krCastDetailsScreen);
                                },
                              );
                            },
                          ),
                        ),
                      if (homeController.movietSelectedIndex.value == 2)
                        SizedBox(
                          width: width - 20,
                          height: 50.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => kW8sizedBox,
                            itemCount: homeController.movieWriterList.length,
                            itemBuilder: (context, index) {
                              return VideoDetailsContentWidget(
                                imageUrl: homeController
                                        .movieWriterList[index]?.starImage ??
                                    "",
                                title: homeController
                                        .movieWriterList[index]?.starName ??
                                    "",
                                subTitle: homeController
                                        .movieWriterList[index]?.starType ??
                                    "",
                                onPressed: () async {
                                  await homeController.getArtistDetails(
                                      homeController
                                          .movieWriterList[index]?.id);
                                  homeController.castSelectedIndex.value = 0;
                                  Get.toNamed(krCastDetailsScreen);
                                },
                              );
                            },
                          ),
                        ),
                      if (homeController.movietSelectedIndex.value == 3)
                        Padding(
                          padding: const EdgeInsets.only(right: k20Padding),
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: cWhiteColor.withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.circular(k8BorderRadius),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: k12Padding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${homeController.movieReviewList.length} ${ksReviews.tr}",
                                        style: semiBold14TextStyle(cWhiteColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        ksSubmitRating.tr,
                                        style: regular14TextStyle(cWhiteColor),
                                      ),
                                      kW4sizedBox,
                                      Row(
                                        children: List.generate(5, (index) {
                                          return GestureDetector(
                                            onTap: () => homeController
                                                .updateRating(index + 1),
                                            child: Icon(
                                              Icons.star,
                                              size: kIconSize16,
                                              color: index <
                                                      homeController
                                                          .rating.value
                                                  ? cAmberColor
                                                  : Colors.grey,
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              kH16sizedBox,
                              CustomModifiedTextField(
                                hint: ksEnterHere.tr,
                                controller: homeController
                                    .addCommentTextEditingController,
                                fillColor: cBlackColor,
                                textInputStyle: regular14TextStyle(cWhiteColor),
                                focusBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(k6BorderRadius),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: cPrimaryColor2,
                                  ),
                                ),
                                maxLines: 4,
                                inputAction: TextInputAction.newline,
                                inputType: TextInputType.multiline,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(k6BorderRadius),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // CustomElevatedButton(
                                  //   label: ksCancel.tr,
                                  //   onPressed: () {},
                                  //   buttonColor: cWhiteColor.withOpacity(0.1),
                                  //   textStyle: regular14TextStyle(cWhiteColor),
                                  //   buttonWidth: 70.w,
                                  //   buttonHeight: h32.h,
                                  // ),
                                  // kW12sizedBox,
                                  CustomElevatedButton(
                                    label: ksPostNow.tr,
                                    onPressed: () async {
                                      await homeController.userRating(
                                        reviewableId: homeController
                                            .movieDetailsModel
                                            .value!
                                            .details!
                                            .id!,
                                        reviewableType: "movie",
                                      );
                                    },
                                    buttonColor: cPrimaryColor2,
                                    textStyle: regular14TextStyle(cWhiteColor),
                                    buttonWidth: 90.w,
                                    buttonHeight: h32.h,
                                  ),
                                ],
                              ),
                              kH12sizedBox,
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(k0Padding),
                                separatorBuilder: (context, index) =>
                                    kH8sizedBox,
                                itemCount:
                                    homeController.movieReviewList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              cWhiteColor.withOpacity(0.2),
                                          child: ClipOval(
                                            child: Image.network(
                                              width: 40.w,
                                              height: 40.h,
                                              fit: BoxFit.cover,
                                              homeController
                                                      .movieReviewList[index]
                                                      ?.user
                                                      ?.profileImage ??
                                                  "",
                                            ),
                                          ),
                                        ),
                                      ),
                                      kW12sizedBox,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                homeController
                                                        .movieReviewList[index]
                                                        ?.user
                                                        ?.userName ??
                                                    "",
                                                style: medium16TextStyle(
                                                    cWhiteColor),
                                              ),
                                              kW6sizedBox,
                                              Container(
                                                width: 6.w,
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: cGreyColor
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              kW6sizedBox,
                                              Icon(
                                                Icons.access_time,
                                                color:
                                                    cGreyColor.withOpacity(0.8),
                                                size: kIconSize16,
                                              ),
                                              kW6sizedBox,
                                              Text(
                                                homeController
                                                        .movieReviewList[index]
                                                        ?.createdAt ??
                                                    "",
                                                style: regular10TextStyle(
                                                    cGreyColor
                                                        .withOpacity(0.8)),
                                              ),
                                            ],
                                          ),
                                          kH10sizedBox,
                                          Obx(() => SizedBox(
                                                width: width - 96,
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        homeController
                                                                .movieReviewList[
                                                                    index]!
                                                                .isLiked!
                                                                .value =
                                                            !homeController
                                                                .movieReviewList[
                                                                    index]!
                                                                .isLiked!
                                                                .value;
                                                        if (homeController
                                                                .movieReviewList[
                                                                    index]!
                                                                .isLiked!
                                                                .value ==
                                                            true) {
                                                          homeController
                                                              .movieReviewList[
                                                                  index]!
                                                              .totalLikes!
                                                              .value++;
                                                        }
                                                        if (homeController
                                                                .movieReviewList[
                                                                    index]!
                                                                .isLiked!
                                                                .value ==
                                                            false) {
                                                          homeController
                                                              .movieReviewList[
                                                                  index]!
                                                              .totalLikes!
                                                              .value--;
                                                        }
                                                        await homeController
                                                            .reviewLikeToggle(
                                                                reviewId: homeController
                                                                    .movieReviewList[
                                                                        index]!
                                                                    .id!);
                                                      },
                                                      child: Icon(
                                                        homeController
                                                                    .movieReviewList[
                                                                        index]!
                                                                    .isLiked!
                                                                    .value ==
                                                                true
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_outline,
                                                        color: homeController
                                                                    .movieReviewList[
                                                                        index]!
                                                                    .isLiked!
                                                                    .value ==
                                                                true
                                                            ? cPrimaryColor
                                                            : cWhiteColor,
                                                        size: kIconSize20,
                                                      ),
                                                    ),
                                                    kW6sizedBox,
                                                    Text(
                                                      homeController
                                                              .movieReviewList[
                                                                  index]
                                                              ?.totalLikes
                                                              ?.value
                                                              .toString() ??
                                                          "",
                                                      style: regular12TextStyle(
                                                          cGreyColor
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          kH10sizedBox,
                                          Text(
                                            homeController
                                                    .movieReviewList[index]
                                                    ?.review ??
                                                "",
                                            style:
                                                medium12TextStyle(cWhiteColor),
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

                      kH16sizedBox,
                      // Text(
                      //   ksRelatedVideos.tr,
                      //   style: medium16TextStyle(cWhiteColor),
                      // ),
                      HomeTitleContent(
                        title: ksRelatedVideos.tr,
                        subtitleText: homeController.relatedMovieList.isNotEmpty
                            ? ksViewAll.tr
                            : "",
                        onPressed: () async {
                          homeController.resetBottomSheetData();
                          profileController.temporaryPlayListCheckBoxStateList
                              .clear();
                          homeController.isViewAllSearchEnable.value = false;
                          homeController.viewAllTextEditingController.clear();
                          homeController.selectedTitle.value = ksRelatedVideos;
                          await homeController.getMovieList(
                              movieType: "related");
                          homeController.isHomeGenreClicked.value = false;
                          Get.toNamed(krMovieViewAllScreen);
                        },
                      ),
                      kH16sizedBox,
                      Row(
                        children: [
                          SizedBox(
                            width: width - 20,
                            height: 150.h,
                            child: ListView.separated(
                              itemCount: homeController.relatedMovieList.length,
                              separatorBuilder: (context, index) =>
                                  kW10sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Obx(() => InkWell(
                                      onTap: () async {
                                        homeController.resetRatingData();
                                        homeController.resetBottomSheetData();
                                        await homeController.getMovieDetails(
                                            movieId: homeController
                                                .relatedMovieList[index].id!
                                                .toString());
                                        if (homeController
                                            .movieServerList.isNotEmpty) {
                                          allVideoPlayerController.videoPlayerFunction(
                                              isFree: homeController.relatedMovieList[index].isFree == 1
                                                  ? true
                                                  : false,
                                              isRental:
                                                  homeController.relatedMovieList[index].isFree ==
                                                              0 &&
                                                          homeController.relatedMovieList[index].isRental ==
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
                                                  .movieServerList[0]?.fileUrl,
                                              fileSource: homeController
                                                  .movieServerList[0]
                                                  ?.fileSource);
                                        }
                                        Get.offUntil(
                                          GetPageRoute(
                                            page: () => VideoPlayerScreen(
                                              isRentableVideo: homeController
                                                          .relatedMovieList[
                                                              index]
                                                          .isFree ==
                                                      0 &&
                                                  homeController
                                                          .relatedMovieList[
                                                              index]
                                                          .isRental ==
                                                      1,
                                            ),
                                          ),
                                          ModalRoute.withName(krHomeScreen),
                                        );
                                      },
                                      child: MovieContentContainer(
                                        movieImage: homeController
                                            .relatedMovieList[index].thumbnail,
                                        isPremium: homeController
                                                        .relatedMovieList[index]
                                                        .isFree ==
                                                    0 &&
                                                homeController
                                                        .relatedMovieList[index]
                                                        .isRental ==
                                                    0
                                            ? true
                                            : false,
                                        isRentable: homeController
                                                        .relatedMovieList[index]
                                                        .isFree ==
                                                    0 &&
                                                homeController
                                                        .relatedMovieList[index]
                                                        .isRental ==
                                                    1
                                            ? true
                                            : false,
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                      kH16sizedBox,
                      HomeTitleContent(
                        title: ksRecommendedMovies.tr,
                        subtitleText:
                            homeController.recommendedMoviesList.isNotEmpty
                                ? ksViewAll.tr
                                : "",
                        onPressed: () async {
                          homeController.resetBottomSheetData();
                          profileController.temporaryPlayListCheckBoxStateList
                              .clear();
                          homeController.isViewAllSearchEnable.value = false;
                          homeController.viewAllTextEditingController.clear();
                          homeController.selectedTitle.value =
                              ksRecommendedMovies;
                          await homeController.getMovieList(
                              movieType: "recommended");
                          homeController.isHomeGenreClicked.value = false;
                          Get.toNamed(krMovieViewAllScreen);
                        },
                      ),
                      kH16sizedBox,
                      Row(
                        children: [
                          SizedBox(
                            width: width - 20,
                            height: 150.h,
                            child: ListView.separated(
                              itemCount:
                                  homeController.recommendedMovieList.length,
                              separatorBuilder: (context, index) =>
                                  kW10sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Obx(() => InkWell(
                                      onTap: () async {
                                        homeController.resetRatingData();
                                        homeController.resetBottomSheetData();
                                        await homeController.getMovieDetails(
                                            movieId: homeController
                                                .recommendedMovieList[index].id!
                                                .toString());
                                        if (homeController
                                            .movieServerList.isNotEmpty) {
                                          allVideoPlayerController.videoPlayerFunction(
                                              isFree: homeController.recommendedMovieList[index].isFree == 1
                                                  ? true
                                                  : false,
                                              isRental:
                                                  homeController.recommendedMovieList[index].isFree ==
                                                              0 &&
                                                          homeController.recommendedMovieList[index].isRental ==
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
                                                  .movieServerList[0]?.fileUrl,
                                              fileSource: homeController
                                                  .movieServerList[0]
                                                  ?.fileSource);
                                        }
                                        Get.offNamedUntil(
                                          krVideoPlayerScreen,
                                          ModalRoute.withName(krHomeScreen),
                                          arguments: {
                                            "isRentableVideo": homeController
                                                        .recommendedMovieList[
                                                            index]
                                                        .isFree ==
                                                    0 &&
                                                homeController
                                                        .recommendedMovieList[
                                                            index]
                                                        .isRental ==
                                                    1
                                          },
                                        );
                                      },
                                      child: MovieContentContainer(
                                        movieImage: homeController
                                                .recommendedMovieList[index]
                                                .thumbnail ??
                                            "",
                                        isPremium: (homeController
                                                        .recommendedMovieList[
                                                            index]
                                                        .isFree ==
                                                    0 &&
                                                homeController
                                                        .recommendedMovieList[
                                                            index]
                                                        .isRental ==
                                                    0)
                                            ? true
                                            : false,
                                        isRentable: (homeController
                                                        .recommendedMovieList[
                                                            index]
                                                        .isFree ==
                                                    0 &&
                                                homeController
                                                        .recommendedMovieList[
                                                            index]
                                                        .isRental ==
                                                    1)
                                            ? true
                                            : false,
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kH60sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommonContainer extends StatelessWidget {
  const CommonContainer(
      {super.key,
      required this.image,
      this.onPressed,
      this.containerColor,
      this.iconColor});
  final String image;
  final Color? containerColor, iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: containerColor ?? cWhiteColor.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(k12Padding),
          child: SvgPicture.asset(
            image,
            color: iconColor ?? cWhiteColor,
          ),
        ),
      ),
    );
  }
}

void showSaveVideoToPlayListPopup(BuildContext context, int movieId) {
  final ProfileController profileController = Get.find<ProfileController>();
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
                        kiAdd,
                        color: cWhiteColor,
                      ),
                    ),
                  ),
                  kW12sizedBox,
                  Text(
                    ksSaveVideoToPlaylist.tr,
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
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(() => CustomCheckBox(
                        fillColorl: cBlackColor2,
                        borderColor: cTextColor2,
                        value: profileController
                            .temporaryPlayListCheckBoxStateList[index],
                        label: profileController.playlistList[index].name ?? "",
                        onChanged: (v) {
                          profileController
                                  .temporaryPlayListCheckBoxStateList[index] =
                              !profileController
                                  .temporaryPlayListCheckBoxStateList[index];
                          if (profileController.moviePlayListIds.contains(
                              profileController.playlistList[index].id)) {
                            profileController.moviePlayListIds.remove(
                                profileController.playlistList[index].id);
                            // authController.selectedInterestList.remove(
                            //     authController.interestList[index].title);
                          } else {
                            profileController.moviePlayListIds
                                .add(profileController.playlistList[index].id);
                            // authController.selectedInterestList.add(
                            //     authController.interestList[index].title);
                          }
                        },
                        textStyle: medium16TextStyle(cWhiteColor)));
                  },
                  separatorBuilder: (context, index) => kH8sizedBox,
                  itemCount: profileController.playlistList.length),
              kH16sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    label: ksCreateNewPlaylist.tr,
                    onPressed: () {
                      Get.back();
                      showCreateNewPlayListPopup(context);
                    },
                    buttonWidth: 140.w,
                    buttonHeight: 30.h,
                    buttonColor: cWhiteColor.withOpacity(0.2),
                  ),
                  kW12sizedBox,
                  CustomElevatedButton(
                    label: ksSaveNow.tr,
                    onPressed: () async {
                      Get.back();
                      await profileController.playlistAddMovie(
                          movieId: movieId);
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

void showDownloadVideoPopup(BuildContext context) {
  final HomeController homeController = Get.find<HomeController>();
  final AllVideoPlayerController allVideoPlayerController =
      Get.find<AllVideoPlayerController>();
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
                        kiDownload,
                        color: cWhiteColor,
                      ),
                    ),
                  ),
                  kW12sizedBox,
                  Text(
                    ksAvailableDownloads.tr,
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
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${homeController.movieDetailsModel.value!.download!.details![index].title}",
                              style: medium14TextStyle(cWhiteColor),
                            ),
                            CustomElevatedButton(
                              label: ksDownload.tr,
                              onPressed: () async {
                               await allVideoPlayerController.downloadVideo(
    context,
    homeController.movieDetailsModel.value!.download!.details![index].link ?? ""
  );
                                Get.back();
                              },
                              buttonWidth: 110.w,
                              buttonHeight: 30.h,
                              buttonColor: cPrimaryColor,
                            ),
                          ],
                        ),
                        kH4sizedBox,
                        Text(
                          "Resolution: ${homeController.movieDetailsModel.value!.download!.details![index].resolution}",
                          style: regular14TextStyle(cWhiteColor),
                        ),
                        kH4sizedBox,
                        Text(
                          "Size: ${homeController.movieDetailsModel.value!.download!.details![index].fileSize}",
                          style: regular14TextStyle(cWhiteColor),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => kH8sizedBox,
                  itemCount: homeController
                      .movieDetailsModel.value!.download!.details!.length),
              kH16sizedBox,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     CustomElevatedButton(
              //       label: ksCreateNewPlaylist.tr,
              //       onPressed: () {
              //         Get.back();
              //         showCreateNewPlayListPopup(context);
              //       },
              //       buttonWidth: 140.w,
              //       buttonHeight: 30.h,
              //       buttonColor: cWhiteColor.withOpacity(0.2),
              //     ),
              //     kW12sizedBox,
              //     CustomElevatedButton(
              //       label: ksSaveNow.tr,
              //       onPressed: () async {
              //         Get.back();

              //       },
              //       buttonWidth: 110.w,
              //       buttonHeight: 30.h,
              //       buttonColor: cPrimaryColor2,
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      );
    },
  );
}

void showCreateNewPlayListPopup(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        kiAdd,
                        color: cWhiteColor,
                      ),
                    ),
                  ),
                  kW12sizedBox,
                  Text(
                    ksCreateNewPlaylist.tr,
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
                ksTitle.tr,
                style: medium16TextStyle(cWhiteColor),
              ),
              kH8sizedBox,
              SizedBox(
                height: 40.h,
                child: CustomModifiedTextField(
                  controller: Get.find<ProfileController>()
                      .createPlaylistTextEditingController,
                  hint: ksTitle.tr,
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
                    label: ksCreateNew.tr,
                    onPressed: () async {
                      Get.back();
                      await Get.find<ProfileController>().createPlayList();
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

class SubscriptionSelector extends StatelessWidget {
  SubscriptionSelector({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: width - 40,
          height: 60.h,
          decoration: BoxDecoration(
            color: cWhiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k8Padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: controller.packageDetails.keys.map((packageName) {
                return _buildOption(packageName);
              }).toList(),
            ),
          ),
        ));
  }

  Widget _buildOption(String packageName) {
    final isSelected = controller.selectedPackage.value == packageName;
    final package = controller.packageDetails[packageName]!;
    final price = package['price']!;
    final duration = package['duration']!;

    return InkWell(
      onTap: () => controller.selectPackage(packageName),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(k2Padding),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? cPrimaryColor : cBlackColor3,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 6,
              backgroundColor: isSelected ? cPrimaryColor : cWhiteColor,
            ),
          ),
          const SizedBox(width: k4Padding),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: price,
                  style: medium14TextStyle(cBlackColor),
                ),
                TextSpan(
                  text: '/$duration',
                  style: regular14TextStyle(cBlackColor3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RentProductDetailsContentContainer extends StatelessWidget {
  const RentProductDetailsContentContainer(
      {super.key, this.rentPrice, this.rentValidity, this.rentExpireDate,this.id,this.videoType});
  final String? rentPrice, rentValidity, rentExpireDate,id,videoType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - 40,
      decoration: BoxDecoration(
        color: cWhiteColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(k6BorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(k20Padding),
        child: Column(
          children: [
            RentProductDetailsRow(
              title: ksVideoCost.tr,
              value: rentPrice ?? "",
            ),
            kH12sizedBox,
            RentProductDetailsRow(
              title: ksValidity.tr,
              value: rentValidity ?? "",
            ),
            // kH12sizedBox,
            // RentProductDetailsRow(
            //   title: ksDeviceLimit.tr,
            //   value: "2",
            // ),
            kH12sizedBox,
            RentProductDetailsRow(
              title: ksExpireDate.tr,
              value: DateFormat('d MMM, yyyy, hh:mm a')
                  .format(DateTime.parse(rentExpireDate ?? "")),
              // value: "sfhbvsbgjbrgjhdrhjbgjdsfbvjsbfgjbdfgdejbgj",
            ),
            kH12sizedBox,
            RentProductDetailsRow(
              title: ksAds.tr,
              value: "Not Shown",
            ),
            kH12sizedBox,
            RentProductDetailsRow(
              title: ksDownload.tr,
              value: "Not Allowed",
            ),
            kH12sizedBox,
            RentProductDetailsRow(
              title: ksPremiumContent.tr,
              value: "Not Allowed",
            ),
            kH20sizedBox,
            CustomElevatedButton(
              label: ksProceedToPayment.tr,
              onPressed: () {
                 Get.find<ProfileController>().selectedPaymentMethod.value = "";
             if(Get.find<GlobalController>().userToken.value!=""){
                Get.to(()=> PaymentMethodScreen(paymentType: "rental", planId: id!, videoType: videoType??"",
                payableAmount: double.parse(
  (rentPrice ?? "0").replaceAll(RegExp(r'[^\d.]'), '')
),
));
              }
              },
              textStyle: semiBold14TextStyle(cWhiteColor),
              buttonWidth: width - 80,
            ),
          ],
        ),
      ),
    );
  }
}

class VideoDetailsContentWidget extends StatelessWidget {
  const VideoDetailsContentWidget(
      {super.key, this.imageUrl, this.title, this.subTitle, this.onPressed});
  final String? imageUrl, title, subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl ?? "",
            width: 70.w,
            height: 40.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
              child: SvgPicture.asset(
                kiDummyMovie,
                width: 70.w,
                height: 50.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          kW12sizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: semiBold14TextStyle(cWhiteColor),
              ),
              kH4sizedBox,
              Text(
                subTitle ?? "",
                style: regular12TextStyle(cWhiteColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RentProductDetailsRow extends StatelessWidget {
  const RentProductDetailsRow({super.key, this.title, this.value});
  final String? title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title: ",
          style: regular16TextStyle(cWhiteColor),
        ),
        Text(
          value ?? "",
          style: regular16TextStyle(cWhiteColor),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
