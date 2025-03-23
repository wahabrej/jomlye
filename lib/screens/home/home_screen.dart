import 'package:carousel_slider/carousel_slider.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/widgets/common/common_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeSlider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                  child: Text(
                    ksExploreByGenre,
                    style: medium16TextStyle(cWhiteColor),
                  ),
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
                          separatorBuilder: (context, index) =>
                              kW8sizedBox,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Obx(() => GestureDetector(
                                  onTap: () {
                                    homeController.selectedGenre.value =
                                        homeController.genreList[index];
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: homeController.selectedGenre.value ==
                                              homeController.genreList[index]
                                          ? cPrimaryColor2
                                          : cWhiteColor.withOpacity(0.1),
                                      // border: Border.all(width: 0.5.w, color: cGreyBoxColor),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 6.h),
                                      child: Center(
                                        child: Text(
                                          homeController.genreList[index],
                                          style: regular14TextStyle(cWhiteColor),
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
                  subtitleText: ksViewAll,
                  onPressed: (){
                    homeController.selectedTitle.value = ksNewRelease;
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
                    height: 175.h,
                    child: ListView.separated(
                      itemCount: homeController.recentMovieList.length,
                      separatorBuilder: (context, index) =>
                          kW8sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MovieContentContainer(
                          movieImage: homeController.recentMovieList[index]["movieImage"],
                          seasonName: homeController.recentMovieList[index]["season"],
                          isPremium: homeController.recentMovieList[index]["isPremium"],
                          isSeason: homeController.recentMovieList[index]["isSeason"],
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
                  subtitleText: ksViewAll,
                          onPressed: (){
                    homeController.selectedTitle.value = ksTrendingMovies;
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
                    height: 175.h,
                    child: ListView.separated(
                      itemCount: homeController.trendingMoviesList.length,
                      separatorBuilder: (context, index) =>
                          kW8sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MovieContentContainer(
                          movieImage: homeController.trendingMoviesList[index]["movieImage"],
                          seasonName: homeController.trendingMoviesList[index]["season"],
                          isPremium: homeController.trendingMoviesList[index]["isPremium"],
                          isSeason: homeController.trendingMoviesList[index]["isSeason"],
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
                  subtitleText: ksViewAll,
                    onPressed: (){
                    homeController.selectedTitle.value = ksPopularTvShows;
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
                    height: 175.h,
                    child: ListView.separated(
                      itemCount: homeController.trendingMoviesList.length,
                      separatorBuilder: (context, index) =>
                          kW8sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MovieContentContainer(
                          movieImage: homeController.trendingMoviesList[index]["movieImage"],
                          seasonName: homeController.trendingMoviesList[index]["season"],
                          isPremium: homeController.trendingMoviesList[index]["isPremium"],
                          isSeason: homeController.trendingMoviesList[index]["isSeason"],
                        );
                      },
                    ),
                  ),
                ],
                ),
                ),
                kH20sizedBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(k6BorderRadius),
                        child: Image.network("https://i.ytimg.com/vi/Le_aY-4FJ7E/maxresdefault.jpg",width: width-40,height: 210.h,fit: BoxFit.cover,)),
                        Positioned(
                          top: 60,
                          right: width*0.15,
                          child: Column(
                            children: [
                              Container(
                                width: width*0.6,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: cWhiteColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 6.w,vertical: 3.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                     Row(
                                      children: [
                                        const Icon(Icons.star,color: cPrimaryColor2,size: kIconSize20,),
                                      kW6sizedBox,
                                      Text("4.6",style: regular12TextStyle(cWhiteColor),),
                                      kW6sizedBox,
                                      VerticalDivider(
                                        width: 1,
                                        thickness: 1,
                                        color: cWhiteColor.withOpacity(0.5),
                                      ),
                                      ],
                                     ),
                                           Row(
                                      children: [
                                        const Icon(Icons.access_time_filled_sharp,color: cPrimaryColor2,size: kIconSize20,),
                                      kW6sizedBox,
                                      Text("2 hr 30 mins",style: regular12TextStyle(cWhiteColor),),
                                      kW6sizedBox,
                                      VerticalDivider(
                                        width: 1,
                                        thickness: 1,
                                        color: cWhiteColor.withOpacity(0.5),
                                      ),
                                      ],
                                     ),
                                           Row(
                                      children: [
                                         const Icon(Icons.calendar_today_outlined,color: cPrimaryColor2,size: kIconSize20,),
                                      kW6sizedBox,
                                      Text("2024",style: regular12TextStyle(cWhiteColor),),
                                      ],
                                     ),
                                    ],
                                  ),
                                ),
                              ),
                              Text("3 idiots",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w700,color: cWhiteColor),),
                              Container(
                                width: 46.w,
                                height: 46.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: cPrimaryColor2,
                                ),
                                child: const Icon(Icons.play_arrow,size: kIconSize28,color: cWhiteColor,),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                kH16sizedBox,
                               Padding(
                                  padding: const EdgeInsets.only(left: k20Padding),
                                  child: Row(
                children: [
                  SizedBox(
                    width: width - 20,
                    height: 140.h,
                    child: ListView.separated(
                      itemCount: homeController.recentPlayedMovies.length,
                      separatorBuilder: (context, index) =>
                          kW10sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MovieCard(
                          imageUrl: homeController.recentPlayedMovies[index]["imageUrl"],
                          title: homeController.recentPlayedMovies[index]["title"],
                          duration: homeController.recentPlayedMovies[index]["duration"],
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
                  subtitleText: ksViewAll,
                  onPressed: (){
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
                      itemCount: homeController.tvSeriesList.length,
                      separatorBuilder: (context, index) =>
                          kW8sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FeaturedTvChannelsContentContainer(
                          image: homeController.featuredTvChannelsList[index],
                        );
                      },
                    ),
                  ),
                ],
                ),
                ),
                kH16sizedBox,
                                     HomeTitleContent(
                  title: ksTvSeries.tr,
                  subtitleText: ksViewAll,
                ),
                kH16sizedBox,
                 Padding(
                                  padding: const EdgeInsets.only(left: k20Padding),
                                  child: Row(
                children: [
                  SizedBox(
                    width: width - 20,
                    height: 175.h,
                    child: ListView.separated(
                      itemCount: homeController.tvSeriesList.length,
                      separatorBuilder: (context, index) =>
                          kW10sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MovieContentContainer(
                          movieImage: homeController.tvSeriesList[index]["movieImage"],
                          seasonName: homeController.tvSeriesList[index]["season"],
                          isPremium: homeController.tvSeriesList[index]["isPremium"],
                          isSeason: homeController.tvSeriesList[index]["isSeason"],
                        );
                      },
                    ),
                  ),
                ],
                ),
                ),
                kH16sizedBox,
                          HomeTitleContent(
                  title: ksTopArtists.tr,
                  subtitleText: ksViewAll,
                  onPressed: (){
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
                      itemCount: homeController.topArtistList.length,
                      separatorBuilder: (context, index) =>
                          kW10sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TopArtistContent(
                        image: homeController.topArtistList[index]["image"],
                        name: homeController.topArtistList[index]["name"],
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
                  subtitleText: ksViewAll,
                  onPressed: (){
                    Get.toNamed(krAllBlogsViewAllScreen);
                  },
                ),
                kH16sizedBox,
                 Padding(
                                  padding: const EdgeInsets.only(left: k20Padding),
                                  child: Row(
                children: [
                  SizedBox(
                    width: width - 20,
                    height: 210.h,
                    child: ListView.separated(
                      itemCount: homeController.latestBlogList.length,
                      separatorBuilder: (context, index) =>
                          kW10sizedBox,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.toNamed(krBlogSingleScreen);
                          },
                          child: LatestBlogPostContent(
                            image: homeController.latestBlogList[index]["image"],
                            title: homeController.latestBlogList[index]["title"],
                            subTitle: homeController.latestBlogList[index]["subtitle"],
                            date: homeController.latestBlogList[index]["date"],
                            reporter: homeController.latestBlogList[index]["reporter"],
                          ),
                        );
                      },
                    ),
                  ),
                ],
                ),
                ),
              ],
            ),
          ),
        ),
          bottomNavigationBar: CustomBottomNavBar(
            width: width,
            selectedIndex: 0,
            // isFirstButtonClicked: true,
            // isSecondButtonClicked: false,
            // isThirdButtonClicked: false,
            // isFourthButtonClicked: false,
            // isFifthButtonClicked: false,
          ),
      ),
    );
  }
}

