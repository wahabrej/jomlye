import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:flixoo_flutter_app/screens/home/home_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/tv_show_player_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';

class RentedVideoScreen extends StatelessWidget {
   RentedVideoScreen({super.key});
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
                                        ksRentedVideo.tr,
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
                   if(profileController.tvShowRentedVideoList.isNotEmpty) Text(ksTvShows.tr,style: medium16TextStyle(cWhiteColor),),
                    if(profileController.movieRentedVideoList.isNotEmpty)  kH16sizedBox,
                   if(profileController.tvShowRentedVideoList.isNotEmpty)
                     SizedBox(
                      width: width - 20,
                      height: 120.h,
                      child: ListView.separated(
                        itemCount: profileController.tvShowRentedVideoList.length,
                        separatorBuilder: (context, index) =>
                            kW8sizedBox,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
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
                                          showId: profileController
                                              .tvShowRentedVideoList[index]!.videoId!);
                                               homeController.selectedEpisode.value = 0;
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
                                   if(Get.find<GlobalController>().subscribedUserCheck.value==false){
                                    homeController.showInterstitialAd();
                                    }
                                    Get.to(()=> TvShowPlayerScreen(isRentableVideo: homeController.tvShowDetailsData.value?.isFree==0 && homeController.tvShowDetailsData.value?.isRental==1 ? true : false,));
                                   
                            },
                            child: FeaturedTvChannelsContentContainer(
                              image: profileController.tvShowRentedVideoList[index]?.title??'',
                            ),
                          );
                        },
                      ),
                    ),
                    kH16sizedBox,
                  if(profileController.movieRentedVideoList.isNotEmpty)  Text(ksMovies.tr,style: medium16TextStyle(cWhiteColor),),
                  if(profileController.movieRentedVideoList.isNotEmpty) 
                    kH16sizedBox,
                     if(profileController.movieRentedVideoList.isNotEmpty) 
                    SizedBox(
                    width: width - 20,
                    height: 140.h,
                    child: ListView.separated(
                      itemCount: profileController.movieRentedVideoList.length,
                      separatorBuilder: (context, index) =>
                          kW10sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: ()async{
                            homeController.resetRatingData();
                                    await homeController.getMovieDetails(
                                        movieId: profileController
                                            .movieRentedVideoList[index]!.videoId
                                            .toString());
                                    profileController.isFavoriteAdded.value =
                                        homeController.movieDetailsData.value
                                                ?.isFavorite ??
                                            false;
                                    if(homeController.movieServerList.isNotEmpty){
                                    allVideoPlayerController.videoPlayerFunction(isFree: homeController.movieDetailsData.value?.isFree== 1 ? true : false,isRental: homeController.movieDetailsData.value?.isFree==0 &&  homeController.
                                                movieDetailsData.value?.isRental==1 ? true : false,isRented: homeController.movieDetailsModel.value?.isRented, isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value, fileUrl: homeController.movieServerList[0]?.fileUrl, fileSource: homeController.movieServerList[0]?.fileSource);
                                    }
                                 if(Get.find<GlobalController>().subscribedUserCheck.value==false){
                                    homeController.showInterstitialAd();
                                    }
                                    Get.to(()=> VideoPlayerScreen(isRentableVideo: true,));
                          },
                          child: RentedVideoContentContainer(
                             movieImage: profileController.movieRentedVideoList[index]?.image??"",
                             isRented: true,
                            // seasonName: profileController.tvSeriesList[index]["season"],
                            // isRented: profileController.rentedVideoList[index]?.videoType??"",
                            // isSeason: profileController.moviesList[index]["isSeason"],
                          ),
                        );
                      },
                    ),
                  ),
                  if(profileController.movieRentedVideoList.isEmpty && profileController.tvShowRentedVideoList.isEmpty)
                  SizedBox(
                        height: (height * 0.65),
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

class RentedVideoContentContainer extends StatelessWidget {
  const RentedVideoContentContainer({super.key, this.movieImage, this.isRented});
  final String? movieImage;
  final bool? isRented;
  @override
  Widget build(BuildContext context) {
   return Stack(
      children: [
        Container(
          width: (width - 70) / 2.6,
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(k6BorderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(k6BorderRadius),
            child: Image.network(
              movieImage ?? "",
              width: (width - 60) / 3,
              height: 150.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: SvgPicture.asset(
                  kiDummyMovie,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        if (isRented == true)
          Positioned(
              top: 4,
              right: 4,
              child: Container(
                height: 16.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(k6BorderRadius),
                  color: cPurpleColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: k4Padding, vertical: 1),
                  child: Center(
                      child: Text(
                    isRented! ? ksRented.tr : "",
                    style: regular10TextStyle(cWhiteColor),
                  )),
                ),
              )),
      ],
    );
  }
}