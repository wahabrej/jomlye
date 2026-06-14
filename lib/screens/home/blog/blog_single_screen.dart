import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class BlogSingleScreen extends StatelessWidget {
  BlogSingleScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

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
              width: 165.w,
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
                      ksBlogSinglePage.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                  ],
                ),
              ),
            ),
          ),
          // actions: [
          //             Container(
          //             width: 36.w,
          //             height: 36.h,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: cWhiteColor.withOpacity(0.2),
          //             ),
          //             child: const Icon(Icons.search,color: cWhiteColor,size: kIconSize24,),
          //           ),
          //           kW6sizedBox,
          //           Padding(
          //             padding: const EdgeInsets.only(right: k8Padding),
          //             child: InkWell(
          //               onTap: (){
          //                 // globalController.commonBottomSheet(bottomSheetColor: cBlackColor2,bottomSheetHeight: height*0.5,context: context, content: Container(), onPressCloseButton: (){Get.back();}, onPressRightButton: (){}, rightText: "", rightTextStyle: semiBold16TextStyle(cWhiteColor), title: "${ksFilter.tr} ${homeController.selectedTitle.value}", isRightButtonShow: false);
          //               },
          //               child: Container(
          //                  width: 40.w,
          //                 height: 40.h,
          //                 decoration: const BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   color: cPrimaryColor2,
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(k12Padding),
          //                   child: SvgPicture.asset(kiFilter,color: cWhiteColor,),
          //                 ),
          //               ),
          //             ),
          //           ),
          // ],
       
       
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH8sizedBox,
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH16sizedBox,
                Text(
                  homeController.blogDetails.value?.title??"",
                  style: medium18TextStyle(cWhiteColor),
                ),
                kH16sizedBox,
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: cPrimaryColor2,
                      size: kIconSize16,
                    ),
                    kW10sizedBox,
                    Text(
                   homeController.blogDetails.value?.createdAt!=null ?  DateFormat('d MMM, yyyy').format(DateTime.parse(homeController.blogDetails.value?.createdAt?.toString()??"")):"",
                      style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
                    ),
                    kW10sizedBox,
                    SizedBox(
                      height: 10,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                    ),
                    kW10sizedBox,
                    const Icon(
                      Icons.mode_comment_outlined,
                      color: cPrimaryColor2,
                      size: kIconSize16,
                    ),
                    kW10sizedBox,
                    Text(
                      "10",
                      style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
                    ),
                    kW10sizedBox,
                    SizedBox(
                      height: 10,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                    ),
                    kW10sizedBox,
                    const Icon(
                      Icons.person_outline_sharp,
                      color: cPrimaryColor2,
                      size: kIconSize16,
                    ),
                    kW10sizedBox,
                    Expanded(
                      child: Text(
                        "By ${homeController.blogDetails.value?.author??""}",
                        style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                kH20sizedBox,
              if(homeController.blogDetails.value?.description==null || homeController.blogDetails.value?.description=="")
              SizedBox(
                        height: (height * 0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              kiSearchResultPng,
                              width: 200.w,
                              height: 200.h,
                            ),
                            Text(
                              ksNoBlogDetailsFound.tr,
                              style: medium16TextStyle(cPrimaryColor2),
                            ),
                            kH16sizedBox,
                            Text(
                              ksNoBlogsDetailsFoundPleaseCheckFilter.tr,
                              style:
                                  regular14TextStyle(cWhiteColor.withOpacity(
                                0.5,
                              )),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
              if(homeController.blogDetails.value?.description!=null)
                HtmlWidget(homeController.blogDetails.value?.description,textStyle: regular14TextStyle(cWhiteColor),),
                // Text(homeController.blogDetailsModel.value?.details?.description??"hi this is description",style: regular14TextStyle(cWhiteColor),),
                kH20sizedBox,
                  //!Rating
                        Obx(() => Column(
                          children: [
                            Container(
                              width: width,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: cWhiteColor.withOpacity(0.1),
                                borderRadius:
                                    BorderRadius.circular(k8BorderRadius),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: k12Padding),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${homeController.movieReviewList.length} ${ksReviews.tr}",
                                      style: semiBold14TextStyle(cWhiteColor),
                                    ),
                                    const Spacer(),
                                    Text(
                                      ksSubmitRating.tr,
                                      style: regular14TextStyle(cWhiteColor),
                                    ),
                                    kW4sizedBox,
                                    Row(
                                      children: List.generate(5, (index) {
                                        return GestureDetector(
                                          onTap: () => homeController
                                              .updateRating(index + 1),
                                          child: Icon(
                                            Icons.star,
                                            size: kIconSize16,
                                            color: index <
                                                    homeController.rating.value
                                                ? cAmberColor
                                                : Colors.grey,
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            kH16sizedBox,
                            CustomModifiedTextField(
                              hint: ksEnterHere.tr,
                              controller: homeController
                                  .addCommentTextEditingController,
                              fillColor: cBlackColor,
                              textInputStyle: regular14TextStyle(cWhiteColor),
                              focusBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: cPrimaryColor2,
                                ),
                              ),
                              maxLines: 4,
                              inputAction: TextInputAction.newline,
                              inputType: TextInputType.multiline,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: cWhiteColor.withOpacity(0.3),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            kH12sizedBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // CustomElevatedButton(
                                //   label: ksCancel.tr,
                                //   onPressed: () {},
                                //   buttonColor: cWhiteColor.withOpacity(0.1),
                                //   textStyle: regular14TextStyle(cWhiteColor),
                                //   buttonWidth: 70.w,
                                //   buttonHeight: h32.h,
                                // ),
                                // kW12sizedBox,
                                CustomElevatedButton(
                                  label: ksPostNow.tr,
                                  onPressed: () async {
                                    await homeController.userRating(
                                        reviewableId: homeController
                                            .blogDetailsModel
                                            .value!
                                            .details!
                                            .id!,
                                            reviewableType: "blog",
                                            );
                                  },
                                  buttonColor: cPrimaryColor2,
                                  textStyle: regular14TextStyle(cWhiteColor),
                                  buttonWidth: 90.w,
                                  buttonHeight: h32.h,
                                ),
                              ],
                            ),
                            kH12sizedBox,
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(k0Padding),
                              separatorBuilder: (context, index) => kH8sizedBox,
                              itemCount: homeController.movieReviewList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 40.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            cWhiteColor.withOpacity(0.2),
                                        child: ClipOval(
                                          child: Image.network(
                                            width: 40.w,
                                            height: 40.h,
                                            fit: BoxFit.cover,
                                            homeController
                                                    .movieReviewList[index]
                                                    ?.user
                                                    ?.profileImage ??
                                                "",
                                          ),
                                        ),
                                      ),
                                    ),
                                    kW12sizedBox,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              homeController
                                                      .movieReviewList[index]
                                                      ?.user
                                                      ?.userName ??
                                                  "",
                                              style: medium16TextStyle(
                                                  cWhiteColor),
                                            ),
                                            kW6sizedBox,
                                            Container(
                                              width: 6.w,
                                              height: 6.h,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    cGreyColor.withOpacity(0.8),
                                              ),
                                            ),
                                            kW6sizedBox,
                                            Icon(
                                              Icons.access_time,
                                              color:
                                                  cGreyColor.withOpacity(0.8),
                                              size: kIconSize16,
                                            ),
                                            kW6sizedBox,
                                            Text(
                                              homeController.movieReviewList[index]?.createdAt??"",
                                              style: regular10TextStyle(
                                                  cGreyColor.withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                        kH10sizedBox,
                                        Obx(() => SizedBox(
                                              width: width - 96,
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      homeController.movieReviewList[index]!.isLiked!.value = !homeController.movieReviewList[index]!.isLiked!.value;
                                                      if(homeController.movieReviewList[index]!.isLiked!.value==true){
                                                        homeController.movieReviewList[index]!.totalLikes!.value++;
                                                      } 
                                                      if(homeController.movieReviewList[index]!.isLiked!.value==false){
                                                        homeController.movieReviewList[index]!.totalLikes!.value--;
                                                      } 
                                                      await homeController.reviewLikeToggle(reviewId: homeController.movieReviewList[index]!.id!);
                                                    },
                                                    child: Icon(
                                                      homeController
                                                                  .movieReviewList[
                                                                      index]!
                                                                  .isLiked!
                                                                  .value ==
                                                              true
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_outline,
                                                      color: homeController
                                                                  .movieReviewList[
                                                                      index]!
                                                                  .isLiked!
                                                                  .value ==
                                                              true
                                                          ? cPrimaryColor
                                                          : cWhiteColor,
                                                      size: kIconSize20,
                                                    ),
                                                  ),
                                                  kW6sizedBox,
                                                  Text(
                                                    homeController
                                                            .movieReviewList[
                                                                index]
                                                            ?.totalLikes?.value
                                                            .toString() ??
                                                        "",
                                                    style: regular12TextStyle(
                                                        cGreyColor
                                                            .withOpacity(0.8)),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        kH10sizedBox,
                                        Text(
                                          homeController.movieReviewList[index]
                                                  ?.review ??
                                              "",
                                          style: medium12TextStyle(cWhiteColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        )),
                     kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShareCommonContainer extends StatelessWidget {
  const ShareCommonContainer({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cWhiteColor.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: SvgPicture.asset(image),
      ),
    );
  }
}
