import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class MovieViewAllScreen extends StatelessWidget {
  MovieViewAllScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Obx(
        () => Scaffold(
          backgroundColor: cBlackColor,
           appBar: PreferredSize(
            preferredSize: Size.fromHeight(kAppBarSize.h),
            child: CustomAppBar(
              hasBackButton: false,
              title: homeController.isViewAllSearchEnable.value
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            homeController.isViewAllSearchEnable.value =
                                !homeController.isViewAllSearchEnable.value;
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: kIconSize16,
                            color: cWhiteColor,
                          ),
                        ),
                        kW6sizedBox,
                        SizedBox(
                          height: 40.h,
                          width: (width - 105.w),
                          child: CustomModifiedTextField(
                            hint: ksSearchHere.tr,
                            controller:
                                homeController.viewAllTextEditingController,
                            fillColor: cBlackColor,
                            onChanged: (v) {
                              if (v == "") {
                                homeController
                                    .isViewAllSearchSuffixShow.value = false;
                              } else {
                                homeController
                                    .isViewAllSearchSuffixShow.value = true;
                              }
                            },
                            onSubmit: (v) async {
                              if (v == "") {
                                unfocus(context);
                              } else {
                                await homeController.getMovieList(movieType: homeController.selectedTitle.value);
                              }
                            },
                            textInputStyle: regular14TextStyle(cWhiteColor),
                            focusBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(k6BorderRadius),
                              borderSide: const BorderSide(
                                width: 1,
                                color: cPrimaryColor2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(k6BorderRadius),
                              borderSide: BorderSide(
                                width: 1,
                                color: cWhiteColor.withOpacity(0.3),
                                style: BorderStyle.solid,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(8),
                            suffixIcon:
                                homeController.isViewAllSearchSuffixShow.value
                                    ? Icons.close
                                    : null,
                            onSuffixPress: () {
                              homeController.isViewAllSearchSuffixShow.value =
                                  false;
                              homeController.viewAllTextEditingController
                                  .clear();
                              unFocus(context);
                            },
                          ),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: homeController.selectedTitle.value==ksNewRelease ? 140.w : homeController.selectedTitle.value==ksTrendingMovies ? 170.w : homeController.selectedTitle.value=="" ? 120.w : 190.w,
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
                               homeController.selectedTitle.value =="" ? ksAllMovies.tr : homeController.selectedTitle.value,
                                style: regular16TextStyle(cWhiteColor),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
              actions: [
                if (homeController.isViewAllSearchEnable.value == false)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                      child: InkWell(
                          onTap: () {
                            homeController.isViewAllSearchEnable.value =
                                !homeController.isViewAllSearchEnable.value;
                          },
                          child: const Icon(
                            Icons.search,
                            color: cWhiteColor,
                            size: kIconSize24,
                          )),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(right: k8Padding),
                  child: InkWell(
                    onTap: () {
                      Get.find<GlobalController>().commonBottomSheet(
                          bottomSheetColor: cBlackColor2,
                          bottomSheetHeight: height * 0.8,
                          context: context,
                          content: AllMovieBottomSheetContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
                          isScrollControlled: true,
                          onPressRightButton: () {},
                          rightText: "",
                          rightTextStyle: semiBold16TextStyle(cWhiteColor),
                          title:
                              "${ksFilter.tr} ${homeController.selectedTitle.value}",
                          isRightButtonShow: false);
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.isApplyClicked.value ? cPrimaryColor2 : cWhiteColor.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: SvgPicture.asset(
                          kiFilter,
                          color: cWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Column(
              children: [
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                if (homeController.isApplyClicked.value)
                  Row(
                    children: [
                      Text(
                        ksFiltered.tr,
                        style: medium16TextStyle(cWhiteColor),
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                          onTap: () {
                            homeController.resetBottomSheetData();
                            if(homeController.isHomeGenreClicked.value){
                              homeController.getFilterMovieList();
                            }
                            else{
                            homeController.movieList.clear();
                            homeController.movieList.addAll(homeController.temporaryMovieList);
                            }
                          },
                          child: Text(
                            ksClearAll.tr,
                            style: regular12TextStyle(
                                cWhiteColor.withOpacity(0.5)),
                          )),
                    ],
                  ),
                kH8sizedBox,
                SizedBox(
                  width: width - 20,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (homeController.selectedCategoryId.value != -1 &&
                            homeController.isApplyClicked.value)
                          Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: cPrimaryColor2,
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: k16Padding,
                                    vertical: k6Padding),
                                child: Center(
                                    child: Text(
                                  homeController.selectedCategory.value,
                                  style: regular14TextStyle(cWhiteColor),
                                )),
                              )),
                        if (homeController.selectedGenreId.value != -1 &&
                            homeController.isApplyClicked.value)
                          kW8sizedBox,
                        if (homeController.selectedGenreId.value != -1 &&
                            homeController.isApplyClicked.value)
                          Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: cPrimaryColor2,
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: k16Padding,
                                    vertical: k6Padding),
                                child: Center(
                                    child: Text(
                                  homeController.selectedGenre.value,
                                  style: regular14TextStyle(cWhiteColor),
                                )),
                              )),
                        if (homeController.selectedCountryId.value != -1 &&
                            homeController.isApplyClicked.value)
                          kW8sizedBox,
                        if (homeController.selectedCountryId.value != -1 &&
                            homeController.isApplyClicked.value)
                          Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: cPrimaryColor2,
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: k16Padding,
                                    vertical: k6Padding),
                                child: Center(
                                    child: Text(
                                  homeController.selectedCountry.value,
                                  style: regular14TextStyle(cWhiteColor),
                                )),
                              )),
                        if (homeController.selectedLanguageId.value != -1 &&
                            homeController.isApplyClicked.value)
                          kW8sizedBox,
                        if (homeController.selectedLanguageId.value != -1 &&
                            homeController.isApplyClicked.value)
                          Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: cPrimaryColor2,
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: k16Padding,
                                    vertical: k6Padding),
                                child: Center(
                                    child: Text(
                                  homeController.selectedLanguage.value,
                                  style: regular14TextStyle(cWhiteColor),
                                )),
                              )),
                        if (homeController.selectedYear.value != "" &&
                            homeController.isApplyClicked.value)
                          kW8sizedBox,
                        if (homeController.selectedYear.value != "" &&
                            homeController.isApplyClicked.value)
                          Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: cPrimaryColor2,
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: k16Padding,
                                    vertical: k6Padding),
                                child: Center(
                                    child: Text(
                                  homeController.selectedYear.value,
                                  style: regular14TextStyle(cWhiteColor),
                                )),
                              )),
                        if (homeController.selectedSort.value != "" &&
                            homeController.isApplyClicked.value)
                          kW8sizedBox,
                        if (homeController.selectedSort.value != "" &&
                            homeController.isApplyClicked.value)
                          Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: cPrimaryColor2,
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: k16Padding,
                                    vertical: k6Padding),
                                child: Center(
                                    child: Text(
                                  homeController.selectedSort.value,
                                  style: regular14TextStyle(cWhiteColor),
                                )),
                              )),
                      ],
                    ),
                  ),
                ),
                kH16sizedBox,
                homeController.movieList.isEmpty
                    ? SizedBox(
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
                      )
                    :  homeController.isMovieListLoading.value
                          ? const CircularProgressIndicator()
                          : NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (homeController.movieListScrollController
                                            .position.userScrollDirection ==
                                        ScrollDirection.reverse &&
                                    scrollNotification.metrics.pixels ==
                                        scrollNotification
                                            .metrics.maxScrollExtent &&
                                    !homeController.movieListScrolled.value) {
                                  homeController.movieListScrolled.value =
                                      true;
                                  if (homeController.movieList.isNotEmpty) {
                                    homeController.getMoreMovieList(homeController.selectedTitle.value==ksNewRelease ? "newRelease" : homeController.selectedTitle.value== ksTrendingMovies ? "trending" : "recommended");
                                  }
                                  return true;
                                }
                                return false;
                              },
                      child: Expanded(
                        child: SingleChildScrollView(
                          controller: homeController.movieListScrollController,
                          child: Column(
                            children: [
                              GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.6,
                                  ),
                                  itemCount: homeController.movieList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        await homeController.getMovieDetails(
                                            movieId: homeController
                                                .movieList[index]!.id!
                                                .toString());
                                        String videoUrl = homeController
                                                .movieServerList[0]?.fileUrl ??
                                            "";
                                        Get.find<AllVideoPlayerController>()
                                            .flickManager = FlickManager(
                                          videoPlayerController:
                                              VideoPlayerController.network(videoUrl),
                                        );
                                        Get.toNamed(krVideoPlayerScreen);
                                      },
                                      child: MovieContentContainer(
                                        movieImage: homeController
                                                .movieList[index]?.thumbnail ??
                                            "",
                                        isPremium:
                                            homeController.movieList[index]?.isPaid == 1
                                                ? true
                                                : false,
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
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

class AllMovieBottomSheetContent extends StatelessWidget {
  AllMovieBottomSheetContent({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH8sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Text(
            ksCategories.tr,
            style: medium16TextStyle(cWhiteColor),
          ),
        ),
        kH16sizedBox,
        Padding(
          padding: const EdgeInsets.only(left: k20Padding),
          child: Row(
            children: [
              SizedBox(
                width: width - 20.w,
                height: 34.h,
                child: ListView.separated(
                  itemCount: homeController.movieCategoryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedCategoryId.value =
                                homeController.movieCategoryList[index]?.id ??
                                    -1;
                            homeController.selectedCategory.value =
                                homeController
                                        .movieCategoryList[index]?.videoType ??
                                    "";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedCategoryId.value ==
                                      homeController
                                          .movieCategoryList[index]!.id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.movieCategoryList[index]
                                          ?.videoType ??
                                      "",
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Text(
            ksCountry.tr,
            style: medium16TextStyle(cWhiteColor),
          ),
        ),
        kH16sizedBox,
        Padding(
          padding: const EdgeInsets.only(left: k20Padding),
          child: Row(
            children: [
              SizedBox(
                width: width - 20.w,
                height: 34.h,
                child: ListView.separated(
                  itemCount: homeController.movieCountryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedCountryId.value =
                                homeController.movieCountryList[index]?.id ??
                                    -1;
                            homeController.selectedCountry.value =
                                homeController.movieCountryList[index]?.name ??
                                    "";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedCountryId.value ==
                                      homeController.movieCountryList[index]!.id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController
                                          .movieCountryList[index]?.name ??
                                      "",
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Text(
            ksGenre.tr,
            style: medium16TextStyle(cWhiteColor),
          ),
        ),
        kH16sizedBox,
        Padding(
          padding: const EdgeInsets.only(left: k20Padding),
          child: Row(
            children: [
              SizedBox(
                width: width - 20.w,
                height: 34.h,
                child: ListView.separated(
                  itemCount: homeController.movieGenreList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedGenreId.value =
                                homeController.movieGenreList[index]?.id ?? -1;
                            homeController.selectedGenre.value =
                                homeController.movieGenreList[index]?.name ??
                                    "";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedGenreId.value ==
                                      homeController.movieGenreList[index]!.id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.movieGenreList[index]?.name ??
                                      "",
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Text(
            ksLanguage.tr,
            style: medium16TextStyle(cWhiteColor),
          ),
        ),
        kH16sizedBox,
        Padding(
          padding: const EdgeInsets.only(left: k20Padding),
          child: Row(
            children: [
              SizedBox(
                width: width - 20.w,
                height: 34.h,
                child: ListView.separated(
                  itemCount: homeController.movieLanguageList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedLanguageId.value =
                                homeController.movieLanguageList[index]?.id ??
                                    -1;
                            homeController.selectedLanguage.value =
                                homeController.movieLanguageList[index]?.name ??
                                    "";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedLanguageId.value ==
                                      homeController
                                          .movieLanguageList[index]!.id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController
                                          .movieLanguageList[index]?.name ??
                                      "",
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Text(
            ksYear.tr,
            style: medium16TextStyle(cWhiteColor),
          ),
        ),
        kH16sizedBox,
        Padding(
          padding: const EdgeInsets.only(left: k20Padding),
          child: Row(
            children: [
              SizedBox(
                width: width - 20.w,
                height: 34.h,
                child: ListView.separated(
                  itemCount: homeController.movieYearList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedYear.value =
                                homeController.movieYearList[index].toString();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedYear.value ==
                                      homeController.movieYearList[index]
                                          .toString()
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.movieYearList[index]
                                      .toString(),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Text(
            ksSort.tr,
            style: medium16TextStyle(cWhiteColor),
          ),
        ),
        kH16sizedBox,
        Padding(
          padding: const EdgeInsets.only(left: k20Padding),
          child: Row(
            children: [
              SizedBox(
                width: width - 20.w,
                height: 34.h,
                child: ListView.separated(
                  itemCount: homeController.movieSortList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedSortId.value =
                                index+1;
                            homeController.selectedSort.value =
                                 homeController.movieSortList[index]
                                      .toString().capitalizeFirst??"";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedSortId.value ==
                                      index+1
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.movieSortList[index]
                                      .toString().capitalizeFirst??"",
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
        kH8sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Divider(
            thickness: 1,
            color: cWhiteColor.withOpacity(0.1),
          ),
        ),
        kH8sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Row(
            children: [
              CustomElevatedButton(
                label: ksReset.tr,
                onPressed: () {
                  homeController.resetBottomSheetData();
                     homeController.movieList.clear();
                              homeController.movieList
                                  .addAll(homeController.temporaryMovieList);
                },
                buttonColor: cWhiteColor.withOpacity(0.2),
                textStyle: regular16TextStyle(cWhiteColor),
                buttonWidth: (width - 56) / 2,
              ),
              kW16sizedBox,
              CustomElevatedButton(
                label: ksApply.tr,
                onPressed: () async {
                  homeController.isApplyClicked.value = true;
                  Get.back();
                  await homeController.getFilterMovieList();
                },
                buttonColor: cPrimaryColor2,
                textStyle: regular16TextStyle(cWhiteColor),
                buttonWidth: (width - 56) / 2,
              ),
            ],
          ),
        ),
        kH50sizedBox,
      ],
    );
  }
}