class LatestBlogPostContent extends StatelessWidget {
  const LatestBlogPostContent({super.key, required this.image, required this.title, required this.subTitle, required this.date, required this.reporter, this.contentHeight});
  final String image,title,subTitle,date,reporter;
  final double? contentHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(k6BorderRadius),
      child: Stack(
        children: [
          Image.network(image,height: contentHeight ?? 210.h,width: (width-30)/2,fit: BoxFit.cover,),
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
                padding: const EdgeInsets.symmetric(horizontal: k4Padding,vertical: k2Padding),
                child: Text("News",style: regular10TextStyle(cWhiteColor),),
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
                      child: Text(title,style: semiBold10TextStyle(cWhiteColor),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                      kH4sizedBox,
                    SizedBox(
                      child: Text(subTitle,style: regular8TextStyle(cWhiteColor.withOpacity(0.5)),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                       kH4sizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         const Icon(Icons.calendar_month_rounded,size: kIconSize16,color: cWhiteColor,),
                          kW4sizedBox,
                          Text(date,style: regular8TextStyle(cWhiteColor),),
                          kW8sizedBox,
                          const Icon(Icons.person_pin_rounded,size: kIconSize16,color: cWhiteColor,),
                          kW4sizedBox,
                          Text(reporter,style: regular8TextStyle(cWhiteColor),),
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
    );
  }
}


class MovieCard extends StatelessWidget {

  const MovieCard({super.key, required this.imageUrl, required this.title, required this.duration,});
  final String imageUrl,title,duration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(k6BorderRadius),
          child: Image.network(
            imageUrl,
            width: 100.w,
            height: 140.h,
            fit: BoxFit.cover,
          ),
        ),
        Container(
           width: 100.w,
            height: 140.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
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
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: semiBold12TextStyle(cWhiteColor),
              ),
              kH4sizedBox,
              Text(
                duration,
                style: regular10TextStyle(cWhiteColor)
              ),
              kH4sizedBox,
              Container(
                height: 3,
                width: 100,
                decoration: BoxDecoration(
                  color: cPrimaryColor2,
                  borderRadius: BorderRadius.circular(4),
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
  const TopArtistContent({super.key, required this.image, required this.name, this.contentWidth, this.contentHeight});
  final String image,name;
  final double? contentWidth,contentHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(k4BorderRadius),
          child: Image.network(image,width: contentWidth ?? 88.w,height: contentHeight ?? 88.h,fit: BoxFit.cover,)),
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
            child: Center(child: Text(name,style: semiBold10TextStyle(cWhiteColor),)),
          ),
        ),
      ],
    );
  }
}

