import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:flixoo_flutter_app/screens/home/home_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/live_tv_player_screen.dart';
import 'package:flixoo_flutter_app/screens/video_player/video_palyer_screen.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';

class FavoriteScreen extends StatelessWidget {
   FavoriteScreen({super.key});
   final ProfileController profileController = Get.find<ProfileController>();

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
                    Text(ksTVChannel.tr,style: medium16TextStyle(cWhiteColor),),
                    kH16sizedBox,
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
                    Text(ksMovies.tr,style: medium16TextStyle(cWhiteColor),),
                    kH16sizedBox,
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
                    Text(ksTvSeries.tr,style: medium16TextStyle(cWhiteColor),),
                    kH16sizedBox,
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
                          onTap: (){
                            
                          },
                          child: MovieContentContainer(
                            movieImage: profileController.favoriteTvShowList[index].thumbnail,
                            isPremium: profileController.favoriteTvShowList[index].isFree==0 && profileController.favoriteTvShowList[index].isRental==0 ? true : false,
                          ),
                        );
                      },
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

