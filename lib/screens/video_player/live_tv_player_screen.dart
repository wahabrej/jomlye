import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';

class LiveTvPlayerScreen extends StatelessWidget {
  LiveTvPlayerScreen({super.key, this.liveTvUrl});
  final AllVideoPlayerController allVideoPLayerController =
      Get.find<AllVideoPlayerController>();
  final HomeController homeController = Get.find<HomeController>();
  final String? liveTvUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Obx(() => SingleChildScrollView(
            child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kH30sizedBox,
                          SizedBox(
                            width: width,
                            child: YoYoPlayer(
                            // aspectRatio: 16 / 9,
                            // url: homeController.liveTvDetailsData.value?.streamUrl??"",
                            // url: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
                            url: liveTvUrl??"",
                            videoStyle: const VideoStyle(),
                            videoLoadingStyle: const VideoLoadingStyle(),
                                ),
                          ),
                          kH20sizedBox,
                          Row(
                            children: [
                              Container(
                                width: 50.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(k4BorderRadius),
                                  color: cPrimaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 6.w,
                                      height: 6.h,
                                      decoration: BoxDecoration(
                                        color: cGreyBoxColor2,
                                        shape: BoxShape.circle,
                            ),
                          ),
                          kW4sizedBox,
                          Center(
                              child: Text(
                            ksLive.tr,
                            style: regular14TextStyle(cWhiteColor),
                          )),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Text(
                    //   homeController.liveTvDetailsData.value?.?.quality ??
                    //       "",
                    //   style: regular14TextStyle(cWhiteColor),
                    // ),
                  ],
                ),
                kH16sizedBox,
                Text(
                  ksChannelName.tr,
                  style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),
                ),
                kH12sizedBox,
                    Text(
                      homeController.liveTvDetailsData.value?.tvName ?? "",
                      style: medium20TextStyle(cWhiteColor),
                    ),
                    kH12sizedBox,
                    Text(
                      homeController.liveTvDetailsData.value?.description ?? "",
                      style: regular14TextStyle(cWhiteColor),
                    ),
                    kH16sizedBox,
                     Row(
                        children: [
                          CommonContainer(
                            image: kiCrown,
                            onPressed: null,
                            containerColor:
                                homeController.movieDetailsData.value?.isPaid == 1
                                    ? cPrimaryColor
                                    : cWhiteColor.withOpacity(0.2),
                          ),
                          kW10sizedBox,
                          CommonContainer(
                            image: kiFavorite,
                            containerColor:
                                Get.find<ProfileController>().isFavoriteAdded.value
                                    ? cPrimaryColor2
                                    : null,
                            onPressed: () async {
                              if (Get.find<GlobalController>().userToken.value ==
                                  "") {
                                showSnackBar(
                                    title: "Error",
                                    message:
                                        "Please Login first then add favourite",
                                    color: cRedColor);
                              } else {
                                Get.find<ProfileController>().isFavoriteAdded.value =
                                    !Get.find<ProfileController>().isFavoriteAdded.value;
                                await Get.find<ProfileController>().favoriteAddOrRemove(
                                    id: homeController
                                            .liveTvDetailsData.value?.id ??
                                        -1,
                                    type: "live_tv");
                              }
                            },
                          ),
                          kW10sizedBox,
                          CommonContainer(
                            image: kiAdd,
                            onPressed: () async {
                              if (Get.find<GlobalController>().userToken.value ==
                                  "") {
                                showSnackBar(
                                    title: "Error",
                                    message:
                                        "Please Login first then add playlist",
                                    color: cRedColor);
                              } else {
                                Get.find<ProfileController>().moviePlayListIds.addAll(
                                    homeController.movieDetailsModel.value
                                            ?.playlistIds ??
                                        []);
                                for (int i = 0;
                                    i < Get.find<ProfileController>().playlistList.length;
                                    i++) {
                                  final currentId = Get.find<ProfileController>()
                                      .playlistList[i]
                                      .id
                                      .toString();
                                  final bool exists = Get.find<HomeController>()
                                      .playlistIdsList
                                      .any((element) =>
                                          currentId.contains(element.toString()));
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
                            image: kiShare,
                            onPressed: () {
                              Share.share('Share data from vidflix app! 🚀');
                            },
                          ),
                        ],
                      ),
                      kH16sizedBox,
                      Text(ksChannelDetails.tr,style: medium16TextStyle(cWhiteColor),),
                      kH12sizedBox,
                        Container(
                        width: width - 40,
                        height: 46.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: k4Padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                homeController.liveTvDetailsTabs.length, (index) {
                              return GestureDetector(
                                onTap: () async {
                                  homeController.videoDetailsChangeTab(index);
                                  if (homeController.liveTvSelectedIndex.value ==
                                      0) {
                                    await homeController.getUserReview(
                                        reviewableId: homeController.liveTvDetailsData
                                            .value!.id!,
                                            reviewableType: "livetv"
                                            );
                                  }
                                },
                                child: Obx(() => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: homeController
                                                    .liveTvSelectedIndex.value ==
                                                index
                                            ? Colors.grey[800]
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(),
                                        child: Text(
                                          homeController.liveTvDetailsTabs[index],
                                          style: regular14TextStyle(cWhiteColor),
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
                      kH16sizedBox,
                        if (homeController.liveTvSelectedIndex.value == 0)
                        Column(
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
                                                    homeController.rating.value
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
                                    // await homeController.userRating(
                                    //     reviewableId: homeController
                                    //         .liveTvDetailsData
                                    
                                    //         .value!
                                    //         .id!,
                                    //         reviewableType: ""
                                    //         );
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
                              separatorBuilder: (context, index) => kH8sizedBox,
                              itemCount: homeController.movieReviewList.length,
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
                                                color:
                                                    cGreyColor.withOpacity(0.8),
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
                                              homeController.movieReviewList[index]?.createdAt??"",
                                              style: regular10TextStyle(
                                                  cGreyColor.withOpacity(0.8)),
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
                                                      homeController.movieReviewList[index]!.isLiked!.value = !homeController.movieReviewList[index]!.isLiked!.value;
                                                      if(homeController.movieReviewList[index]!.isLiked!.value==true){
                                                        homeController.movieReviewList[index]!.totalLikes!.value++;
                                                      } 
                                                      if(homeController.movieReviewList[index]!.isLiked!.value==false){
                                                        homeController.movieReviewList[index]!.totalLikes!.value--;
                                                      } 
                                                      await homeController.reviewLikeToggle(reviewId: homeController.movieReviewList[index]!.id!);
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
                                                            ?.totalLikes?.value
                                                            .toString() ??
                                                        "",
                                                    style: regular12TextStyle(
                                                        cGreyColor
                                                            .withOpacity(0.8)),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        kH10sizedBox,
                                        Text(
                                          homeController.movieReviewList[index]
                                                  ?.review ??
                                              "",
                                          style: medium12TextStyle(cWhiteColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      kH16sizedBox,
                     HomeTitleContent(
                        title: ksFeaturedTvChannels.tr,
                        subtitleText:
                            homeController.featuredTvChannelsList.isNotEmpty
                                ? ksViewAll.tr
                                : "",
                          isHorizontalPadding: false,
                        onPressed: () async {
                          homeController.resetBottomSheetData();
                          Get.find<ProfileController>().temporaryPlayListCheckBoxStateList
                              .clear();
                          homeController.isViewAllSearchEnable.value = false;
                          homeController.viewAllTextEditingController.clear();
                          await homeController.getTvChannel();
                          Get.toNamed(krTvChannelsViewAllScreen);
                        },
                      ),
                      kH16sizedBox,
                      SizedBox(
                        height: 150.h,
                        child: ListView.separated(
                          itemCount: homeController.relatedLiveTvChannelsList.length,
                          separatorBuilder: (context, index) => kW10sizedBox,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Obx(() => InkWell(
                                  onTap: () async {
                                    await homeController.getMovieDetails(
                                        movieId: homeController
                                            .relatedLiveTvChannelsList[index].id!
                                            .toString());
                                    if (homeController
                                        .movieServerList.isNotEmpty) {
                                      String videoUrl = homeController
                                              .movieServerList[0]?.fileUrl ??
                                          "";
                                      // Get.find<AllVideoPlayerController>()
                                      //     .flickManager = FlickManager(
                                      //   videoPlayerController:
                                      //       VideoPlayerController.network(
                                      //           videoUrl),
                                      // );
                                    } else {
                                      // String videoUrl = "";
                                      // Get.find<AllVideoPlayerController>()
                                      //     .flickManager = FlickManager(
                                      //   videoPlayerController:
                                      //       VideoPlayerController.network(
                                      //           videoUrl),
                                      // );
                                    }
                                  },
                                  child: MovieContentContainer(
                                    movieImage: homeController
                                        .relatedLiveTvChannelsList[index].thumbnail,
                                    isPremium: homeController
                                                .relatedLiveTvChannelsList[index]
                                                .isPaid ==
                                            1
                                        ? true
                                        : false,
                                  ),
                                ));
                          },
                        ),
                      ),
                     
                      kH16sizedBox,
            
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