class FeaturedTvChannelsContentContainer extends StatelessWidget {
  const FeaturedTvChannelsContentContainer({super.key, required this.image, this.containerWidth, this.containerHeight});
  final String image;
  final double? containerWidth,containerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth?? 120.w,
      height: containerHeight?? 120.h,
      decoration: BoxDecoration(
        color: cWhiteColor,
        borderRadius: BorderRadius.circular(k6BorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(k20Padding),
        child: Image.network(image,),
      ),
    );
  }
}

class HomeTitleContent extends StatelessWidget {
  const HomeTitleContent(
      {super.key,
      required this.title,
      required this.subtitleText,
      this.onPressed,this.isHorizontalPadding=true});
  final String title, subtitleText;
  final VoidCallback? onPressed;
  final bool? isHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isHorizontalPadding! ? const EdgeInsets.symmetric(horizontal: k20Padding):const EdgeInsets.symmetric(horizontal: k0Padding),
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
  const MovieContentContainer({super.key, this.movieImage, this.seasonName, this.isPremium, this.isSeason});
  final String? movieImage,seasonName;
  final bool? isPremium,isSeason;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: (width - 70) / 3,
          height: 175.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(k6BorderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(k6BorderRadius),
            child: Image.network(
              movieImage??"",
              width: (width - 60) / 3,
              height: 175.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if(isPremium==true)
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
              padding: const EdgeInsets.symmetric(horizontal: k4Padding,vertical: 1),
              child: Center(child: Text(isPremium! ? "Premium":"",style: regular10TextStyle(cWhiteColor),)),
            ),
          )
        ),
        if(isSeason==true)
         Positioned(
          top: 4,
          left: 4,
          child: Container(
            height: 16.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(k6BorderRadius),
              color: cBlackColor.withOpacity(0.4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: k4Padding,vertical: 1),
              child: Center(child: Text(seasonName??"",style: regular10TextStyle(cWhiteColor),)),
            ),
          )
        ),
      ],
    );
  }
}

