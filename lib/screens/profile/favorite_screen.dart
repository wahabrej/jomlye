import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';

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
                              kiVidflix,
                              width: h24.w,
                              height: h24.h,
                              color: cPrimaryColor2,
                            ),
                            kW4sizedBox,
                            Text(
                              ksVidflix.tr,
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
                        itemCount: profileController.favoriteTvChannelList.length,
                        separatorBuilder: (context, index) =>
                            kW8sizedBox,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return FeaturedTvChannelsContentContainer(
                            image: profileController.favoriteTvChannelList[index],
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
                        return MovieContentContainer(
                          movieImage: profileController.favoriteMovieList[index].thumbnail??"",
                          // seasonName: profileController.moviesList[index]["season"],
                          isPremium: profileController.favoriteMovieList[index].isPaid==1 ? true : false,
                          // isSeason: profileController.moviesList[index]["isSeason"],
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
                      itemCount: profileController.tvSeriesList.length,
                      separatorBuilder: (context, index) =>
                          kW10sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MovieContentContainer(
                          movieImage: profileController.tvSeriesList[index]["movieImage"],
                          // seasonName: profileController.tvSeriesList[index]["season"],
                          isPremium: profileController.tvSeriesList[index]["isPremium"],
                          // isSeason: profileController.tvSeriesList[index]["isSeason"],
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

