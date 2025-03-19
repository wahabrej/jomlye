import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/utils/constants/images.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class CastDetailsScreen extends StatelessWidget {
  CastDetailsScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kH40sizedBox,
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: h32,
                    width: 80.w,
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
                            ksBack.tr,
                            style: regular16TextStyle(cWhiteColor),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                kH16sizedBox,
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH16sizedBox,
                Stack(
                  children: [
                    Image.asset(
                      kiCastBackgroundPng,
                      width: width - 40,
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 20,
                      //  child: Container(
                      //    width: 100.w,
                      //    height: 100.h,
                      //    decoration:  BoxDecoration(
                      //      shape: BoxShape.circle,
                      //      border: Border.all(
                      //        width: 2,
                      //        color: cPrimaryColor2,
                      //      ),
                      //    ),
                      //    child: CircleAvatar(
                      //      backgroundColor: cWhiteColor.withOpacity(0.2),
                      //      child: ClipOval(
                      //        child: Image.network(
                      //          "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
                      //          width: 96.w,
                      //          height: 95.h,
                      //          fit: BoxFit.cover,
                      //        ),
                      //      ),
                      //    ),
                      //  ),
                      child: Center(
                        child: Container(
                          width: 96.w,
                          height: 96.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: cPrimaryColor2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: cPrimaryColor2,
                            child: ClipOval(
                              child: Image.network(
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                "https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
                                // loadingBuilder: imageLoadingBuilder,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 100,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      // bottom: 0,
                      left: width * 0.34,
                      // right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Melica Anderson",
                            style: semiBold24TextStyle(cWhiteColor),
                          ),
                          // kH6sizedBox,
                          Text(
                            "Actress / Hollywood",
                            style: regular16TextStyle(
                              cWhiteColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                kH16sizedBox,
                Text(ksCastDetails.tr, style: medium16TextStyle(cWhiteColor)),
                kH12sizedBox,
                // Container(
                //   width: width-40,
                //   height: 46.h,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100.r),
                //     color: cWhiteColor.withOpacity(0.1),
                //   ),
                // ),
                Container(
                  width: width - 40,
                  height: 46.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                        List.generate(homeController.tabs.length, (index) {
                      return GestureDetector(
                        onTap: () => homeController.changeTab(index),
                        child: Obx(() => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color:
                                    homeController.selectedIndex.value == index
                                        ? Colors.grey[800]
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: Text(
                                homeController.tabs[index],
                                style: regular14TextStyle(cWhiteColor),
                              ),
                            )),
                      );
                    }),
                  ),
                ),
                kH16sizedBox,
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH16sizedBox,
                if (homeController.selectedIndex.value == 0)
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: homeController.recentMovieList.length,
                    itemBuilder: (context, index) {
                      return MovieContentContainer(
                        movieImage: homeController.recentMovieList[index]
                            ["movieImage"],
                        seasonName: homeController.recentMovieList[index]
                            ["season"],
                        isPremium: homeController.recentMovieList[index]
                            ["isPremium"],
                        isSeason: homeController.recentMovieList[index]
                            ["isSeason"],
                      );
                    },
                  ),
                if (homeController.selectedIndex.value == 1)
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: homeController.castGalleryList.length,
                    itemBuilder: (context, index) {
                      return CommonImageWidget(
                        image: homeController.castGalleryList[index],
                      );
                    },
                  ),
                if (homeController.selectedIndex.value == 2)
                  Container(
                    width: width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(k8BorderRadius),
                      color: cWhiteColor.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(k20Padding),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${ksFullName.tr}: ",
                                style: regular16TextStyle(
                                    cWhiteColor.withOpacity(0.7)),
                              ),
                              Text(
                                "Melica Anderson",
                                style: regular16TextStyle(cWhiteColor),
                              ),
                            ],
                          ),
                          kH16sizedBox,
                          Row(
                            children: [
                              Text(
                                "${ksCountry.tr}: ",
                                style: regular16TextStyle(
                                    cWhiteColor.withOpacity(0.7)),
                              ),
                              Text(
                                "United State",
                                style: regular16TextStyle(cWhiteColor),
                              ),
                            ],
                          ),
                          kH16sizedBox,
                          Row(
                            children: [
                              Text(
                                "${ksMovieBackground.tr}: ",
                                style: regular16TextStyle(
                                    cWhiteColor.withOpacity(0.7)),
                              ),
                              Text(
                                "Hollywood, Bollywood",
                                style: regular16TextStyle(cWhiteColor),
                              ),
                            ],
                          ),
                          kH16sizedBox,
                          Row(
                            children: [
                              Text(
                                "${ksBorn.tr}: ",
                                style: regular16TextStyle(
                                    cWhiteColor.withOpacity(0.7)),
                              ),
                              Text(
                                "1996",
                                style: regular16TextStyle(cWhiteColor),
                              ),
                            ],
                          ),
                          kH16sizedBox,
                          Row(
                            children: [
                              Text(
                                "${ksTotalMovies.tr}: ",
                                style: regular16TextStyle(
                                    cWhiteColor.withOpacity(0.7)),
                              ),
                              Text(
                                "120",
                                style: regular16TextStyle(cWhiteColor),
                              ),
                            ],
                          ),
                          kH16sizedBox,
                          Row(
                            children: [
                              Text(
                                "${ksGender.tr}: ",
                                style: regular16TextStyle(
                                    cWhiteColor.withOpacity(0.7)),
                              ),
                              Text(
                                "Female",
                                style: regular16TextStyle(cWhiteColor),
                              ),
                            ],
                          ),
                          kH16sizedBox,
                          Row(
                            children: [
                              Text(
                                "${ksRanking.tr}: ",
                                style: regular16TextStyle(
                                    cWhiteColor.withOpacity(0.7)),
                              ),
                              Text(
                                "Top Actress",
                                style: regular16TextStyle(cWhiteColor),
                              ),
                            ],
                          ),
//                           FlutterSlider(
//   values: [0, 100],
//   rangeSlider: true,
//   max: 500,
//   min: 0,
//   onDragging: (handlerIndex, lowerValue, upperValue) {
//     homeController.lowerValue.value = lowerValue;
//     homeController.upperValue.value = upperValue;
//   },
// ),
                        ],
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

class CommonImageWidget extends StatelessWidget {
  const CommonImageWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(k6BorderRadius),
      child: SizedBox(
        width: (width - 60) / 3,
        child: Image.network(
          image,
          fit: BoxFit.fill,
          width: (width - 60) / 3,
        ),
      ),
    );
  }
}