class HomeSlider extends StatelessWidget {
  HomeSlider({super.key});
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height * 0.5,
            autoPlay: true,
            enlargeCenterPage: true,
            // viewportFraction: 0.9,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              controller.updateCurrentIndex(index);
            },
          ),
          items: controller.sliderImages.map((image) {
            return Stack(
              children: [
                SizedBox(
                  width: width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(k8BorderRadius.r),
                    child: Image.network(
                      image['url'],
                      fit: BoxFit.cover,
                      width: width,
                      height: height * 0.5,
                    ),
                  ),
                ),
                  Positioned(
                  top: 30,
                  left: 15,
                  child: Row(
                    children: [
                      SvgPicture.asset(kiVidflix,width: 28.w,height: 28.w,),
                      kW6sizedBox,
                      Text(ksVidflix.tr,style: semiBold18TextStyle(cWhiteColor),),
                    ],
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 15,
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(krSearchScreen);
                    },
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                      child: const Icon(Icons.search,color: cWhiteColor,size: kIconSize24,),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.sliderImages.length,
                              (index) => Container(
                                width: controller.currentIndex.value == index
                                    ? 24
                                    : 8,
                                height: controller.currentIndex.value == index
                                    ? 6
                                    : 8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: controller.currentIndex.value ==
                                        index
                                    ? BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        color: controller.currentIndex.value ==
                                                index
                                            ? cPrimaryColor2
                                            : cLineColor,
                                      )
                                    : BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.currentIndex.value ==
                                                index
                                            ? cPrimaryColor2
                                            : cLineColor,
                                      ),
                              ),
                            ),
                          )),
                      kH10sizedBox,
                    ],
                  ),
                ),
                Positioned(
                  bottom: 75,
                  left: width * 0.3,
                  child: Row(
                    children: image['tags'].map<Widget>((tag) {
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: cWhiteColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            width: 1.33,
                            color: cPrimaryColor2.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          tag,
                          style: semiBold14TextStyle(cWhiteColor),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                kH10sizedBox,
                Positioned(
                  bottom: 45,
                  left: width * 0.35,
                  child: Text(
                    image['title'],
                    style: semiBold24TextStyle(cWhiteColor),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  left: width * 0.5,
                  child:    Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: cPrimaryColor2,
                                ),
                                child: const Icon(Icons.play_arrow,size: kIconSize28,color: cWhiteColor,),
                              ),
                ),
              ],
            );
          }).toList(),
        ),
        kH10sizedBox,
      ],
    );
  }
}
