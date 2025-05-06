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
              title: homeController.isViewAllSearchEnable.value ? 
                  Row(
                    children: [
                        InkWell(
                    onTap: (){
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
                         height: 38.h,
                              width: (width - 56),
                        child: CustomModifiedTextField(
                                      hint: ksSearchHere.tr,
                                      controller: homeController
                                          .viewAllTextEditingController,
                                      fillColor: cBlackColor,
                                      onChanged: (v){
                                        if(v==""){
                                          homeController.isTopArtistSearchSuffixShow.value = false;
                                        }
                                        else{
                                          homeController.isTopArtistSearchSuffixShow.value = true;
                                        }
                                      },
                                      onSubmit: (v){
                                              if(v==""){
                                                unfocus(context);
                                        }
                                        else{
                                          homeController.getArtistList();
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
                                      suffixIcon: homeController.isTopArtistSearchSuffixShow.value ? Icons.close:null,
                                      onSuffixPress: (){
                                        homeController.isTopArtistSearchSuffixShow.value=false;
                                        homeController
                                          .viewAllTextEditingController.clear();
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
              if(homeController.isViewAllSearchEnable.value == false)
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
                   )
              // kW6sizedBox,
              //!maybe not needed
              // Padding(
              //   padding: const EdgeInsets.only(right: k8Padding),
              //   child: InkWell(
              //     onTap: (){
              //       globalController.commonBottomSheet(bottomSheetColor: cBlackColor2,bottomSheetHeight: height*0.5,context: context, content: AllBlogBottomSheetContent(), onPressCloseButton: (){Get.back();}, onPressRightButton: (){}, rightText: "", rightTextStyle: semiBold16TextStyle(cWhiteColor), title: "${ksFilter.tr} ${homeController.selectedTitle.value}", isRightButtonShow: false);
              //     },
              //     child: Container(
              //        width: 40.w,
              //       height: 40.h,
              //       decoration: const BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: cPrimaryColor2,
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(k12Padding),
              //         child: SvgPicture.asset(kiFilter,color: cWhiteColor,),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Obx(
              () => Column(
                children: [
                      //!Maybe not needed this filter icon
                    //   GestureDetector(
                    //                    onTap: () {
                    //   Get.find<GlobalController>().commonBottomSheet(
                    //       context: context,
                    //       bottomSheetHeight: height*0.65,
                    //       isScrollControlled: true,
                    //       content: TopArtistBottomSheetContent(),
                    //       onPressCloseButton: () {
                    //         Get.back();
                    //       },
                    //       onPressRightButton: () {},
                    //       rightText: "",
                    //       rightTextStyle: semiBold14TextStyle(cWhiteColor),
                    //       title: ksFilterArtists.tr,
                    //       isRightButtonShow: false,
                    //       bottomSheetColor: cBlackColor);
                    // },
                    //     child: Container(
                    //        width: 40.w,
                    //       height: 40.h,
                    //       decoration: const BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: cPrimaryColor2,
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(k12Padding),
                    //         child: SvgPicture.asset(kiFilter,color: cWhiteColor,),
                    //       ),
                    //     ),
                    //   ),
                  //   ],
                  // ),

                  // kH8sizedBox,
                  Divider(
                    thickness: 1,
                    color: cWhiteColor.withOpacity(0.2),
                  ),
                  kH16sizedBox,
                  GridView.builder(
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
                          image:
                              homeController.artistList[index].starImage ?? "",
                          name: homeController.artistList[index].starName ?? "",
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
                  itemCount: homeController.artistsCategoriesList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedArtistsCategories.value =
                                homeController.artistsCategoriesList[index];
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController
                                          .selectedArtistsCategories.value ==
                                      homeController
                                          .artistsCategoriesList[index]
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.artistsCategoriesList[index],
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
                  itemCount: homeController.artistsCountryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedArtistsCountry.value =
                                homeController.artistsCountryList[index];
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController
                                          .selectedArtistsCountry.value ==
                                      homeController.artistsCountryList[index]
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.artistsCountryList[index],
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
                  itemCount: homeController.languageList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedLanguage.value =
                                homeController.languageList[index];
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedLanguage.value ==
                                      homeController.languageList[index]
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.languageList[index],
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
                  itemCount: homeController.artistsSortList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedArtistsSort.value =
                                homeController.artistsSortList[index];
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController
                                          .selectedArtistsSort.value ==
                                      homeController.artistsSortList[index]
                                  ? Border.all(width: 1, color: cPrimaryColor2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 6.h),
                              child: Center(
                                child: Text(
                                  homeController.artistsSortList[index],
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
                  homeController.artistsFilterValueReset();
                },
                buttonColor: cWhiteColor.withOpacity(0.2),
                textStyle: regular16TextStyle(cWhiteColor),
                buttonWidth: (width - 56) / 2,
              ),
              kW16sizedBox,
              CustomElevatedButton(
                label: ksApply.tr,
                onPressed: () {
                  Get.back();
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
