import 'package:flixoo_flutter_app/screens/video_player/tv_show_player_screen.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:flixoo_flutter_app/screens/home/home_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';

class FavoriteScreen extends StatelessWidget {
   FavoriteScreen({super.key});
   final ProfileController profileController = Get.find<ProfileController>();
   final HomeController homeController = Get.find<HomeController>();
   final AllVideoPlayerController allVideoPlayerController = Get.find<AllVideoPlayerController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: k20Padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  kH40sizedBox,
                      Padding(
                        padding: const EdgeInsets.only(right: k20Padding),
                        child: Row(
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
                                        ksFavoriteList.tr,
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
                      ),
                    kH8sizedBox,
                    Divider(
                      color: cWhiteColor.withOpacity(0.2),
                    ),
                    kH8sizedBox,
                    if(profileController.favoriteLiveTvList.isNotEmpty)
                    Text(ksTVChannel.tr,style: medium16TextStyle(cWhiteColor),),
                   if(profileController.favoriteLiveTvList.isNotEmpty) kH16sizedBox,
                   if(profileController.favoriteLiveTvList.isNotEmpty)
                     SizedBox(
                      width: width - 20,
                      height: 120.h,
                      child: ListView.separated(
                        itemCount: profileController.favoriteLiveTvList.length,
                        separatorBuilder: (context, index) =>
                            kW8sizedBox,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                                     profileController.isFavoriteAdded.value = true;
                                    await Get.find<HomeController>().getTvChannelDetails(
                                        tvChannelId: profileController
                                            .favoriteLiveTvList[index].id);
                                    // Get.find<HomeController>().liveTvUrl.value = profileController
                                    //         .favoriteLiveTvList[index].
                                    Get.find<HomeController>().liveTvUrl.value = null;
                                   if(Get.find<GlobalController>().subscribedUserCheck.value==false){
                                    homeController.showInterstitialAd();
                                    }
                                    Get.toNamed(krLiveTvPlayerScreen);
                                    // Get.to(() => LiveTvPlayerScreen(
                                    //       // liveTvUrl: profileController
                                    //       //     .favoriteLiveTvList[index]
                                    //       //     .,
                                    //     ));
                                  },
                            child: FeaturedTvChannelsContentContainer(
                              image: profileController.favoriteLiveTvList[index].thumbnail??"",
                            ),
                          );
                        },
                      ),
                    ),
                    kH16sizedBox,
                    if(profileController.favoriteMovieList.isNotEmpty)
                   if(profileController.favoriteMovieList.isNotEmpty) Text(ksMovies.tr,style: medium16TextStyle(cWhiteColor),),
                    kH16sizedBox,
                    if(profileController.favoriteMovieList.isNotEmpty)
                          SizedBox(
                    width: width - 20,
                    height: 150.h,
                    child: ListView.separated(
                      itemCount: profileController.favoriteMovieList.length,
                      separatorBuilder: (context, index) =>
                          kW10sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                                  onTap: () async {
                                    Get.find<HomeController>().selectedServer.value=0;
                                    Get.find<HomeController>().resetRatingData();
                                        await Get.find<HomeController>().getMovieDetails(
                                        movieId: profileController.favoriteMovieList[index].id
                                            .toString());
                                    profileController.isFavoriteAdded.value = true;
                                    if(Get.find<HomeController>().movieServerList.isNotEmpty){
                                   Get.find<AllVideoPlayerController>().videoPlayerFunction(isFree: Get.find<HomeController>().movieDetailsData.value?.isFree==1?true:false,isRental: Get.find<HomeController>().movieDetailsData.value?.isRental==1?true:false,isRented: Get.find<HomeController>().movieDetailsModel.value?.isRented, isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value, fileUrl: Get.find<HomeController>().movieServerList[0]?.fileUrl, fileSource: Get.find<HomeController>().movieServerList[0]?.fileSource);
                                    }
                                 if(Get.find<GlobalController>().subscribedUserCheck.value==false){
                                    homeController.showInterstitialAd();
                                    }
                                    Get.to(()=> VideoPlayerScreen(isRentableVideo: Get.find<HomeController>().movieDetailsData.value?.isFree==0 && Get.find<HomeController>().movieDetailsData.value?.isRental==1,));     
                                  },
                          child: MovieContentContainer(
                            movieImage: profileController.favoriteMovieList[index].thumbnail??"",
                            isPremium: profileController.favoriteMovieList[index].isFree==0 && profileController.favoriteMovieList[index].isRental==0 ? true : false,
                            isRentable: profileController.favoriteMovieList[index].isFree==0 && profileController.favoriteMovieList[index].isRental==1 ? true : false,
                            price: profileController.favoriteMovieList[index].rentalPrice.toString(),
                          ),
                        );
                      },
                    ),
                  ),
                    kH16sizedBox,
                    if(profileController.favoriteTvShowList.isNotEmpty)
                    Text(ksTvSeries.tr,style: medium16TextStyle(cWhiteColor),),
                  if(profileController.favoriteTvShowList.isNotEmpty)  kH16sizedBox,
                  if(profileController.favoriteTvShowList.isNotEmpty)
                    SizedBox(
                    width: width - 20,
                    height: 150.h,
                    child: ListView.separated(
                      itemCount: profileController.favoriteTvShowList.length,
                      separatorBuilder: (context, index) =>
                          kW10sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                             homeController.resetRatingData();
                                       homeController.selectedEpisode.value=0;
                                              profileController.isFavoriteAdded.value = 
                                        homeController.tvShowDetailsData.value
                                                ?.isFavorite ??
                                            false;
                                      await homeController.getTvShowDetails(
                                          showId: homeController
                                              .watchHistoryList[index]!
                                              .watchableId!);
                                               homeController.selectedEpisode.value = 0;
                                         if(homeController.tvShowEpisodeList.isNotEmpty){
                                    allVideoPlayerController.videoPlayerFunction(
                                       isFree: homeController.tvShowDetailsData.value?.isFree==1 ?true : false,
                                      isRental: homeController.tvShowDetailsData.value?.isFree==0 && homeController.tvShowDetailsData.value?.isRental==1 ? true : false,  
                                                  isRented:  homeController.tvShowDetailsModel.value?.isRented??false,
                                                 isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value,
                                                  fileUrl: homeController
                                                .tvShowEpisodeList[homeController.selectedEpisode.value]?.fileUrl??"", fileSource: homeController
                                                .tvShowEpisodeList[homeController.selectedEpisode.value]?.sourceType??"",seekToPosition: (((double.tryParse((homeController.watchHistoryList[index]?.watchedSeconds ?? "0").replaceAll("mins", "").trim()) ?? 0.0) * 60).round()));
                                         }
                                  if(Get.find<GlobalController>().subscribedUserCheck.value==false){
                                    homeController.showInterstitialAd();
                                    }
                                    Get.to(()=> TvShowPlayerScreen(isRentableVideo: homeController.tvShowDetailsData.value?.isFree==0 && homeController.tvShowDetailsData.value?.isRental==1 ? true : false,));
                                   
                          },
                          child: MovieContentContainer(
                            movieImage: profileController.favoriteTvShowList[index].thumbnail,
                            isPremium: profileController.favoriteTvShowList[index].isFree==0 && profileController.favoriteTvShowList[index].isRental==0 ? true : false,
                          ),
                        );
                      },
                    ),
                  ),
                  if(profileController.favoriteTvShowList.isEmpty && profileController.favoriteMovieList.isEmpty && profileController.favoriteLiveTvList.isEmpty)
                  SizedBox(
                        height: (height * 0.6),
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
                              style:
                                  regular14TextStyle(cWhiteColor.withOpacity(
                                0.5,
                              )),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

