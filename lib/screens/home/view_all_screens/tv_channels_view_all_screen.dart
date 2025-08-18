import 'package:flutter/rendering.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/screens/video_player/live_tv_player_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/widgets/common/common_bottom_nav_bar.dart';

class TvChannelsViewAllScreen extends StatelessWidget {
  TvChannelsViewAllScreen({super.key});
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
                                homeController.isViewAllSearchSuffixShow.value =
                                    false;
                              } else {
                                homeController.isViewAllSearchSuffixShow.value =
                                    true;
                              }
                            },
                            onSubmit: (v) async {
                              if (v == "") {
                                unfocus(context);
                              } else {
                                await homeController.getTvChannel();
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
                        width: 150.w,
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
                                ksAllTVChannel.tr,
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
                          bottomSheetHeight: height * 0.48,
                          context: context,
                          content: TvChannelsBottomSheetContent(),
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.isApplyClicked.value
                            ? cPrimaryColor2
                            : cWhiteColor.withOpacity(0.2),
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
                kH8sizedBox,
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH8sizedBox,
                if (homeController.isApplyClicked.value ||
                    homeController.viewAllTextEditingController.text
                            .trim()
                            .toString() !=
                        "")
                  Row(
                    children: [
                      Text(
                        ksFiltered.tr,
                        style: medium16TextStyle(cWhiteColor),
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                          onTap: () async {
                            homeController.resetBottomSheetData();
                            homeController.viewAllTextEditingController
                                .clear();
                            homeController.isViewAllSearchSuffixShow.value =
                                false;
                            await homeController.getTvChannel();
                          },
                          child: Text(
                            ksClearAll.tr,
                            style: regular12TextStyle(
                                cWhiteColor.withOpacity(0.5)),
                          )),
                    ],
                  ),
                if (homeController.isApplyClicked.value) kH8sizedBox,
                if (homeController.isApplyClicked.value)
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
                        ],
                      ),
                    ),
                  ),
                if (homeController.isApplyClicked.value) kH16sizedBox,
                homeController.isTvChannelListLoading.value
                          ? const CircularProgressIndicator()
                          : NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (homeController.tvChannelListScrollController
                                            .position.userScrollDirection ==
                                        ScrollDirection.reverse &&
                                    scrollNotification.metrics.pixels ==
                                        scrollNotification
                                            .metrics.maxScrollExtent &&
                                    !homeController.tvChannelListScrolled.value) {
                                  homeController.tvChannelListScrolled.value =
                                      true;
                                  if (homeController.allTvChannelList.isNotEmpty) {
                                    homeController.getMoreTvChannelList();
                                  }
                                  return true;
                                }
                                return false;
                              },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: homeController.tvChannelListScrollController,
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.98,
                            ),
                            itemCount: homeController.allTvChannelList.length,
                            itemBuilder: (context, index) {
                              return Obx(() => InkWell(
                                    onTap: () async {
                                      await homeController.getTvChannelDetails(
                                          tvChannelId: homeController
                                              .allTvChannelList[index].id);
                                              // Get.toNamed(krLiveTvPlayerScreen);
                                              homeController.liveTvUrl.value = homeController
                                              .allTvChannelList[index].streamUrl??"";
                                              Get.toNamed(krLiveTvPlayerScreen);
                                    },
                                    child: FeaturedTvChannelsContentContainer(
                                      containerWidth: 94.w,
                                      image: homeController
                                              .allTvChannelList[index].thumbnail ??
                                          "",
                                    ),
                                  ));
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
             bottomNavigationBar: CustomBottomNavBar(
              width: width,
              selectedIndex: 1,
              // isFirstButtonClicked: true,
              // isSecondButtonClicked: false,
              // isThirdButtonClicked: false,
              // isFourthButtonClicked: false,
              // isFifthButtonClicked: false,
            ),
        ),
      ),
    );
  }
}

class TvChannelsBottomSheetContent extends StatelessWidget {
  TvChannelsBottomSheetContent({super.key});
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
                  itemCount: homeController.tvChannelCategoryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedCategoryId.value =
                                homeController
                                        .tvChannelCategoryList[index].id ??
                                    -1;
                            homeController.selectedCategory.value =
                                homeController.tvChannelCategoryList[index]
                                        .liveTvCategory ??
                                    "";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedCategoryId.value ==
                                      homeController
                                          .tvChannelCategoryList[index].id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.tvChannelCategoryList[index]
                                          .liveTvCategory ??
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
                  itemCount: homeController.tvChannelCountryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedCountryId.value =
                                homeController.tvChannelCountryList[index].id ??
                                    -1;
                            homeController.selectedCountry.value =
                                homeController
                                        .tvChannelCountryList[index].name ??
                                    "";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedCountryId.value ==
                                      homeController
                                          .tvChannelCountryList[index].id
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
                                          .tvChannelCountryList[index].name ??
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
                  await homeController.getTvChannel();
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
