import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/widget/bottom_sheet_content/search_bottom_sheet_content.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        child: Obx(
          () => Column(
            children: [
              kH60sizedBox,
              SizedBox(
                width: width - 40,
                height: 50,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: cWhiteColor,
                          size: kIconSize20,
                        )),
                    SizedBox(
                      // height: kTextFieldHeight.h,
                      width: (width - 110.w),
                      child: CustomModifiedTextField(
                        hint: ksSearch.tr,
                        controller:
                            homeController.globalSearchTextEditingController,
                        fillColor: cBlackColor,
                        textInputStyle: regular14TextStyle(cWhiteColor),
                        focusBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k6BorderRadius),
                          borderSide: const BorderSide(
                            width: 1,
                            color: cPrimaryColor2,
                          ),
                        ),
                        prefixIcon: Icons.search,
                        suffixIcon: homeController.isSearchSuffixIconShow.value
                            ? Icons.close
                            : null,
                        suffixIconSize: kIconSize24,
                        suffixIconColor: cWhiteColor,
                        onSuffixPress: () {
                          homeController.globalSearchTextEditingController
                              .clear();
                          homeController.isSearchSuffixIconShow.value = false;
                        },
                        onChanged: (value) {
                          if (homeController
                                  .globalSearchTextEditingController.text !=
                              "") {
                            homeController.isSearchSuffixIconShow.value = true;
                          } else {
                            homeController.isSearchSuffixIconShow.value = false;
                          }
                        },
                        onSubmit: (v) async {
                          homeController.globalSearchTextEditingController
                              .text = v.toString().trim();
                          await homeController.getGlobalSearch();
                        },
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k6BorderRadius),
                          borderSide: BorderSide(
                            width: 1,
                            color: cWhiteColor.withOpacity(0.3),
                            style: BorderStyle.solid,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        Get.find<GlobalController>().commonBottomSheet(
                            context: context,
                            bottomSheetHeight: height * 0.8,
                            isScrollControlled: true,
                            content: AllSearchBottomSheetContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {},
                            rightText: "",
                            rightTextStyle: semiBold14TextStyle(cWhiteColor),
                            title: ksFilterBlogs.tr,
                            isRightButtonShow: false,
                            bottomSheetColor: cBlackColor);
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
                          child: SvgPicture.asset(
                            kiFilter,
                            color: cWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kH8sizedBox,
              // Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(ksSearchResults.tr,style: medium16TextStyle(cWhiteColor),),
              //         Text("Shown 0 results",style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),),
              //       ],
              //     ),
              //   ],
              // ),
              // Container(
              //   child: SvgPicture.asset(kiSearchResult,width: 200.w,height: 200.h,color: cWhiteColor,)),
              // SizedBox(
              //   height: (height*0.75),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(kiSearchResultPng,width: 200.w,height: 200.h,),
              //       Text(ksNoVideoFound.tr,style: medium16TextStyle(cPrimaryColor2),),
              //       kH16sizedBox,
              //       Text(ksNoVideosFoundPleaseCheckFilter.tr,style: regular14TextStyle(cWhiteColor.withOpacity(0.5,)),textAlign: TextAlign.center,),
              //     ],
              //   )),
              if (homeController.searchList.isNotEmpty)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ksSearchResults.tr,
                          style: medium16TextStyle(cWhiteColor),
                        ),
                        Text(
                          "Shown ${homeController.globalSearchModel.value?.searchedData?.total != null ? homeController.globalSearchModel.value!.searchedData!.total.toString() : ""} results",
                          style:
                              regular14TextStyle(cWhiteColor.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ],
                ),
              kH8sizedBox,
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
                          homeController.movieList.clear();
                          homeController.movieList
                              .addAll(homeController.temporaryMovieList);
                        },
                        child: Text(
                          ksClearAll.tr,
                          style:
                              regular12TextStyle(cWhiteColor.withOpacity(0.5)),
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
                                  horizontal: k16Padding, vertical: k6Padding),
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
                                  horizontal: k16Padding, vertical: k6Padding),
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
                                  horizontal: k16Padding, vertical: k6Padding),
                              child: Center(
                                  child: Text(
                                homeController.selectedCountry.value,
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
                                  horizontal: k16Padding, vertical: k6Padding),
                              child: Center(
                                  child: Text(
                                homeController.selectedYear.value,
                                style: regular14TextStyle(cWhiteColor),
                              )),
                            )),
                    ],
                  ),
                ),
              ),
              kH10sizedBox,
              homeController.searchList.isEmpty
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
                            style: regular14TextStyle(cWhiteColor.withOpacity(
                              0.5,
                            )),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  :   homeController.isGlobalSearchLoading.value ? const CircularProgressIndicator() : NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (homeController.globalSearchScrollController.position.userScrollDirection == ScrollDirection.reverse &&
                        scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent &&
                        !homeController.globalSearchListScrolled.value) {
                      homeController.globalSearchListScrolled.value = true;
                      if (homeController.searchList.isNotEmpty) {
                        homeController.getMoreGlobalSearch(null);
                      }
                      // if (homeController.searchList.isNotEmpty && homeController.isFriendSearched.value) {
                      //   friendController.getMoreFriendSearchList(null);
                      // }
                      return true;
                    }
                    return false;
                  },
                    child: Expanded(
                        child: SingleChildScrollView(
                          controller: homeController.globalSearchScrollController,
                          child: Column(
                            children: [
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: homeController.searchList.length,
                                separatorBuilder: (context, index) => Column(
                                  children: [
                                    kH4sizedBox,
                                    Divider(
                                      thickness: 1,
                                      color: cWhiteColor.withOpacity(0.2),
                                    ),
                                  ],
                                ),
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  k4BorderRadius),
                                              child: Image.network(
                                                homeController.searchList[index]
                                                        ?.thumbnail ??
                                                    "",
                                                width: 70.w,
                                                height: 105.h,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Center(
                                                  child: SvgPicture.asset(
                                                    kiDummyMovie,
                                                    height: 90.h,
                                                    width: 80.w,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              )),
                                          kW14sizedBox,
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: cWhiteColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      border: Border.all(
                                                        width: 1.33,
                                                        color: cPrimaryColor2
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "Action",
                                                      style: semiBold14TextStyle(
                                                          cWhiteColor),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: cWhiteColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      border: Border.all(
                                                        width: 1.33,
                                                        color: cPrimaryColor2
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "War",
                                                      style: semiBold14TextStyle(
                                                          cWhiteColor),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: k8Padding,
                                                        vertical: k4Padding),
                                                    decoration: BoxDecoration(
                                                      color: cWhiteColor
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      border: Border.all(
                                                        width: 1.33,
                                                        color: cPrimaryColor2
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "Trending",
                                                      style: semiBold14TextStyle(
                                                          cWhiteColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              kH8sizedBox,
                                              SizedBox(
                                                width: width * 0.5,
                                                child: Text(
                                                  homeController.searchList[index]
                                                          ?.title ??
                                                      "",
                                                  style: medium16TextStyle(
                                                      cWhiteColor),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              kH8sizedBox,
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star_rounded,
                                                    size: kIconSize14,
                                                    color: cAmberColor,
                                                  ),
                                                  kW4sizedBox,
                                                  Text(
                                                    homeController
                                                            .searchList[index]
                                                            ?.imdbRating ??
                                                        "",
                                                    style: regular10TextStyle(
                                                        cWhiteColor),
                                                  ),
                                                  kW4sizedBox,
                                                  const Icon(
                                                    Icons.access_time_filled,
                                                    size: kIconSize14,
                                                    color: cPrimaryColor2,
                                                  ),
                                                  kW4sizedBox,
                                                  Text(
                                                    homeController
                                                            .searchList[index]
                                                            ?.runtime ??
                                                        "",
                                                    style: regular10TextStyle(
                                                        cWhiteColor),
                                                  ),
                                                  kW4sizedBox,
                                                  const Icon(
                                                    Icons.calendar_month_rounded,
                                                    size: kIconSize14,
                                                    color: cPrimaryColor2,
                                                  ),
                                                  kW4sizedBox,
                                                  Text(
                                                  homeController.searchList[index]?.release == null ? "" : DateFormat('d MMM, yyyy')
                                                        .format(DateTime.parse(
                                                        homeController.searchList[index]!.release.toString())),
                                                    style: regular10TextStyle(
                                                        cWhiteColor),
                                                  ),
                                                ],
                                              ),
                                              kH8sizedBox,
                                              if (homeController.searchList[index]
                                                      ?.isPaid ==
                                                  1)
                                                CustomElevatedButton(
                                                  label: ksPremium.tr,
                                                  onPressed: () {},
                                                  buttonWidth: 60.w,
                                                  buttonHeight: h24.h,
                                                  buttonColor: cPrimaryColor2,
                                                ),
                                            ],
                                          ),
                                          const Expanded(child: SizedBox()),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 36.w,
                                                height: h36.h,
                                                decoration: BoxDecoration(
                                                  color: cWhiteColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          k8BorderRadius),
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: kIconSize24,
                                                  color: cPrimaryColor2,
                                                ),
                                              ),
                                            ],
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
                      ),
                  ),
              kH50sizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
