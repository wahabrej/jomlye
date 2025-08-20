import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:vidflix_flutter_app/screens/video_player/live_tv_player_screen.dart';
import 'package:vidflix_flutter_app/screens/video_player/tv_show_player_screen.dart';
import 'package:vidflix_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/widgets/common/common_bottom_nav_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();
  final ProfileController profileController = Get.find<ProfileController>();
    final AllVideoPlayerController allVideoPlayerController =
      Get.find<AllVideoPlayerController>();
  bool isBackPressedOnce = false;
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    homeController.bannerAd!.load();
    return SafeArea(
      top: false,
      child: WillPopScope(
        onWillPop: () async {
          if (_lastBackPressed == null ||
              DateTime.now().difference(_lastBackPressed!) >
                  const Duration(seconds: 2)) {
            _lastBackPressed = DateTime.now();
            isBackPressedOnce = true;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Press again to exit'),
                duration: Duration(seconds: 2),
              ),
            );
            return false;
          } else {
            isBackPressedOnce = false;
            return true;
          }
        },
        //!referesh indicator for home
        child: RefreshIndicator(
          backgroundColor: cWhiteColor,
          color: cPrimaryColor,
          onRefresh: () async {
            await homeController.getHomePage();
          },
          child: Scaffold(
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
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        kiVidflix,
                        width: h24.w,
                        height: h24.h,
                        color: cPrimaryColor2,
                      ),
                      kW4sizedBox,
                      Center(
                        child: Text(
                          ksVidflix.tr,
                          style: semiBold20TextStyle(cWhiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      homeController.resetBottomSheetData();
                      await homeController.getGlobalSearch();
                      Get.toNamed(krSearchScreen);
                    },
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: cWhiteColor,
                        size: kIconSize24,
                      ),
                    ),
                  ),
                  kW12sizedBox,
                ],
              ),
            ),
            body: Obx(
              () => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(Get.find<GlobalController>().subscribedUserCheck.value==false)
                    Center(
                        child: SizedBox(
                            width: width - 40,
                            child: BannerAdWidget(
                                homeController: homeController))),
                    HomeSlider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: k20Padding),
                          child: Text(
                            ksExploreMovieByGenre.tr,
                            style: medium16TextStyle(cWhiteColor),
                          ),
                        ),
                      ],
                    ),
                    kH16sizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: k20Padding),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width - 20,
                            height: 34.h,
                            child: ListView.separated(
                              itemCount: homeController.genreList.length,
                              separatorBuilder: (context, index) => kW8sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Obx(() => GestureDetector(
                                      onTap: () {
                                        homeController.selectedGenre.value =
                                            homeController
                                                    .genreList[index].name ??
                                                "";
                                        homeController.selectedGenreId.value =
                                            homeController
                                                    .genreList[index].id ??
                                                -1;
                                        homeController.isApplyClicked.value =
                                            true;
                                        homeController.getFilterMovieList();
                                        homeController
                                            .isHomeGenreClicked.value = true;
                                        Get.toNamed(krMovieViewAllScreen);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: homeController
                                                      .selectedGenreId.value ==
                                                  homeController
                                                      .genreList[index].id
                                              ? cPrimaryColor2
                                              : cWhiteColor.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 6.h),
                                          child: Center(
                                            child: Text(
                                              homeController
                                                      .genreList[index].name ??
                                                  "",
                                              style: regular14TextStyle(
                                                  cWhiteColor),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    kH16sizedBox,
                    HomeTitleContent(
                      title: ksNewRelease.tr,
                      subtitleText:
                          homeController.newReleaseMoviesList.isNotEmpty
                              ? ksViewAll.tr
                              : "",
                      onPressed: () async {
                        homeController.selectedServer.value=0;
                        homeController.resetBottomSheetData();
                        profileController.temporaryPlayListCheckBoxStateList
                            .clear();
                        homeController.isViewAllSearchEnable.value = false;
                        homeController.viewAllTextEditingController.clear();
                        homeController.selectedTitle.value = ksNewRelease;
                        await homeController.getMovieList(
                            movieType: "newRelease");
                        homeController.isHomeGenreClicked.value = false;
                        Get.toNamed(krMovieViewAllScreen);
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
                                  homeController.newReleaseMoviesList.length,
                              separatorBuilder: (context, index) => kW8sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    homeController.resetRatingData();
                                    await homeController.getMovieDetails(
                                        movieId: homeController
                                            .newReleaseMoviesList[index].id!
                                            .toString());
                                    profileController.isFavoriteAdded.value =
                                        homeController.movieDetailsData.value
                                                ?.isFavorite ??
                                            false;
                                    if(homeController.movieServerList.isNotEmpty){
                                    allVideoPlayerController.videoPlayerFunction(isFree: homeController.newReleaseMoviesList[index].isFree,isRental:  homeController.newReleaseMoviesList[index].isRental,isRented: homeController.movieDetailsModel.value?.isRented, isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value, fileUrl: homeController.movieServerList[0]?.fileUrl, fileSource: homeController.movieServerList[0]?.fileSource);
                                    }

                                    Get.to(()=> VideoPlayerScreen(isRentableVideo: homeController
                                                .newReleaseMoviesList[index]
                                                .isFree==false && homeController
                                                .newReleaseMoviesList[index]
                                                .isRental==true,));
                                  },
                                  child: MovieContentContainer(
                                    movieImage: homeController
                                        .newReleaseMoviesList[index].thumbnail,
                                    isPremium: homeController
                                                .newReleaseMoviesList[index]
                                                .isFree==false && homeController
                                                .newReleaseMoviesList[index]
                                                .isRental == false,
                                   isRentable: homeController
                                                .newReleaseMoviesList[index]
                                                .isFree==false && homeController
                                                .newReleaseMoviesList[index]
                                                .isRental==true,
                                   price: homeController
                                                .newReleaseMoviesList[index].price,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    kH16sizedBox,
                    HomeTitleContent(
                      title: ksTrendingMovies.tr,
                      subtitleText: homeController.trendingMoviesList.isNotEmpty
                          ? ksViewAll.tr
                          : "",
                      onPressed: () async {
                        homeController.resetBottomSheetData();
                        profileController.temporaryPlayListCheckBoxStateList
                            .clear();
                        homeController.isViewAllSearchEnable.value = false;
                        homeController.viewAllTextEditingController.clear();
                        homeController.selectedTitle.value = ksTrendingMovies;
                        await homeController.getMovieList(
                            movieType: "trending");
                        homeController.isHomeGenreClicked.value = false;
                        Get.toNamed(krMovieViewAllScreen);
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
                                  homeController.trendingMoviesList.length,
                              separatorBuilder: (context, index) => kW8sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    homeController.selectedServer.value=0;
                                    homeController.resetRatingData();
                                    await homeController.getMovieDetails(
                                        movieId: homeController
                                            .trendingMoviesList[index].id!
                                            .toString());
                                    profileController.isFavoriteAdded.value =
                                        homeController.movieDetailsData.value
                                                ?.isFavorite ??
                                            false;
                                   if(homeController.movieServerList.isNotEmpty){
                                    allVideoPlayerController.videoPlayerFunction(isFree: homeController.trendingMoviesList[index].isFree,isRental:  homeController.trendingMoviesList[index].isRental,isRented: homeController.movieDetailsModel.value?.isRented, isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value, fileUrl: homeController.movieServerList[0]?.fileUrl, fileSource: homeController.movieServerList[0]?.fileSource);
                                    }

                                    Get.to(()=> VideoPlayerScreen(isRentableVideo: homeController
                                                .trendingMoviesList[index]
                                                .isFree==false && homeController
                                                .trendingMoviesList[index]
                                                .isRental==true,));
                                  },
                                  child: MovieContentContainer(
                                    movieImage: homeController
                                        .trendingMoviesList[index].thumbnail,
                                     isPremium: homeController
                                                .trendingMoviesList[index]
                                                .isFree==false && homeController
                                                .trendingMoviesList[index]
                                                .isRental == false,
                                    isRentable: homeController
                                                .trendingMoviesList[index]
                                                .isFree==false && homeController
                                                .trendingMoviesList[index]
                                                .isRental == true,
                                    price: homeController
                                                .trendingMoviesList[index].price, 
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: k20Padding),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width - 20,
                            height: 150.h,
                            child: ListView.separated(
                              itemCount:
                                  homeController.recommendedMoviesList.length,
                              separatorBuilder: (context, index) => kW8sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    homeController.selectedServer.value=0;
                                    homeController.resetRatingData();
                                    await homeController.getMovieDetails(
                                        movieId: homeController
                                            .recommendedMoviesList[index].id!
                                            .toString());
                                    profileController.isFavoriteAdded.value =
                                        homeController.movieDetailsData.value
                                                ?.isFavorite ??
                                            false;
                                           if(homeController.movieServerList.isNotEmpty){
                                    allVideoPlayerController.videoPlayerFunction(isFree: homeController.recommendedMoviesList[index].isFree,isRental:  homeController.recommendedMoviesList[index].isRental,isRented: homeController.movieDetailsModel.value?.isRented, isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value, fileUrl: homeController.movieServerList[0]?.fileUrl, fileSource: homeController.movieServerList[0]?.fileSource);
                                    }
                                    Get.to(()=> VideoPlayerScreen(isRentableVideo: homeController
                                                .recommendedMoviesList[index]
                                                .isFree==false && homeController
                                                .recommendedMoviesList[index]
                                                .isRental==true,));     
                                  },
                                  child: MovieContentContainer(
                                    movieImage: homeController
                                        .recommendedMoviesList[index].thumbnail,
                                    // seasonName: ,
                                    isPremium: homeController
                                                .recommendedMoviesList[index]
                                                .isFree==false && homeController
                                                .recommendedMoviesList[index]
                                                .isRental == false,
                                                isRentable:  homeController
                                                .recommendedMoviesList[index]
                                                .isFree==false && homeController
                                                .recommendedMoviesList[index]
                                                .isRental == true,
                                                price: homeController
                                                .recommendedMoviesList[index].price,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    kH16sizedBox,
                    HomeTitleContent(
                      title: ksPopularTvShows.tr,
                      subtitleText: homeController.popularTvShowsList.isNotEmpty
                          ? ksViewAll.tr
                          : "",
                      onPressed: () async {
                        homeController.resetBottomSheetData();
                        profileController.temporaryPlayListCheckBoxStateList
                            .clear();
                        homeController.isViewAllSearchEnable.value = false;
                        homeController.viewAllTextEditingController.clear();
                        homeController.selectedTitle.value = ksPopularTvShows;
                        await homeController.getTvShows();
                        Get.toNamed(krTvShowsViewAllScreen);
                        // Get.toNamed(krMovieViewAllScreen);
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
                                  homeController.popularTvShowsList.length,
                              separatorBuilder: (context, index) => kW8sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    // await homeController.getTvShowDetails(showId: homeController
                                    //     .tvShowEpisodeList[index]?.id??-1);
                                    homeController.selectedEpisode.value = 0;
                                    await homeController.getTvShowDetails(showId: homeController
                                        .popularTvShowsList[index].id??-1);
                                         if(homeController.tvShowEpisodeList.isNotEmpty){
                                    allVideoPlayerController.videoPlayerFunction(isFree: homeController
                                                .popularTvShowsList[index]
                                                .isFree==0 ? true : false, isRental: homeController
                                                .popularTvShowsList[index]
                                                .isRental==0 ? false : true, 
                                                // isRented: homeController
                                                // .tvShowEpisodeList[0].isRental==0 ? false : true,
                                                  isRented:  true,
                                                 isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value, fileUrl: homeController
                                                .tvShowEpisodeList[homeController.selectedEpisode.value]?.fileUrl??"", fileSource: homeController
                                                .tvShowEpisodeList[homeController.selectedEpisode.value]?.fileSource??"");
                                         }
                                    Get.to(()=> TvShowPlayerScreen(isRentableVideo: homeController
                                                .popularTvShowsList[index]
                                                .isFree==0 && homeController
                                                .popularTvShowsList[index]
                                                .isRental==1 ? true : false,));
                                  },
                                  child: MovieContentContainer(
                                    movieImage: homeController
                                        .popularTvShowsList[index].thumbnail,
                                    // seasonName: ,
                                    isPremium: homeController
                                                .popularTvShowsList[index]
                                                .isFree==0
                                                 && homeController
                                                .popularTvShowsList[index]
                                                .isRental==0 ? true : false,
                                                isRentable: homeController
                                                .popularTvShowsList[index]
                                                .isFree==0 && homeController
                                                .popularTvShowsList[index]
                                                .isRental==1 ? true : false,
                                                price: homeController
                                                .popularTvShowsList[index]
                                                .rentalPrice!=null ? homeController
                                                .popularTvShowsList[index]
                                                .rentalPrice.toString():"",
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                   if(homeController.watchHistoryList.isNotEmpty) kH16sizedBox,
                    if(homeController.watchHistoryList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: k20Padding),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width - 20,
                            height: 150.h,
                            child: ListView.separated(
                              itemCount: homeController.watchHistoryList.length,
                              separatorBuilder: (context, index) =>
                                  kW10sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    if (homeController.watchHistoryList[index]
                                            ?.watchableType
                                            ?.toLowerCase() ==
                                        "movie") {
                                        homeController.selectedServer.value=0;
                                    homeController.resetRatingData();
                                      await homeController.getMovieDetails(
                                          movieId: homeController
                                              .watchHistoryList[index]!
                                              .watchableId!
                                              .toString());
                                               profileController.isFavoriteAdded.value =
                                        homeController.movieDetailsData.value
                                                ?.isFavorite ??
                                            false;
                                           if(homeController.movieServerList.isNotEmpty){
                                    allVideoPlayerController.videoPlayerFunction(isFree: homeController.movieDetailsData.value?.isFree==1? true : false,isRental:  homeController.movieDetailsData.value?.isRental==1 ? true : false,isRented: homeController.movieDetailsModel.value?.isRented, isSubscribed: Get.find<GlobalController>().subscribedUserCheck.value, fileUrl: homeController.movieServerList[0]?.fileUrl, fileSource: homeController.movieServerList[0]?.fileSource,seekToPosition: (((double.tryParse((homeController.watchHistoryList[index]?.watchedSeconds ?? "0").replaceAll("mins", "").trim()) ?? 0.0) * 60).round()),);
                                    }
                                    Get.to(()=> VideoPlayerScreen(isRentableVideo: homeController.movieDetailsData.value?.isFree==0 && homeController
                                                .movieDetailsData.value?.isRental==1,));   
                                    } else if (homeController
                                            .watchHistoryList[index]
                                            ?.watchableType
                                            ?.toLowerCase() ==
                                        "episode") {
                                      await homeController.getTvShowDetails(
                                          showId: homeController
                                              .watchHistoryList[index]!
                                              .watchableId!);
                                      Get.toNamed(krTvShowPlayerScreen);
                                    }
                                  },
                                  child: MovieCard(
                                    imageUrl: homeController
                                            .watchHistoryList[index]
                                            ?.watchableDetails
                                            ?.thumbnail ??
                                        "",
                                    title: homeController
                                            .watchHistoryList[index]
                                            ?.watchableDetails
                                            ?.title ??
                                        "",
                                    duration: homeController
                                            .watchHistoryList[index]
                                            ?.duration ??
                                        "",
                                    completePercentage: homeController
                                            .watchHistoryList[index]
                                            ?.completionPercentage ??
                                        "",
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    kH16sizedBox,
                    HomeTitleContent(
                      title: ksFeaturedTvChannels.tr,
                      subtitleText:
                          homeController.featuredTvChannelsList.isNotEmpty
                              ? ksViewAll.tr
                              : "",
                      onPressed: () async {
                        homeController.resetBottomSheetData();
                        profileController.temporaryPlayListCheckBoxStateList
                            .clear();
                        homeController.isViewAllSearchEnable.value = false;
                        homeController.viewAllTextEditingController.clear();
                        await homeController.getTvChannel();
                        Get.toNamed(krTvChannelsViewAllScreen);
                      },
                    ),
                    kH16sizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: k20Padding),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width - 20,
                            height: 120.h,
                            child: ListView.separated(
                              itemCount:
                                  homeController.featuredTvChannelsList.length,
                              separatorBuilder: (context, index) => kW8sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await homeController.getTvChannelDetails(
                                        tvChannelId: homeController
                                            .featuredTvChannelsList[index].id);
                                    profileController.isFavoriteAdded.value =  homeController
                                              .liveTvDetailsData.value?.isFavorite??false;
                                    // Get.toNamed(krLiveTvPlayerScreen);
                                    // Get.to(() => LiveTvPlayerScreen(
                                    //       liveTvUrl: homeController
                                    //           .featuredTvChannelsList[index]
                                    //           .streamUrl,
                                    //     ));
                                        homeController.liveTvUrl.value = homeController
                                              .featuredTvChannelsList[index]
                                              .streamUrl??"";

                                    Get.toNamed(krLiveTvPlayerScreen);
                                  },
                                  child: FeaturedTvChannelsContentContainer(
                                    image: homeController
                                            .featuredTvChannelsList[index]
                                            .thumbnail ??
                                        "",
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // kH16sizedBox,
                    // HomeTitleContent(
                    //   title: ksTvSeries.tr,
                    //   subtitleText: homeController.tvShowsList.isNotEmpty
                    //       ? ksViewAll.tr
                    //       : "",
                    //   onPressed: () async {
                    //     homeController.resetBottomSheetData();
                    //     profileController.temporaryPlayListCheckBoxStateList
                    //         .clear();
                    //     homeController.isViewAllSearchEnable.value = false;
                    //     homeController.viewAllTextEditingController.clear();
                    //     await homeController.getTvShows();
                    //     Get.toNamed(krTvShowsViewAllScreen);
                    //   },
                    // ),
                    // kH16sizedBox,
                    // Padding(
                    //   padding: const EdgeInsets.only(left: k20Padding),
                    //   child: Row(
                    //     children: [
                    //       SizedBox(
                    //         width: width - 20,
                    //         height: 150.h,
                    //         child: ListView.separated(
                    //           itemCount: homeController.tvShowsList.length,
                    //           separatorBuilder: (context, index) =>
                    //               kW10sizedBox,
                    //           shrinkWrap: true,
                    //           physics: const AlwaysScrollableScrollPhysics(),
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (context, index) {
                    //             return MovieContentContainer(
                    //               movieImage: homeController
                    //                   .tvShowsList[index].thumbnail,
                    //               // seasonName: homeController.tvShowsList[index].,
                    //               isPremium: homeController
                    //                           .tvShowsList[index].isPaid ==
                    //                       1
                    //                   ? true
                    //                   : false,
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    kH16sizedBox,
                    HomeTitleContent(
                      title: ksTopArtists.tr,
                      subtitleText: homeController.topArtistsList.isNotEmpty
                          ? ksViewAll.tr
                          : "",
                      onPressed: () async {
                        homeController.resetBottomSheetData();
                        homeController.isViewAllSearchEnable.value = false;
                        homeController.viewAllTextEditingController.clear();
                        await homeController.getArtistList();
                        Get.toNamed(krTopArtistsViewAllScreen);
                      },
                    ),
                    kH16sizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: k20Padding),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width - 20,
                            height: 88.h,
                            child: ListView.separated(
                              itemCount: homeController.topArtistsList.length,
                              separatorBuilder: (context, index) =>
                                  kW10sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return TopArtistContent(
                                  image: homeController
                                          .topArtistsList[index].starImage ??
                                      "",
                                  name: homeController
                                          .topArtistsList[index].starName ??
                                      "",
                                  onPressed: () async {
                                    await homeController.getArtistDetails(
                                        homeController
                                            .topArtistsList[index].id);
                                    homeController.castSelectedIndex.value = 0;
                                    Get.toNamed(krCastDetailsScreen);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    kH16sizedBox,
                    HomeTitleContent(
                      title: ksLatestBlog.tr,
                      subtitleText: homeController.latestBlogsList.isNotEmpty
                          ? ksViewAll.tr
                          : "",
                      onPressed: () async {
                        homeController.resetBottomSheetData();
                        homeController.isViewAllSearchEnable.value = false;
                        homeController.viewAllTextEditingController.clear();
                        await homeController.getBlogList();
                        Get.toNamed(krAllBlogsViewAllScreen);
                      },
                    ),
                    kH16sizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: k16Padding),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width - 20,
                            height: 210.h,
                            child: ListView.separated(
                              itemCount: homeController.latestBlogsList.length,
                              padding: const EdgeInsets.all(k0Padding),
                              separatorBuilder: (context, index) =>
                                  kW10sizedBox,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    homeController.resetRatingData();
                                    await homeController.getBlogDetails(
                                        homeController
                                            .latestBlogsList[index].id);
                                    Get.toNamed(krBlogSingleScreen);
                                    await homeController.getUserReview(
                                        reviewableId: homeController
                                            .latestBlogsList[index].id!,
                                        reviewableType: "blog");
                                  },
                                  child: LatestBlogPostContent(
                                    image: homeController
                                            .latestBlogsList[index].image ??
                                        "",
                                    title: homeController
                                            .latestBlogsList[index].title ??
                                        "",
                                    subTitle: homeController
                                            .latestBlogsList[index].seoTitle ??
                                        "",
                                    date: DateFormat('d MMM, yyyy').format(
                                        DateTime.parse(homeController
                                            .latestBlogsList[index].createdAt
                                            .toString())),
                                    reporter: homeController
                                            .latestBlogsList[index].author ??
                                        "",
                                    isTop: homeController
                                        .latestBlogsList[index].isTop,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (int i = 0; i < homeController.localAdList.length; i++)
                      if (homeController.localAdList[i].position
                              ?.toLowerCase() ==
                          "footer" && (Get.find<GlobalController>().subscribedUserCheck.value==false))
                        ClipRRect(
                          borderRadius: BorderRadius.circular(k8BorderRadius),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                    vertical: k12Padding,
                                    horizontal: k28Padding)
                                .copyWith(right: 8),
                            child: SizedBox(
                              width: width,
                              child: Image.network(
                                homeController.localAdList[i].banner ?? "",
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
                          ),
                        ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(
              width: width,
              selectedIndex: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class LatestBlogPostContent extends StatelessWidget {
  const LatestBlogPostContent(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.date,
      required this.reporter,
      required this.isTop,
      this.contentHeight});
  final String image, title, subTitle, date, reporter;
  final double? contentHeight;
  final int? isTop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //!extra added this sized box. remove it
      width: (width - 30) / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(k6BorderRadius),
        child: Stack(
          children: [
            Image.network(
              image,
              height: contentHeight ?? 210.h,
              width: (width - 30) / 1.8,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: SvgPicture.asset(
                  kiDummyMovie,
                  height: contentHeight ?? 210.h,
                  width: (width - 30),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            if (isTop == 1)
              Positioned(
                top: 10,
                left: 14,
                child: Container(
                  height: 14.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    color: cPrimaryColor2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: k4Padding, vertical: k2Padding),
                    child: Text(
                      ksTopNews.tr,
                      style: regular10TextStyle(cWhiteColor),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 210.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: cBlackColor.withOpacity(0.8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k12Padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          child: Text(
                        title,
                        style: semiBold10TextStyle(cWhiteColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      kH4sizedBox,
                      SizedBox(
                          child: Text(
                        subTitle,
                        style: regular8TextStyle(cWhiteColor.withOpacity(0.5)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      kH4sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.calendar_month_rounded,
                            size: kIconSize16,
                            color: cWhiteColor,
                          ),
                          kW4sizedBox,
                          Text(
                            date,
                            style: regular8TextStyle(cWhiteColor),
                          ),
                          kW8sizedBox,
                          const Icon(
                            Icons.person_pin_rounded,
                            size: kIconSize16,
                            color: cWhiteColor,
                          ),
                          kW4sizedBox,
                          Expanded(
                            child: Text(
                              reporter,
                              style: regular8TextStyle(cWhiteColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      kH16sizedBox,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    this.imageUrl,
    this.title,
    this.duration,
    this.completePercentage,
  });

  final String? imageUrl, title, duration, completePercentage;

  @override
  Widget build(BuildContext context) {
    // Parse percentage value safely
    double percentage =
        double.parse((completePercentage ?? '0').replaceAll('%', ''));
    percentage = percentage.clamp(0.0, 100.0);

    return Stack(
      children: [
        // Background Image
        ClipRRect(
          borderRadius: BorderRadius.circular(k6BorderRadius),
          child: Image.network(
            imageUrl ?? "",
            width: (width - 70) / 2.6,
            height: 150.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
              child: SvgPicture.asset(
                kiDummyMovie,
                width: (width - 70) / 2.6,
                height: 150.h,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),

        // Gradient Overlay
        Container(
          width: (width - 70) / 2.6,
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(k6BorderRadius),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [
                cBlackColor.withOpacity(0.8),
                cBlackColor.withOpacity(0.0),
              ],
            ),
          ),
        ),

        // Title, Duration and Progress Bar
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: semiBold12TextStyle(cWhiteColor),
              ),
              kH4sizedBox,
              Text(
                duration ?? "",
                style: regular10TextStyle(cWhiteColor),
              ),
              kH4sizedBox,

              // ✅ Progress Bar
              Container(
                height: 6,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white, // Background track
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: percentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: cPrimaryColor2, // Filled portion
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TopArtistContent extends StatelessWidget {
  const TopArtistContent(
      {super.key,
      required this.image,
      required this.name,
      this.contentWidth,
      this.contentHeight,
      this.onPressed});
  final String image, name;
  final double? contentWidth, contentHeight;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(k4BorderRadius),
              child: Image.network(
                image,
                width: contentWidth ?? 88.w,
                height: contentHeight ?? 88.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: SvgPicture.asset(
                    kiDummyMovie,
                    height: 100.h,
                    width: 100.w,
                    fit: BoxFit.fill,
                  ),
                ),
              )),
          Positioned(
            bottom: 4,
            left: 4,
            right: 4,
            child: Container(
              width: 80.w,
              height: 20.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(k4BorderRadius),
                color: cBlackColor.withOpacity(0.6),
              ),
              child: Center(
                  child: Text(
                name,
                style: semiBold10TextStyle(cWhiteColor),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedTvChannelsContentContainer extends StatelessWidget {
  const FeaturedTvChannelsContentContainer(
      {super.key,
      required this.image,
      this.containerWidth,
      this.containerHeight});
  final String image;
  final double? containerWidth, containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth ?? 120.w,
      height: containerHeight ?? 120.h,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k6BorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(k20Padding),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Center(
            child: SvgPicture.asset(
              kiDummyMovie,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTitleContent extends StatelessWidget {
  const HomeTitleContent(
      {super.key,
      required this.title,
      required this.subtitleText,
      this.onPressed,
      this.isHorizontalPadding = true});
  final String title, subtitleText;
  final VoidCallback? onPressed;
  final bool? isHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isHorizontalPadding!
          ? const EdgeInsets.symmetric(horizontal: k20Padding)
          : const EdgeInsets.symmetric(horizontal: k0Padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: medium16TextStyle(cWhiteColor),
          ),
          InkWell(
              onTap: onPressed,
              child: Text(
                subtitleText,
                style: regular12TextStyle(cPrimaryColor2),
              )),
        ],
      ),
    );
  }
}

class MovieContentContainer extends StatelessWidget {
  const MovieContentContainer({super.key, this.movieImage, this.price,this.isPremium,this.isRentable});
  final String? movieImage,price;
  final bool? isPremium, isRentable;

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
        if (isPremium == true && isRentable == false)
          Positioned(
              top: 4,
              right: 4,
              child: Container(
                height: 16.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(k6BorderRadius),
                  color: cPrimaryColor2,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: k4Padding, vertical: 1),
                  child: Center(
                      child: Text(
                    isPremium! ? "Premium" : "",
                    style: regular10TextStyle(cWhiteColor),
                  )),
                ),
              )),
       if (isRentable == true && isPremium == false)
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
                    isRentable! ? "Rent ${price ?? ""} " : "",
                    style: regular10TextStyle(cWhiteColor),
                  )),
                ),
              )),
      ],
    );
  }
}

class HomeSlider extends StatelessWidget {
  HomeSlider({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        homeController.resetRatingData();
        // homeController.showInterstitialAd();
        await homeController.getMovieDetails(
            movieId: homeController
                .sliderList[homeController.currentIndex.value].id!
                .toString());
        // Get.find<ProfileController>().isFavoriteAdded.value =
        //     homeController.sliderList[homeController.currentIndex.value]?.isFavorite ??
        //         false;
        if (homeController.movieServerList.isNotEmpty) {
          String videoUrl = homeController.movieServerList[0]?.fileUrl ?? "";
          Get.find<AllVideoPlayerController>().flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(videoUrl),
          );
        } else {
          String videoUrl = "";
          Get.find<AllVideoPlayerController>().flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(videoUrl),
          );
        }
        Get.toNamed(krVideoPlayerScreen, arguments: "");
      },
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: height * 0.45,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                homeController.updateCurrentIndex(index);
              },
            ),
            items: homeController.sliderList.map((slider) {
              return Stack(
                children: [
                  // Background Image
                  SizedBox(
                    width: width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(k8BorderRadius.r),
                      child: Image.network(
                        slider.thumbnail ?? "",
                        fit: BoxFit.cover,
                        width: width,
                        height: height * 0.45,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(),
                      ),
                    ),
                  ),

                  // // Top Bar (Logo & Search)
                  // Positioned(
                  //   top: 40.h,
                  //   left: 15.w,
                  //   right: 15.w,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           SvgPicture.asset(
                  //             kiVidflix,
                  //             width: 28.w,
                  //             height: 28.w,
                  //           ),
                  //           kW6sizedBox,
                  //           Text(
                  //             ksVidflix.tr,
                  //             style: semiBold18TextStyle(cWhiteColor),
                  //           ),
                  //         ],
                  //       ),
                  //       GestureDetector(
                  //         onTap: () async {
                  //           homeController.resetBottomSheetData();
                  //           await homeController.getGlobalSearch();
                  //           Get.toNamed(krSearchScreen);
                  //         },
                  //         child: Container(
                  //           width: 32.w,
                  //           height: 32.h,
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: cWhiteColor.withOpacity(0.2),
                  //           ),
                  //           child: const Icon(
                  //             Icons.search,
                  //             color: cWhiteColor,
                  //             size: kIconSize24,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Bottom Overlay Section (Ordered as requested)
                  Positioned(
                    bottom: 30.h,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Tags (Action, Trending, 2024)
                        // if (slider.tags.isNotEmpty)
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: slider.tags.map<Widget>((tag) {
                        //     return Container(
                        //       margin: const EdgeInsets.symmetric(horizontal: 5),
                        //       padding: const EdgeInsets.symmetric(
                        //           horizontal: 10, vertical: 4),
                        //       decoration: BoxDecoration(
                        //         color: cWhiteColor.withOpacity(0.2),
                        //         borderRadius: BorderRadius.circular(8.r),
                        //         border: Border.all(
                        //           width: 1.33,
                        //           color: cPrimaryColor2.withOpacity(0.3),
                        //         ),
                        //       ),
                        //       child: Text(
                        //         tag,
                        //         style: semiBold14TextStyle(cWhiteColor),
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                        kH10sizedBox,

                        // Dots Indicator
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                homeController.sliderList.length,
                                (index) => Container(
                                  width:
                                      homeController.currentIndex.value == index
                                          ? 24
                                          : 8,
                                  height: 8,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    color: homeController.currentIndex.value ==
                                            index
                                        ? cPrimaryColor2
                                        : cWhiteColor.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            )),
                        kH10sizedBox,

                        // Movie Name (after tags & dots)
                        SizedBox(
                          width: width * 0.95,
                          child: Text(
                            slider.title ?? "",
                            style: semiBold24TextStyle(cWhiteColor),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        kH10sizedBox,

                        // Play Button (bottom-most)
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: cPrimaryColor2,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            size: kIconSize28,
                            color: cWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          kH10sizedBox,
        ],
      ),
    );
  }
}

class BannerAdWidget extends StatelessWidget {
  final HomeController homeController;

  const BannerAdWidget({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return homeController.bannerAd != null
        ? Container(
            alignment: Alignment.bottomCenter,
            width: homeController.bannerAd!.size.width.toDouble(),
            height: homeController.bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: homeController.bannerAd!),
          )
        : const SizedBox.shrink();
  }
}
