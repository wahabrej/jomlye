import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class TopArtistsViewAllScreen extends StatelessWidget {
  TopArtistsViewAllScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Obx(
        () => Scaffold(
          backgroundColor: cBlackColor,
          //* info:: appBar
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
                                    .isTopArtistSearchSuffixShow.value = false;
                              } else {
                                homeController
                                    .isTopArtistSearchSuffixShow.value = true;
                              }
                            },
                            onSubmit: (v) async {
                              if (v == "") {
                                unfocus(context);
                              } else {
                                await homeController.getArtistList();
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
                                homeController.isTopArtistSearchSuffixShow.value
                                    ? Icons.close
                                    : null,
                            onSuffixPress: () {
                              homeController.isTopArtistSearchSuffixShow.value =
                                  false;
                              homeController.viewAllTextEditingController
                                  .clear();
                              unFocus(context);
                            },
                          ),
                        ),
                      ],
                    )
                  //   ],
                  // )
                  : GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 120.w,
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
                                ksTopArtists.tr,
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
                          bottomSheetHeight: height * 0.5,
                          context: context,
                          content: TopArtistBottomSheetContent(),
                          onPressCloseButton: () {
                            Get.back();
                          },
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
                ),
              ],
            ),
          ),
          
          
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: Obx(
                () => Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: cWhiteColor.withOpacity(0.2),
                    ),
                    kH16sizedBox,
                    if (homeController.isApplyClicked.value)
                    Row(
                      children: [
                        Text(
                          ksFiltered.tr,
                          style: medium16TextStyle(cWhiteColor),
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                            onTap: () async{
                              homeController.resetBottomSheetData();
                             await homeController.getArtistList();
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
                                      horizontal: k12Padding,
                                      vertical: k6Padding),
                                  child: Center(
                                      child: Text(
                                    homeController.selectedCountry.value,
                                    style: regular14TextStyle(cWhiteColor),
                                  )),
                                )),
                          if (homeController.selectedMovieIndustry.value != "" &&
                              homeController.isApplyClicked.value)
                            kW8sizedBox,
                          if (homeController.selectedMovieIndustry.value != "" &&
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
                                    homeController.selectedMovieIndustry.value,
                                    style: regular14TextStyle(cWhiteColor),
                                  )),
                                )),
                        ],
                      ),
                    ),
                  ),
                kH8sizedBox,
                    homeController.artistList.isEmpty
                        ? SizedBox(
                            height: (height * 0.7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  kiSearchResultPng,
                                  width: 200.w,
                                  height: 200.h,
                                ),
                                Text(
                                  ksNoArtistFound.tr,
                                  style: medium16TextStyle(cPrimaryColor2),
                                ),
                                kH16sizedBox,
                                Text(
                                  ksNoArtistFoundPleaseCheckFilter.tr,
                                  style: regular14TextStyle(
                                      cWhiteColor.withOpacity(
                                    0.5,
                                  )),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            itemCount: homeController.artistList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await homeController.getArtistDetails(
                                      homeController.artistList[index].id);
                                  Get.toNamed(krCastDetailsScreen);
                                },
                                child: TopArtistContent(
                                  image: homeController
                                          .artistList[index].starImage ??
                                      "",
                                  name: homeController
                                          .artistList[index].starName ??
                                      "",
                                  contentWidth: (width - 60) / 3,
                                  contentHeight: 120.h,
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopArtistBottomSheetContent extends StatelessWidget {
  TopArtistBottomSheetContent({super.key});
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
                  itemCount: homeController.artistCountryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedCountryId.value =
                                homeController.artistCountryList[index].id!;
                            homeController.selectedCountry.value =
                                homeController.artistCountryList[index].name??"";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedCountryId.value ==
                                      homeController
                                          .artistCountryList[index].id!
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
                                          .artistCountryList[index].name ??
                                      '',
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
            ksMovieIndustries.tr,
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
                  itemCount: homeController.artistMovieIndustryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedMovieIndustryId.value =
                                homeController
                                    .artistMovieIndustryList[index].id!;
                            homeController.selectedMovieIndustry.value =
                                homeController
                                    .artistMovieIndustryList[index].name??"";
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController
                                          .selectedMovieIndustryId.value ==
                                      homeController
                                          .artistMovieIndustryList[index].id
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.artistMovieIndustryList[index]
                                          .name ??
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
                  homeController.isApplyClicked.value= true;
                  await homeController.getArtistList();
                  Get.back();
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