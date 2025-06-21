import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class AllBlogsViewAllScreen extends StatelessWidget {
  AllBlogsViewAllScreen({super.key});
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
                      ksAllBlogs.tr,
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
                          globalController.commonBottomSheet(bottomSheetColor: cBlackColor2,bottomSheetHeight: height*0.5,context: context, content: AllBlogBottomSheetContent(), onPressCloseButton: (){Get.back();}, onPressRightButton: (){}, rightText: "", rightTextStyle: semiBold16TextStyle(cWhiteColor), title: "${ksFilter.tr} ${homeController.selectedTitle.value}", isRightButtonShow: false);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Obx(
            () => Column(
              children: [
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH16sizedBox,
                homeController.blogList.isEmpty
                    ? SizedBox(
                        height: (height * 0.65),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              kiSearchResultPng,
                              width: 200.w,
                              height: 200.h,
                            ),
                            Text(
                              ksNoBlogFound.tr,
                              style: medium16TextStyle(cPrimaryColor2),
                            ),
                            kH16sizedBox,
                            Text(
                              ksNoBlogsFoundPleaseCheckFilter.tr,
                              style:
                                  regular14TextStyle(cWhiteColor.withOpacity(
                                0.5,
                              )),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                     : homeController.isBlogLoading.value
                          ? const CircularProgressIndicator()
                          : NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (homeController.blogListScrollController
                                            .position.userScrollDirection ==
                                        ScrollDirection.reverse &&
                                    scrollNotification.metrics.pixels ==
                                        scrollNotification
                                            .metrics.maxScrollExtent &&
                                    !homeController.blogListScrolled.value) {
                                  homeController.blogListScrolled.value =
                                      true;
                                  if (homeController.blogList.isNotEmpty) {
                                    homeController.getMoreBlogList();
                                  }
                                  return true;
                                }
                                return false;
                              },
                  child: Expanded(
                    child: SingleChildScrollView(
                      controller: homeController.blogListScrollController,
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: homeController.blogList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await homeController.getBlogDetails(
                                      homeController.blogList[index].id);
                                  Get.toNamed(krBlogSingleScreen);
                                },
                                child: LatestBlogPostContent(
                                  contentHeight: 240.h,
                                  image: homeController.blogList[index].image ?? "",
                                  title: homeController.blogList[index].title ?? "",
                                  subTitle:
                                      homeController.blogList[index].seoTitle ?? "",
                                  // date: homeController.blogDetails.value?.createdAt?.toString()??"",
                                  date: homeController.blogDetails.value?.createdAt != null ? DateFormat('d MMM, yyyy').format(DateTime.parse(homeController.blogDetails.value?.createdAt?.toString()??"")):"",
                                  reporter: homeController.blogList[index].author ?? "",
                                  isTop: homeController.blogList[index].isTop,
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

class AllBlogBottomSheetContent extends StatelessWidget {
  AllBlogBottomSheetContent({super.key});
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
                  itemCount: homeController.blogCategoryList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedBlogCategories.value =
                                homeController
                                        .blogCategoryList[index].videoType ??
                                    "";
                            homeController.selectedBlogCategoryId.value =
                                homeController.blogCategoryList[index].id
                                    .toString();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController
                                          .selectedBlogCategories.value ==
                                      homeController
                                          .blogCategoryList[index].videoType
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
                                          .blogCategoryList[index].videoType ??
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
                  itemCount: homeController.blogYearList.length,
                  separatorBuilder: (context, index) => kW8sizedBox,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            homeController.selectedBlogYear.value =
                                homeController.blogYearList[index].toString();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: cWhiteColor.withOpacity(0.04),
                              border: homeController.selectedBlogYear.value ==
                                      homeController.blogYearList[index]
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
                                  homeController.blogYearList[index].toString(),
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
                  await homeController.getBlogFilterList();
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
