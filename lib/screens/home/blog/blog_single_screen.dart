import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

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
                      ksBlogSinglePage.tr,
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
                          // globalController.commonBottomSheet(bottomSheetColor: cBlackColor2,bottomSheetHeight: height*0.5,context: context, content: Container(), onPressCloseButton: (){Get.back();}, onPressRightButton: (){}, rightText: "", rightTextStyle: semiBold16TextStyle(cWhiteColor), title: "${ksFilter.tr} ${homeController.selectedTitle.value}", isRightButtonShow: false);
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
              //                HtmlWidget(
              //   homeController.blogDetails.value?.description ?? '',
              //   customStylesBuilder: (element) {
              //     if (element.localName == 'p') {
              //       return {
              //         'margin-bottom': '16px',
              //         'font-family': 'Roboto',
              //         'font-size': '16px',
              //       };
              //     }
              //     return null;
              //   },
              //   customWidgetBuilder: (element) {
              //     if (element.localName == 'img') {
              //       return Image.network(
              //         element.attributes['src'] ?? '',
              //         fit: BoxFit.cover,
              //       );
              //     } 
              //     // else if (element.localName == 'video') {
              //     //   final sourceUrl = element.children.first.attributes['src'];
              //     //   return ChewieController(
              //     //     videoPlayerController: VideoPlayerController.network(sourceUrl),
              //     //     fullScreenByDefault: false,
              //     //     aspectRatio: 16/9,
              //     //     placeholder: Center(child: CircularProgressIndicator()),
              //     //   ).build(context);
              //     // }
              //     return null;
              //   },
              // ),
              if(homeController.blogDetails.value?.description!=null)
                HtmlWidget(homeController.blogDetails.value?.description),
              //   kH20sizedBox,
              //   ClipRRect(
              //       borderRadius: BorderRadius.circular(k4BorderRadius),
              //       child: Image.network(
              //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa54OMxsrzyzRkNgqGlTT6iKs79aImGXmJGAU7HrKeqAS0gZKSXMJOxkk&s",
              //         width: width - 40,
              //         height: 240.h,
              //         fit: BoxFit.cover,
              //       )),
              //   kH20sizedBox,
              //   Text(
              //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero.",
              //     style: regular14TextStyle(
              //       cWhiteColor.withOpacity(0.7),
              //     ),
              //   ),
              //   kH20sizedBox,
              //   ClipRRect(
              //       borderRadius: BorderRadius.circular(k4BorderRadius),
              //       child: Image.network(
              //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa54OMxsrzyzRkNgqGlTT6iKs79aImGXmJGAU7HrKeqAS0gZKSXMJOxkk&s",
              //         width: width - 40,
              //         height: 240.h,
              //         fit: BoxFit.cover,
              //       )),
              //   kH20sizedBox,
              //   Text("What is shoes trend in 2022 ?",
              //       style: medium16TextStyle(cWhiteColor)),
              //   kH20sizedBox,
              //   Text(
              //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero.",
              //     style: regular14TextStyle(
              //       cWhiteColor.withOpacity(0.7),
              //     ),
              //   ),
              //   kH20sizedBox,
              //   Container(
              //     decoration: BoxDecoration(
              //       color: cWhiteColor.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(k6BorderRadius),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: k20Padding, vertical: k30Padding),
              //       child: Text(
              //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. ",
              //         style: regular16TextStyle(cWhiteColor),
              //       ),
              //     ),
              //   ),
              //   kH20sizedBox,
              //   Text(
              //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero. Nam eget pulvinar ante. Suspendisse ante arcu, venenatis at purus eget, porta ultrices nulla. Nam eget pulvinar ante. Suspendisse ante arcu, venenatis at purus eget, porta ultrices nulla.",
              //     style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
              //   ),
              //   kH20sizedBox,
              //   //!needed
              //   GridView.builder(
              //     shrinkWrap: true,
              //     padding: EdgeInsets.zero,
              //     physics: const NeverScrollableScrollPhysics(),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       crossAxisSpacing: 16,
              //       mainAxisSpacing: 10,
              //       childAspectRatio: 0.9,
              //     ),
              //     itemCount: homeController.latestBlogList.length,
              //     itemBuilder: (context, index) {
              //       return SizedBox(
              //           width: width - 72,
              //           height: 120,
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(k4BorderRadius),
              //             child: Image.network(
              //               // homeController.blogDetails.value?.image??"",
              //               homeController.blogDetails.value?.image??"",
              //               width: width - 72,
              //               height: 120,
              //               fit: BoxFit.cover,
              //                       errorBuilder: (context, error, stackTrace) =>  Center(
              //   child: SvgPicture.asset(
              //     kiDummyMovie,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              //             ),
              //           ));
              //     },
              //   ),
              //   kH24sizedBox,
              //   Text(
              //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero.",
              //     style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
              //   ),
              //   kH20sizedBox,
              //   Text(
              //     "What is shoes trend in 2022 ?",
              //     style: medium16TextStyle(cWhiteColor),
              //   ),
              //   kH20sizedBox,
              //   for (int i = 0;
              //       i < homeController.blogBulletPointList.length;
              //       i++)
              //     Padding(
              //       padding: const EdgeInsets.only(bottom: k8Padding),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(top: k8Padding),
              //             child: Container(
              //               width: 4,
              //               height: 4,
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: cWhiteColor.withOpacity(0.7),
              //               ),
              //             ),
              //           ),
              //           kW8sizedBox,
              //           Expanded(
              //               child: Text(homeController.blogBulletPointList[i],
              //                   style: regular14TextStyle(
              //                       cWhiteColor.withOpacity(0.7)),
              //                   overflow: TextOverflow.clip)),
              //         ],
              //       ),
              //     ),
              //   kH20sizedBox,
              //   Row(
              //     children: [
              //       Container(
              //         width: 80.w,
              //         height: 80.h,
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //         ),
              //         child: CircleAvatar(
              //           backgroundColor: cWhiteColor.withOpacity(0.2),
              //           child: ClipOval(
              //             child: Image.network(
              //               width: 80.w,
              //               height: 80.h,
              //               fit: BoxFit.cover,
              //               "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
              //             ),
              //           ),
              //         ),
              //       ),
              //       kW16sizedBox,
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Esther Howard",
              //             style: semiBold18TextStyle(cWhiteColor),
              //           ),
              //           kH8sizedBox,
              //           Text(
              //             "Author",
              //             style:
              //                 regular16TextStyle(cWhiteColor.withOpacity(0.5)),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              //   kH20sizedBox,
              //   Text(
              //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero.",
              //     style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
              //   ),
              //   kH35sizedBox,
              //   Row(
              //     children: [
              //       SvgPicture.asset(
              //         kiShare,
              //         width: 16.w,
              //         height: 16.w,
              //         color: cWhiteColor,
              //       ),
              //       kW12sizedBox,
              //       Text(
              //         ksShareWith.tr,
              //         style: medium16TextStyle(cWhiteColor),
              //       ),
              //     ],
              //   ),
              //   kH16sizedBox,
              //   Divider(
              //     thickness: 1,
              //     color: cWhiteColor.withOpacity(0.2),
              //   ),
              //   kH20sizedBox,
              //   const Row(
              //     children: [
              //       ShareCommonContainer(
              //         image: kiFacebook2,
              //       ),
              //       kW10sizedBox,
              //       ShareCommonContainer(
              //         image: kiTwitter,
              //       ),
              //       kW10sizedBox,
              //       ShareCommonContainer(
              //         image: kiPinterest,
              //       ),
              //       kW10sizedBox,
              //       ShareCommonContainer(
              //         image: kiInstagram,
              //       ),
              //     ],
              //   ),
              //   kH30sizedBox,
              //   HomeTitleContent(
              //     title: ksLatestBlog.tr,
              //     subtitleText: ksViewAll,
              //     isHorizontalPadding: false,
              //     onPressed: () {
              //       Get.toNamed(krAllBlogsViewAllScreen);
              //     },
              //   ),
                // kH16sizedBox,
                // Row(
                //   children: [
                //     SizedBox(
                //       width: width - 40,
                //       height: 210.h,
                //       child: ListView.separated(
                //         itemCount: homeController.latestBlogList.length,
                //         separatorBuilder: (context, index) => kW10sizedBox,
                //         shrinkWrap: true,
                //         physics: const AlwaysScrollableScrollPhysics(),
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (context, index) {
                //           return GestureDetector(
                //             onTap: () {
                //               Get.toNamed(krBlogSingleScreen);
                //             },
                //             child: LatestBlogPostContent(
                //               image: homeController.latestBlogList[index]
                //                   ["image"],
                //               title: homeController.latestBlogList[index]
                //                   ["title"],
                //               subTitle: homeController.latestBlogList[index]
                //                   ["subtitle"],
                //               date: homeController.latestBlogList[index]
                //                   ["date"],
                //               reporter: homeController.latestBlogList[index]
                //                   ["reporter"],
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                //!comment widget
                kH20sizedBox,
                Container(
                  width: width - 40,
                  decoration: BoxDecoration(
                    color: cWhiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(k6BorderRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: k16Padding, vertical: k20Padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "10 Comments",
                          style: medium16TextStyle(cWhiteColor),
                        ),
                        // kW36sizedBox,
                        Text(
                          "${ksSubmitRating.tr}:",
                          style: regular16TextStyle(cWhiteColor),
                        ),
                        //!temporary(this is not valid)
                        const Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              size: kIconSize16,
                              color: cWhiteColor,
                            ),
                            Icon(
                              Icons.star_border,
                              size: kIconSize16,
                              color: cWhiteColor,
                            ),
                            Icon(
                              Icons.star_border,
                              size: kIconSize16,
                              color: cWhiteColor,
                            ),
                            Icon(
                              Icons.star_border,
                              size: kIconSize16,
                              color: cWhiteColor,
                            ),
                            Icon(
                              Icons.star_border,
                              size: kIconSize16,
                              color: cWhiteColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                kH20sizedBox,
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: cWhiteColor.withOpacity(0.2),
                        child: ClipOval(
                          child: Image.network(
                              width: 40.w,
                              height: 40.h,
                              fit: BoxFit.cover,
                              "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D"),
                        ),
                      ),
                    ),
                    kW12sizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Saikat Ahmmed",
                              style: medium16TextStyle(cWhiteColor),
                            ),
                            kW6sizedBox,
                            Container(
                              width: 6.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: cGreyColor.withOpacity(0.8),
                              ),
                            ),
                            kW6sizedBox,
                            Icon(
                              Icons.access_time,
                              color: cGreyColor.withOpacity(0.8),
                              size: kIconSize16,
                            ),
                            kW6sizedBox,
                            Text(
                              "2 years ago",
                              style: regular10TextStyle(
                                  cGreyColor.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        kH10sizedBox,
                        SizedBox(
                          width: width - 96,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_outline,
                                color: cWhiteColor,
                                size: kIconSize20,
                              ),
                              kW6sizedBox,
                              Text(
                                "100K",
                                style: regular12TextStyle(
                                    cGreyColor.withOpacity(0.8)),
                              ),
                              kW12sizedBox,
                              SizedBox(
                                height: h8.h,
                                child: VerticalDivider(
                                  width: 1,
                                  thickness: 1,
                                  color: cWhiteColor.withOpacity(0.14),
                                ),
                              ),
                              kW12sizedBox,
                              SvgPicture.asset(
                                kiMessage,
                                width: 14.w,
                                height: 14.h,
                                color: cWhiteColor,
                              ),
                              kW6sizedBox,
                              Text(
                                "10k replies",
                                style: regular12TextStyle(
                                    cGreyColor.withOpacity(0.8)),
                              ),
                              kW6sizedBox,
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: cWhiteColor,
                                size: kIconSize20,
                              ),
                              //  Spacer(),
                              Expanded(child: SizedBox()),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    kiReply,
                                    width: 16.w,
                                    height: 16.h,
                                    color: cPrimaryColor2,
                                  ),
                                  kW14sizedBox,
                                  Text(
                                    ksReply.tr,
                                    style: regular16TextStyle(cPrimaryColor2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                             kH12sizedBox,
                             Padding(
                               padding: EdgeInsets.only(left: 52.w),
                               child: SizedBox(
                                width: width-72,
                                 child: Column(
                                   children: [
                                     Divider(thickness: 1,color: cWhiteColor.withOpacity(0.14),),
                                                          Text(
                                        "Lorem ipsum dolor sit amet consectetur. Eget dictum at ipsum ridiculus nec. Viverra mauris molestie ut rhoncus.",
                                        style: regular14TextStyle(cWhiteColor),
                                      ),
                                   ],
                                 ),
                               ),
                             ),
                kH20sizedBox,
                                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: cWhiteColor.withOpacity(0.2),
                        child: ClipOval(
                          child: Image.network(
                              width: 40.w,
                              height: 40.h,
                              fit: BoxFit.cover,
                              "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D"),
                        ),
                      ),
                    ),
                    kW12sizedBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Saikat Ahmmed",
                              style: medium16TextStyle(cWhiteColor),
                            ),
                            kW6sizedBox,
                            Container(
                              width: 6.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: cGreyColor.withOpacity(0.8),
                              ),
                            ),
                            kW6sizedBox,
                            Icon(
                              Icons.access_time,
                              color: cGreyColor.withOpacity(0.8),
                              size: kIconSize16,
                            ),
                            kW6sizedBox,
                            Text(
                              "2 years ago",
                              style: regular10TextStyle(
                                  cGreyColor.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        kH10sizedBox,
                        SizedBox(
                          width: width - 96,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_outline,
                                color: cWhiteColor,
                                size: kIconSize20,
                              ),
                              kW6sizedBox,
                              Text(
                                "100K",
                                style: regular12TextStyle(
                                    cGreyColor.withOpacity(0.8)),
                              ),
                              kW12sizedBox,
                              SizedBox(
                                height: h8.h,
                                child: VerticalDivider(
                                  width: 1,
                                  thickness: 1,
                                  color: cWhiteColor.withOpacity(0.14),
                                ),
                              ),
                              kW12sizedBox,
                              SvgPicture.asset(
                                kiMessage,
                                width: 14.w,
                                height: 14.h,
                                color: cWhiteColor,
                              ),
                              kW6sizedBox,
                              Text(
                                "10k replies",
                                style: regular12TextStyle(
                                    cGreyColor.withOpacity(0.8)),
                              ),
                              kW6sizedBox,
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: cWhiteColor,
                                size: kIconSize20,
                              ),
                            const Expanded(child: SizedBox()),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    kiReply,
                                    width: 16.w,
                                    height: 16.h,
                                    color: cPrimaryColor2,
                                  ),
                                  kW14sizedBox,
                                  Text(
                                    ksReply.tr,
                                    style: regular16TextStyle(cPrimaryColor2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                             kH12sizedBox,
                             Padding(
                               padding: EdgeInsets.only(left: 52.w),
                               child: SizedBox(
                                width: width-72,
                                 child: Column(
                                   children: [
                                     Divider(thickness: 1,color: cWhiteColor.withOpacity(0.14),),
                                                          Text(
                                        "Lorem ipsum dolor sit amet consectetur. Eget dictum at ipsum ridiculus nec. Viverra mauris molestie ut rhoncus.",
                                        style: regular14TextStyle(cWhiteColor),
                                      ),
                                   ],
                                 ),
                               ),
                             ),
                             kH12sizedBox,
                             Divider(
                              thickness: 1,
                              color: cWhiteColor.withOpacity(0.14),
                             ),
                             kH20sizedBox,
                             Text(ksAddYourComment.tr,style: medium16TextStyle(cWhiteColor),),
                             kH20sizedBox,
                                             CustomModifiedTextField(
                                               hint: ksEnterHere.tr,
                                               controller: homeController.addCommentTextEditingController,
                                               fillColor: cBlackColor,
                                               textInputStyle: regular14TextStyle(cWhiteColor),
                                               focusBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(k6BorderRadius),
                                                 borderSide: const BorderSide(
                                                   width: 1,
                                                   color: cPrimaryColor2,
                                                 ),
                                               ),
                                               maxLines: 4,
                                               inputAction: TextInputAction.newline,
                                               inputType: TextInputType.multiline,
                                                border: 
                                             OutlineInputBorder(
                                               borderRadius: BorderRadius.circular(k6BorderRadius),
                                               borderSide:  BorderSide(width: 1,color: cWhiteColor.withOpacity(0.3), style: BorderStyle.solid,),
                                             ),
                                             contentPadding: const EdgeInsets.all(12),
                                               ),
                                               kH12sizedBox,
                                               Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 34.w,
                                                    height: 34.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(k6BorderRadius),
                                                      color: cWhiteColor.withOpacity(0.1),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(9.0),
                                                      child: SvgPicture.asset(kiEmoji,width: 16.w,height: 16.h,color: cWhiteColor,),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                  CustomElevatedButton(label: ksCancel.tr, onPressed: (){},buttonColor: cWhiteColor.withOpacity(0.1),textStyle: regular16TextStyle(cWhiteColor),buttonWidth: 70.w,buttonHeight: h36.h,),
                                                  kW12sizedBox,
                                                  CustomElevatedButton(label: ksPostNow.tr, onPressed: (){},buttonColor: cPrimaryColor2,textStyle: regular16TextStyle(cWhiteColor),buttonWidth: 90.w,buttonHeight: h36.h,),
                                                    ],
                                                  ),
                                                ],
                                               ),
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
