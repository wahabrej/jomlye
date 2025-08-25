// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/screens/home/home_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvShowPlayerScreen extends StatefulWidget {
 const TvShowPlayerScreen({super.key,this.isRentableVideo});
    final bool? isRentableVideo;

  @override
  State<TvShowPlayerScreen> createState() => _TvShowPlayerScreenState();
}

class _TvShowPlayerScreenState extends State<TvShowPlayerScreen> {
  final AllVideoPlayerController allVideoPlayerController =
      Get.find<AllVideoPlayerController>();

  final HomeController homeController = Get.find<HomeController>();
  final ProfileController profileController = Get.find<ProfileController>();
    @override
  void dispose() {
    ll("Dispose from tv show player screen");
    if (Get.find<GlobalController>().userToken.value != "") {
      homeController.watchHistoryStore(
          watchableType: 'episode',
          watchableId: homeController.tvShowEpisodeList[homeController.selectedEpisode.value]?.id ?? -1,
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
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   kH40sizedBox,
                //   if (homeController.tvShowEpisodeList.isNotEmpty && (
                //           homeController
                //                   .tvShowEpisodeList[
                //                       homeController.selectedEpisode.value]
                //                   ?.fileSource ==
                //               "youtube" &&
                //           (homeController.tvShowDetailsModel.value?.isRented ==
                //                   true &&
                //               widget.isRentableVideo == true)) ||
                //       homeController.tvShowDetailsData.value?.isFree == 1)
                // //!youtube player
                // YoutubePlayerBuilder(
                //   player: YoutubePlayer(
                //     controller: allVideoPlayerController.youtubeController,
                //     showVideoProgressIndicator: true,
                //     progressIndicatorColor: Colors.red,
                //   ),
                //   builder: (context, player) {
                //     return Column(
                //       children: [
                //         player,
                //         const SizedBox(),
                //       ],
                //     );
                //   },
                // ),
                //  if (homeController.tvShowEpisodeList[homeController.selectedEpisode.value]?.fileUrl==)
                    SizedBox(
                      width: width,
                      height: 200,
                      child: Image.network(
                        homeController.tvShowDetailsData.value?.thumbnail ?? "",
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.asset(
                            kiDummyMovie,
                            width: width - 40,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  if ((homeController.tvShowDetailsData.value?.isFree == 0 &&
                          Get.find<GlobalController>()
                                  .subscribedUserCheck
                                  .value ==
                              false) ||
                      (homeController.tvShowDetailsModel.value?.isRented ==
                              false &&
                          widget.isRentableVideo == true))
                    SizedBox(
                      width: width,
                      height: 200.h,
                      child: Image.network(
                        homeController.tvShowDetailsData.value?.thumbnail ?? "",
                        fit: BoxFit.fill,
                      ),
                    ),
                // //!flick video player
                  if (homeController.tvShowEpisodeList.isNotEmpty && (
                          homeController
                                  .tvShowEpisodeList[
                                      homeController.selectedEpisode.value]
                                  ?.fileSource !=
                              "youtube" &&
                          homeController
                                  .tvShowEpisodeList[
                                      homeController.selectedEpisode.value]
                                  ?.fileSource
                                  .toString()
                                  .toLowerCase() !=
                              "gdrive" &&
                          (homeController.tvShowDetailsModel.value?.isRented ==
                                  true &&
                              widget.isRentableVideo == true)) ||
                      homeController.tvShowDetailsData.value?.isFree == 1)
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text("This is test text"),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: cAmberColor,
                                  size: kIconSize16,
                                ),
                                kW6sizedBox,
                                Text(
                                  homeController
                                          .tvShowDetailsData.value?.imdbRating ??
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
                                  homeController
                                          .tvShowDetailsData.value?.runtime ??
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
      children: (homeController.tvShowDetailsModel.value?.videoTags?.isNotEmpty ?? false)
          ? List.generate(
              homeController.tvShowDetailsModel.value!.videoTags!.length * 2 - 1,
              (index) {
                if (index.isOdd) return kW8sizedBox;
                final itemIndex = index ~/ 2;
                final movieType = homeController.tvShowDetailsModel.value!.videoTags![itemIndex];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: cPrimaryColor2.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(k4BorderRadius),
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
            )
          : [],
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
                        homeController.tvShowDetailsData.value?.title ?? "",
                        style: medium20TextStyle(cWhiteColor),
                      ),
                      kH12sizedBox,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: homeController
                                      .tvShowDetailsData.value?.description ??
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
                                homeController.tvShowDetailsData.value?.isFree ==
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
                                            .tvShowDetailsData.value?.id ??
                                        -1,
                                    type: "tv_show");
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
                                    homeController.tvShowDetailsData.value?.id ??
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
                                    // allVideoPlayerController.flutterMediaDownloaderPlugin.downloadMedia(context,'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf');
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
                     
                    ],
                  ),
                ),
                 if (homeController.tvShowsSeasonList.isNotEmpty) kH16sizedBox,
                      if (homeController.tvShowsSeasonList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: k20Padding),
                          child: SizedBox(
                            width: width - 60 / 3,
                            height: 40.h,
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => kW10sizedBox,
                              itemCount: homeController.tvShowsSeasonList.length,
                              itemBuilder: (context, index) {
                                return Obx(() => InkWell(
                                  onTap: (){
                                    homeController.selectedSeason.value = index;
                                    homeController.tvShowEpisodeList
                .addAll(homeController.tvShowDetailsModel.value!.shows!.seasons![homeController.selectedSeason.value].episodes!);
                                  },
                                  child: Container(
                                    width: (width - 50) / 3,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(k6BorderRadius),
                                      color:
                                          homeController.selectedSeason.value ==
                                                  index
                                              ? cPrimaryColor
                                              : cWhiteColor.withOpacity(0.2),
                                    ),
                                    child: Center(
                                        child: Text(
                                      homeController
                                              .tvShowsSeasonList[index]?.seasonName ??
                                          "",
                                          textAlign: TextAlign.center,
                                      style: medium14TextStyle(cWhiteColor),
                                    )),
                                  ),
                                ));
                              },
                            ),
                          ),
                        ),
                       
                        kH16sizedBox,
                        if (homeController.tvShowEpisodeList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: k20Padding),
                          child: Container(
                            width: width-40,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${homeController.tvShowDetailsData.value?.title ?? ""} - ${ homeController.tvShowsSeasonList[homeController.selectedSeason.value]?.seasonName ??""}",style: medium16TextStyle(cWhiteColor)),
                                     homeController.isTvShowsListExpand.value ? InkWell(
                                      onTap: (){
                                        homeController.isTvShowsListExpand.value = !homeController.isTvShowsListExpand.value;
                                      },
                                      child: Icon(Icons.minimize,color: cWhiteColor,size: kIconSize20,)) : InkWell(
                                            onTap: (){
                                        homeController.isTvShowsListExpand.value = !homeController.isTvShowsListExpand.value;
                                      },
                                        child: SvgPicture.asset(kiAdd,width: 10.w,height: 10.h,)),
                                    ],
                                  ),
                                  kH6sizedBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                       SvgPicture.asset(kiPlay,width: 10.w,height: 10.h,),
                                       kW4sizedBox,
                                       Text("${homeController.tvShowEpisodeList.length} $ksVideos",style: regular10TextStyle(cWhiteColor),),
                                       kW4sizedBox,
                                         SizedBox(
                                          height: 10.h,
                                           child: VerticalDivider(
                                                  width: 1,
                                                  thickness: 1,
                                                  color:cWhiteColor.withOpacity(0.2),
                                                ),
                                         ),
                                         kW4sizedBox,
                                         Icon(Icons.timer_outlined,size: kIconSize14,color: cWhiteColor.withOpacity(0.8),),
                                         kW4sizedBox,
                                        //  Text("${homeController.tvShowsSeasonList[homeController.selectedSeason.value]!.createdAt}",style: regular10TextStyle(cWhiteColor),),
                                         Text(   DateFormat('yyyy').format(DateTime.parse(
                                      homeController.tvShowsSeasonList[homeController.selectedSeason.value]!.createdAt.toString())),style: regular10TextStyle(cWhiteColor),),
                                    ],
                                  ),
                                  kH8sizedBox,
                                      Divider(
                                       thickness: 1,
                                       color: cWhiteColor.withOpacity(0.2),
                                      ),
                                  kH8sizedBox,
                                  if(homeController.isTvShowsListExpand.value==true)
                                  ListView.separated(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: const NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) => kH10sizedBox,
                                        itemCount: homeController.tvShowEpisodeList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: ()async{
                                                  homeController.resetRatingData();
                                       homeController.selectedEpisode.value=0;
                                              profileController.isFavoriteAdded.value = 
                                        homeController.tvShowDetailsData.value
                                                ?.isFavorite ??
                                            false;
                                      await homeController.getTvShowDetails(
                                          showId: homeController
                                              .tvShowEpisodeList[index]!.id!);
                                               homeController.selectedEpisode.value = index;
                                         if(homeController.tvShowEpisodeList.isNotEmpty){
                                    allVideoPlayerController.videoPlayerFunction(
                                       isFree: homeController.tvShowDetailsData.value?.isFree==1 ?true : false,
                                      isRental: homeController.tvShowDetailsData.value?.isFree==0 && homeController.tvShowDetailsData.value?.isRental==1 ? true : false,  
                                                  isRented:  homeController.tvShowDetailsModel.value?.isRented??false,
                                                 isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value,
                                                  fileUrl: homeController
                                                .tvShowEpisodeList[homeController.selectedEpisode.value]?.fileUrl??"", fileSource: homeController
                                                .tvShowEpisodeList[homeController.selectedEpisode.value]?.sourceType??"",
                                                );
                                         }
                                        Get.offUntil(
                                          GetPageRoute(
                                            page: () => TvShowPlayerScreen(
                                              isRentableVideo:homeController.tvShowDetailsData.value?.isFree==0 &&
                                                  homeController.tvShowDetailsData.value?.isRental == 1 ? true : false,
                                            ),
                                          ),
                                          ModalRoute.withName(krHomeScreen),
                                        );
                                            },
                                            child: Row(
                                              children: [
                                                Image.network(homeController.tvShowEpisodeList[index]?.poster??"", height: 90.h,
                                                                width: 150.w,
                                                                fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Center(
                                                              child: SvgPicture.asset(
                                                                kiDummyMovie,
                                                                height: 90.h,
                                                                width: 150.w,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),),
                                                            kW8sizedBox,
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(homeController.tvShowEpisodeList[index]?.seasonId.toString()??"",style: medium14TextStyle(cWhiteColor),),
                                                                kH4sizedBox,
                                                                Text(homeController.tvShowEpisodeList[index]?.episodeName??"",style: medium14TextStyle(cWhiteColor),),
                                                                kH4sizedBox,
                                                                // Text("${ksTimeDuration.tr}: ${homeController.tvShowEpisodeList[index]?.}",style: medium14TextStyle(cWhiteColor),),
                                                                Container(
                                                                  height: 32.h,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(2),
                                                                    // color: homeController.tvShowEpisodeList[index].isPaid ? cPrimaryColor : cWhiteColor.withOpacity(0.1),
                                                                    color: cPrimaryColor,
                                                                  ),
                                                                  // child: Padding(
                                                                  //   padding: const EdgeInsets.symmetric(horizontal: k8Padding,vertical: k2Padding),
                                                                  //   child: Text(homeController.tvShowEpisodeList[index].isPaid ? ksPremium.tr : ksFree.tr),
                                                                  // ),
                                                                ),
                                                              ],
                                                            ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                ],
                              ),
                            ),
                          ),
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
                                homeController.movieDetailsTabs.length, (index) {
                              return GestureDetector(
                                onTap: () async {
                                  homeController.videoDetailsChangeTab(index);
                                  if (homeController.movietSelectedIndex.value ==
                                      3) {
                                    await homeController.getUserReview(
                                        reviewableId: homeController.movieDetailsModel
                                            .value!.details!.id!,
                                            reviewableType: "tvshow",
                                            );
                                  }
                                },
                                child: Obx(() => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: homeController
                                                    .movietSelectedIndex.value ==
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
                                          homeController.movieDetailsTabs[index],
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
                            itemCount: homeController.tvShowCastList.length,
                            itemBuilder: (context, index) {
                              return VideoDetailsContentWidget(
                                imageUrl: homeController
                                        .tvShowCastList[index]?.starImage ??
                                    "",
                                title: homeController
                                        .tvShowCastList[index]?.starName ??
                                    "",
                                subTitle: homeController
                                        .tvShowCastList[index]?.starType ??
                                    "",
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
                            itemCount: homeController.tvShowDirectorList.length,
                            itemBuilder: (context, index) {
                              return VideoDetailsContentWidget(
                                imageUrl: homeController
                                        .tvShowDirectorList[index]?.starImage ??
                                    "",
                                title: homeController
                                        .tvShowDirectorList[index]?.starName ??
                                    "",
                                subTitle: homeController
                                        .tvShowDirectorList[index]?.starType ??
                                    "",
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
                            itemCount: homeController.tvShowWritterList.length,
                            itemBuilder: (context, index) {
                              return VideoDetailsContentWidget(
                                imageUrl: homeController
                                        .tvShowWritterList[index]?.starImage ??
                                    "",
                                title: homeController
                                        .tvShowWritterList[index]?.starName ??
                                    "",
                                subTitle: homeController
                                        .tvShowWritterList[index]?.starType ??
                                    "",
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
                                      await homeController.userRating(
                                          reviewableId: homeController
                                              .movieDetailsModel
                                              .value!
                                              .details!
                                              .id!,
                                              reviewableType: "tvshow",
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
                        ),
                      kH16sizedBox,
                           HomeTitleContent(
                        title: ksRelatedVideos.tr,
                        subtitleText: homeController.relatedTvShowsList.isNotEmpty
                            ? ksViewAll.tr
                            : "",
                        onPressed: () async {
                          homeController.resetBottomSheetData();
                          homeController.isViewAllSearchEnable.value = false;
                          homeController.viewAllTextEditingController.clear();
                          homeController.selectedTitle.value = ksPopularTvShows;
                          await homeController.getTvShows();
                          Get.toNamed(krTvShowsViewAllScreen);
                        },
                      ),
                      kH16sizedBox,
                      Padding(
                        padding: const EdgeInsets.only(left: k20Padding),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width - 20,
                              height: 150.h,
                              child: ListView.separated(
                                itemCount:
                                    homeController.relatedTvShowsList.length,
                                separatorBuilder: (context, index) => kW8sizedBox,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      await homeController.getTvShowDetails(
                                          showId: homeController
                                              .relatedTvShowsList[index]?.id??-1);
                                      Get.toNamed(krTvShowPlayerScreen);
                                    },
                                    child: MovieContentContainer(
                                      movieImage: homeController
                                          .relatedTvShowsList[index]?.thumbnail,
                                      isPremium: homeController
                                                  .relatedTvShowsList[index]
                                                  ?.isFree ==
                                              0 && homeController
                                                  .relatedTvShowsList[index]
                                                  ?.isRental ==
                                              0 
                                          ? true
                                          : false,
                                          isRentable: homeController
                                                  .relatedTvShowsList[index]
                                                  ?.isFree ==
                                              0 && homeController
                                                  .relatedTvShowsList[index]
                                                  ?.isRental ==
                                              1 
                                          ? true
                                          : false,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      kH20sizedBox,
                //!Comment Widget
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                //   child: Column(
                //     children: [
                //       kH20sizedBox,
                //       Container(
                //         width: width,
                //         decoration: BoxDecoration(
                //           color: cWhiteColor.withOpacity(0.1),
                //           borderRadius: BorderRadius.circular(k6BorderRadius),
                //         ),
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: k16Padding, vertical: k20Padding),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 "10 Comments",
                //                 style: medium16TextStyle(cWhiteColor),
                //               ),
                //               // kW36sizedBox,
                //               Text(
                //                 "${ksSubmitRating.tr}:",
                //                 style: regular16TextStyle(cWhiteColor),
                //               ),
                //               //!temporary(this is not valid)
                //               const Row(
                //                 children: [
                //                   Icon(
                //                     Icons.star_border,
                //                     size: kIconSize16,
                //                     color: cWhiteColor,
                //                   ),
                //                   Icon(
                //                     Icons.star_border,
                //                     size: kIconSize16,
                //                     color: cWhiteColor,
                //                   ),
                //                   Icon(
                //                     Icons.star_border,
                //                     size: kIconSize16,
                //                     color: cWhiteColor,
                //                   ),
                //                   Icon(
                //                     Icons.star_border,
                //                     size: kIconSize16,
                //                     color: cWhiteColor,
                //                   ),
                //                   Icon(
                //                     Icons.star_border,
                //                     size: kIconSize16,
                //                     color: cWhiteColor,
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       kH20sizedBox,
                //       Row(
                //         children: [
                //           Container(
                //             width: 40.w,
                //             height: 40.h,
                //             decoration: const BoxDecoration(
                //               shape: BoxShape.circle,
                //             ),
                //             child: CircleAvatar(
                //               backgroundColor: cWhiteColor.withOpacity(0.2),
                //               child: ClipOval(
                //                 child: Image.network(
                //                     width: 40.w,
                //                     height: 40.h,
                //                     fit: BoxFit.cover,
                //                     "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D"),
                //               ),
                //             ),
                //           ),
                //           kW12sizedBox,
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Text(
                //                     "Saikat Ahmmed",
                //                     style: medium16TextStyle(cWhiteColor),
                //                   ),
                //                   kW6sizedBox,
                //                   Container(
                //                     width: 6.w,
                //                     height: 6.h,
                //                     decoration: BoxDecoration(
                //                       shape: BoxShape.circle,
                //                       color: cGreyColor.withOpacity(0.8),
                //                     ),
                //                   ),
                //                   kW6sizedBox,
                //                   Icon(
                //                     Icons.access_time,
                //                     color: cGreyColor.withOpacity(0.8),
                //                     size: kIconSize16,
                //                   ),
                //                   kW6sizedBox,
                //                   Text(
                //                     "2 years ago",
                //                     style: regular10TextStyle(
                //                         cGreyColor.withOpacity(0.8)),
                //                   ),
                //                 ],
                //               ),
                //               kH10sizedBox,
                //               SizedBox(
                //                 width: width - 96,
                //                 child: Row(
                //                   children: [
                //                     const Icon(
                //                       Icons.favorite_outline,
                //                       color: cWhiteColor,
                //                       size: kIconSize20,
                //                     ),
                //                     kW6sizedBox,
                //                     Text(
                //                       "100K",
                //                       style: regular12TextStyle(
                //                           cGreyColor.withOpacity(0.8)),
                //                     ),
                //                     kW12sizedBox,
                //                     SizedBox(
                //                       height: h8.h,
                //                       child: VerticalDivider(
                //                         width: 1,
                //                         thickness: 1,
                //                         color: cWhiteColor.withOpacity(0.14),
                //                       ),
                //                     ),
                //                     kW12sizedBox,
                //                     SvgPicture.asset(
                //                       kiMessage,
                //                       width: 14.w,
                //                       height: 14.h,
                //                       color: cWhiteColor,
                //                     ),
                //                     kW6sizedBox,
                //                     Text(
                //                       "10k replies",
                //                       style: regular12TextStyle(
                //                           cGreyColor.withOpacity(0.8)),
                //                     ),
                //                     kW6sizedBox,
                //                     const Icon(
                //                       Icons.keyboard_arrow_down_outlined,
                //                       color: cWhiteColor,
                //                       size: kIconSize20,
                //                     ),
                //                     //  Spacer(),
                //                     Expanded(child: SizedBox()),
                //                     Row(
                //                       children: [
                //                         SvgPicture.asset(
                //                           kiReply,
                //                           width: 16.w,
                //                           height: 16.h,
                //                           color: cPrimaryColor2,
                //                         ),
                //                         kW14sizedBox,
                //                         Text(
                //                           ksReply.tr,
                //                           style:
                //                               regular16TextStyle(cPrimaryColor2),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //       kH12sizedBox,
                //       Padding(
                //         padding: EdgeInsets.only(left: 52.w),
                //         child: SizedBox(
                //           width: width - 72,
                //           child: Column(
                //             children: [
                //               Divider(
                //                 thickness: 1,
                //                 color: cWhiteColor.withOpacity(0.14),
                //               ),
                //               Text(
                //                 "Lorem ipsum dolor sit amet consectetur. Eget dictum at ipsum ridiculus nec. Viverra mauris molestie ut rhoncus.",
                //                 style: regular14TextStyle(cWhiteColor),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       kH20sizedBox,
                //       Row(
                //         children: [
                //           Container(
                //             width: 40.w,
                //             height: 40.h,
                //             decoration: const BoxDecoration(
                //               shape: BoxShape.circle,
                //             ),
                //             child: CircleAvatar(
                //               backgroundColor: cWhiteColor.withOpacity(0.2),
                //               child: ClipOval(
                //                 child: Image.network(
                //                     width: 40.w,
                //                     height: 40.h,
                //                     fit: BoxFit.cover,
                //                     "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D"),
                //               ),
                //             ),
                //           ),
                //           kW12sizedBox,
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Text(
                //                     "Saikat Ahmmed",
                //                     style: medium16TextStyle(cWhiteColor),
                //                   ),
                //                   kW6sizedBox,
                //                   Container(
                //                     width: 6.w,
                //                     height: 6.h,
                //                     decoration: BoxDecoration(
                //                       shape: BoxShape.circle,
                //                       color: cGreyColor.withOpacity(0.8),
                //                     ),
                //                   ),
                //                   kW6sizedBox,
                //                   Icon(
                //                     Icons.access_time,
                //                     color: cGreyColor.withOpacity(0.8),
                //                     size: kIconSize16,
                //                   ),
                //                   kW6sizedBox,
                //                   Text(
                //                     "2 years ago",
                //                     style: regular10TextStyle(
                //                         cGreyColor.withOpacity(0.8)),
                //                   ),
                //                 ],
                //               ),
                //               kH10sizedBox,
                //               SizedBox(
                //                 width: width - 96,
                //                 child: Row(
                //                   children: [
                //                     const Icon(
                //                       Icons.favorite_outline,
                //                       color: cWhiteColor,
                //                       size: kIconSize20,
                //                     ),
                //                     kW6sizedBox,
                //                     Text(
                //                       "100K",
                //                       style: regular12TextStyle(
                //                           cGreyColor.withOpacity(0.8)),
                //                     ),
                //                     kW12sizedBox,
                //                     SizedBox(
                //                       height: h8.h,
                //                       child: VerticalDivider(
                //                         width: 1,
                //                         thickness: 1,
                //                         color: cWhiteColor.withOpacity(0.14),
                //                       ),
                //                     ),
                //                     kW12sizedBox,
                //                     SvgPicture.asset(
                //                       kiMessage,
                //                       width: 14.w,
                //                       height: 14.h,
                //                       color: cWhiteColor,
                //                     ),
                //                     kW6sizedBox,
                //                     Text(
                //                       "10k replies",
                //                       style: regular12TextStyle(
                //                           cGreyColor.withOpacity(0.8)),
                //                     ),
                //                     kW6sizedBox,
                //                     const Icon(
                //                       Icons.keyboard_arrow_down_outlined,
                //                       color: cWhiteColor,
                //                       size: kIconSize20,
                //                     ),
                //                     const Expanded(child: SizedBox()),
                //                     Row(
                //                       children: [
                //                         SvgPicture.asset(
                //                           kiReply,
                //                           width: 16.w,
                //                           height: 16.h,
                //                           color: cPrimaryColor2,
                //                         ),
                //                         kW14sizedBox,
                //                         Text(
                //                           ksReply.tr,
                //                           style:
                //                               regular16TextStyle(cPrimaryColor2),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //       kH12sizedBox,
                //       Padding(
                //         padding: EdgeInsets.only(left: 52.w),
                //         child: SizedBox(
                //           width: width - 72,
                //           child: Column(
                //             children: [
                //               Divider(
                //                 thickness: 1,
                //                 color: cWhiteColor.withOpacity(0.14),
                //               ),
                //               Text(
                //                 "Lorem ipsum dolor sit amet consectetur. Eget dictum at ipsum ridiculus nec. Viverra mauris molestie ut rhoncus.",
                //                 style: regular14TextStyle(cWhiteColor),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       kH12sizedBox,
                //       Divider(
                //         thickness: 1,
                //         color: cWhiteColor.withOpacity(0.14),
                //       ),
                //       kH20sizedBox,
                //       Text(
                //         ksAddYourComment.tr,
                //         style: medium16TextStyle(cWhiteColor),
                //       ),
                //       kH20sizedBox,
                //       CustomModifiedTextField(
                //         hint: ksEnterHere.tr,
                //         controller:
                //             homeController.addCommentTextEditingController,
                //         fillColor: cBlackColor,
                //         textInputStyle: regular14TextStyle(cWhiteColor),
                //         focusBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(k6BorderRadius),
                //           borderSide: const BorderSide(
                //             width: 1,
                //             color: cPrimaryColor2,
                //           ),
                //         ),
                //         maxLines: 4,
                //         inputAction: TextInputAction.newline,
                //         inputType: TextInputType.multiline,
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(k6BorderRadius),
                //           borderSide: BorderSide(
                //             width: 1,
                //             color: cWhiteColor.withOpacity(0.3),
                //             style: BorderStyle.solid,
                //           ),
                //         ),
                //         contentPadding: const EdgeInsets.all(12),
                //       ),
                //       kH12sizedBox,
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             width: 34.w,
                //             height: 34.h,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(k6BorderRadius),
                //               color: cWhiteColor.withOpacity(0.1),
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(9.0),
                //               child: SvgPicture.asset(
                //                 kiEmoji,
                //                 width: 16.w,
                //                 height: 16.h,
                //                 color: cWhiteColor,
                //               ),
                //             ),
                //           ),
                //           Row(
                //             children: [
                //               CustomElevatedButton(
                //                 label: ksCancel.tr,
                //                 onPressed: () {},
                //                 buttonColor: cWhiteColor.withOpacity(0.1),
                //                 textStyle: regular16TextStyle(cWhiteColor),
                //                 buttonWidth: 70.w,
                //                 buttonHeight: h36.h,
                //               ),
                //               kW12sizedBox,
                //               CustomElevatedButton(
                //                 label: ksPostNow.tr,
                //                 onPressed: () {},
                //                 buttonColor: cPrimaryColor2,
                //                 textStyle: regular16TextStyle(cWhiteColor),
                //                 buttonWidth: 90.w,
                //                 buttonHeight: h36.h,
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //       kH20sizedBox,
                //     ],
                //   ),
                // ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}

