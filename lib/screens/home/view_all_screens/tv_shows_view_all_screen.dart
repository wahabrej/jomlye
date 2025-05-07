import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class TvShowsViewAllScreen extends StatelessWidget {
 TvShowsViewAllScreen({super.key});
 final HomeController homeController = Get.find<HomeController>();
 final GlobalController globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        //* info:: appBar
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSize.h),
        child: CustomAppBar(
          hasBackButton: false,
          title: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 110.w,
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
                      ksTvShows.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                  ],
                ),
              ),
            ),
          ),
          actions: [
                      Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                      child: const Icon(Icons.search,color: cWhiteColor,size: kIconSize24,),
                    ),
                    kW6sizedBox,
                    Padding(
                      padding: const EdgeInsets.only(right: k8Padding),
                      child: InkWell(
                        onTap: (){
                          globalController.commonBottomSheet(bottomSheetColor: cBlackColor2,bottomSheetHeight: height*0.8,isScrollControlled: true,context: context, content: AllTvShowsBottomSheetContent(), onPressCloseButton: (){Get.back();}, onPressRightButton: (){}, rightText: "", rightTextStyle: semiBold16TextStyle(cWhiteColor), title: "${ksFilter.tr} ${homeController.selectedTitle.value}", isRightButtonShow: false);
                        },
                        child: Container(
                           width: 40.w,
                          height: 40.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: cPrimaryColor2,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(k12Padding),
                            child: SvgPicture.asset(kiFilter,color: cWhiteColor,),
                          ),
                        ),
                      ),
                    ),
          ],
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Column(
              children: [
                kH8sizedBox,
                 Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH16sizedBox,
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: homeController.tvShowList.length,
                    itemBuilder: (context, index) {
                           return InkWell(
                            onTap: ()async{
                              await homeController.getTvShowDetails(showId: homeController.tvShowList[index]!.id!);
                              Get.toNamed(krTvShowPlayerScreen);
                            },
                             child: MovieContentContainer(
                              movieImage: homeController.tvShowList[index]?.thumbnail??"",
                              isPremium: homeController.tvShowList[index]?.isPaid==1 ? true : false,
                             ),
                           );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class AllTvShowsBottomSheetContent extends StatelessWidget {
  AllTvShowsBottomSheetContent({super.key});
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
                  itemCount: homeController.tvShowsCategoryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedMovieCategoryId.value =
                                homeController.tvShowsCategoryList[index]?.id??-1;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController
                                          .selectedMovieCategoryId.value ==
                                      homeController
                                          .tvShowsCategoryList[index]!.id
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
                                          .tvShowsCategoryList[index]?.videoType ??
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
                  itemCount: homeController.tvShowCountryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedMovieCountryId.value =
                                homeController.tvShowCountryList[index]?.id??-1;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedMovieCountryId.value ==
                                      homeController.tvShowCountryList[index]!.id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.tvShowCountryList[index]?.name??"",
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
                  itemCount: homeController.tvShowGenreList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedMovieGenreId.value =
                                homeController.tvShowGenreList[index]?.id??-1;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedMovieGenreId.value ==
                                      homeController.tvShowGenreList[index]!.id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.tvShowGenreList[index]?.name??"",
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
                  itemCount: homeController.tvShowLanguageList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedMovieLanguageId.value =
                                homeController.tvShowLanguageList[index]?.id??-1;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedMovieLanguageId.value ==
                                      homeController.tvShowLanguageList[index]!.id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.tvShowLanguageList[index]?.name??"",
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
                  itemCount: homeController.tvShowYearList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedMovieYear.value =
                                homeController.tvShowYearList[index].toString();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedMovieYear.value ==
                                      homeController.tvShowYearList[index]
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
                                  homeController.tvShowYearList[index].toString(),
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
                  itemCount: homeController.movieSort.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            // homeController.selectedMovieSortId.value =
                            //     homeController.movieSort[index];
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedMovieYear.value ==
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
                                  homeController.movieYearList[index].toString(),
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
                  homeController.blogFilterValueReset();
                },
                buttonColor: cWhiteColor.withOpacity(0.2),
                textStyle: regular16TextStyle(cWhiteColor),
                buttonWidth: (width - 56) / 2,
              ),
              kW16sizedBox,
              CustomElevatedButton(
                label: ksApply.tr,
                onPressed: () async {
                  await homeController.getFilterMovieList();
                },
                buttonColor: cPrimaryColor2,
                textStyle: regular16TextStyle(cWhiteColor),
                buttonWidth: (width - 56) / 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
