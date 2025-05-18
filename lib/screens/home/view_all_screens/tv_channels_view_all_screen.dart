import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class TvChannelsViewAllScreen extends StatelessWidget {
  TvChannelsViewAllScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Column(
              children: [
                kH40sizedBox,
                Row(
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
                                ksAllTVChannel.tr,
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
                    Container(
                      width: 40.w,
                      height: 40.h,
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
                    kW6sizedBox,
                    GestureDetector(
                      onTap: () {
                        Get.find<GlobalController>().commonBottomSheet(
                            context: context,
                            bottomSheetHeight: height * 0.6,
                            isScrollControlled: true,
                            content: TvChannelsBottomSheetContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {},
                            rightText: "",
                            rightTextStyle: semiBold14TextStyle(cWhiteColor),
                            title: ksFilterTvChannel.tr,
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
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.98,
                  ),
                  itemCount: homeController.featuredTvChannelsList.length,
                  itemBuilder: (context, index) {
                    return FeaturedTvChannelsContentContainer(
                      containerWidth: 94.w,
                      image: homeController.featuredTvChannelsList[index].thumbnail??"",
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

class TvChannelsBottomSheetContent extends StatelessWidget {
  TvChannelsBottomSheetContent({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kH8sizedBox,
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        //   child: Text(
        //     ksCategories.tr,
        //     style: medium16TextStyle(cWhiteColor),
        //   ),
        // ),
        // kH16sizedBox,
        // Padding(
        //   padding: const EdgeInsets.only(left: k20Padding),
        //   child: Row(
        //     children: [
        //       SizedBox(
        //         width: width - 20.w,
        //         height: 34.h,
        //         child: ListView.separated(
        //           itemCount: homeController.tvChannelCategoriesList.length,
        //           separatorBuilder: (context, index) => kW8sizedBox,
        //           shrinkWrap: true,
        //           physics: const AlwaysScrollableScrollPhysics(),
        //           scrollDirection: Axis.horizontal,
        //           itemBuilder: (context, index) {
        //             return Obx(() => GestureDetector(
        //                   onTap: () {
        //                     homeController.selectedTvChannelCategories.value =
        //                         homeController.tvChannelCategoriesList[index];
        //                   },
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                       color: cWhiteColor.withOpacity(0.04),
        //                       border: homeController
        //                                   .selectedTvChannelCategories.value ==
        //                               homeController
        //                                   .tvChannelCategoriesList[index]
        //                           ? Border.all(width: 1, color: cPrimaryColor2)
        //                           : Border.all(width: 0),
        //                       borderRadius: BorderRadius.circular(6.r),
        //                     ),
        //                     child: Padding(
        //                       padding: EdgeInsets.symmetric(
        //                           horizontal: 16.w, vertical: 6.h),
        //                       child: Center(
        //                         child: Text(
        //                           homeController.tvChannelCategoriesList[index],
        //                           style: regular14TextStyle(cWhiteColor),
        //                           textAlign: TextAlign.center,
        //                           overflow: TextOverflow.clip,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ));
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // kH16sizedBox,
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        //   child: Text(
        //     ksLanguage.tr,
        //     style: medium16TextStyle(cWhiteColor),
        //   ),
        // ),
        // kH16sizedBox,
        // Padding(
        //   padding: const EdgeInsets.only(left: k20Padding),
        //   child: Row(
        //     children: [
        //       SizedBox(
        //         width: width - 20.w,
        //         height: 34.h,
        //         child: ListView.separated(
        //           itemCount: homeController.languageList.length,
        //           separatorBuilder: (context, index) => kW8sizedBox,
        //           shrinkWrap: true,
        //           physics: const AlwaysScrollableScrollPhysics(),
        //           scrollDirection: Axis.horizontal,
        //           itemBuilder: (context, index) {
        //             return Obx(() => GestureDetector(
        //                   onTap: () {
        //                     homeController.selectedLanguage.value =
        //                         homeController.languageList[index];
        //                   },
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                       color: cWhiteColor.withOpacity(0.04),
        //                       border: homeController.selectedLanguage.value ==
        //                               homeController.languageList[index]
        //                           ? Border.all(width: 1, color: cPrimaryColor2)
        //                           : Border.all(width: 0),
        //                       borderRadius: BorderRadius.circular(6.r),
        //                     ),
        //                     child: Padding(
        //                       padding: EdgeInsets.symmetric(
        //                           horizontal: 16.w, vertical: 6.h),
        //                       child: Center(
        //                         child: Text(
        //                           homeController.languageList[index],
        //                           style: regular14TextStyle(cWhiteColor),
        //                           textAlign: TextAlign.center,
        //                           overflow: TextOverflow.clip,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ));
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // kH16sizedBox,
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        //   child: Text(
        //     ksSort.tr,
        //     style: medium16TextStyle(cWhiteColor),
        //   ),
        // ),
        // kH16sizedBox,
        // Padding(
        //   padding: const EdgeInsets.only(left: k20Padding),
        //   child: Row(
        //     children: [
        //       SizedBox(
        //         width: width - 20.w,
        //         height: 34.h,
        //         child: ListView.separated(
        //           itemCount: homeController.tvChannelsSortList.length,
        //           separatorBuilder: (context, index) => kW8sizedBox,
        //           shrinkWrap: true,
        //           physics: const AlwaysScrollableScrollPhysics(),
        //           scrollDirection: Axis.horizontal,
        //           itemBuilder: (context, index) {
        //             return Obx(() => GestureDetector(
        //                   onTap: () {
        //                     homeController.selectedTvChannelsSort.value =
        //                         homeController.tvChannelsSortList[index];
        //                   },
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                       color: cWhiteColor.withOpacity(0.04),
        //                       border: homeController
        //                                   .selectedTvChannelsSort.value ==
        //                               homeController.tvChannelsSortList[index]
        //                           ? Border.all(width: 1, color: cPrimaryColor2)
        //                           : Border.all(width: 0),
        //                       borderRadius: BorderRadius.circular(6.r),
        //                     ),
        //                     child: Padding(
        //                       padding: EdgeInsets.symmetric(
        //                           horizontal: 16.w, vertical: 6.h),
        //                       child: Center(
        //                         child: Text(
        //                           homeController.tvChannelsSortList[index],
        //                           style: regular14TextStyle(cWhiteColor),
        //                           textAlign: TextAlign.center,
        //                           overflow: TextOverflow.clip,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ));
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // kH8sizedBox,
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        //   child: Divider(
        //     thickness: 1,
        //     color: cWhiteColor.withOpacity(0.1),
        //   ),
        // ),
        // kH8sizedBox,
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        //   child: Row(
        //     children: [
        //       CustomElevatedButton(
        //         label: ksReset.tr,
        //         onPressed: () {
        //           homeController.resetBottomNavBarData();
        //           homeController.tvChannelsFilterValueReset();
        //         },
        //         buttonColor: cWhiteColor.withOpacity(0.2),
        //         textStyle: regular16TextStyle(cWhiteColor),
        //         buttonWidth: (width - 56) / 2,
        //       ),
        //       kW16sizedBox,
        //       CustomElevatedButton(
        //         label: ksApply.tr,
        //         onPressed: () {
        //           Get.back();
        //         },
        //         buttonColor: cPrimaryColor2,
        //         textStyle: regular16TextStyle(cWhiteColor),
        //         buttonWidth: (width - 56) / 2,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
