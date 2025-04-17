import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/gestures.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  VideoPlayerScreen({super.key});
  final AllVideoPlayerController allVideoPlayerController =
      Get.find<AllVideoPlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // YoutubePlayerBuilder(
          //   player: YoutubePlayer(
          //     controller: videoPlayerController.youtubeController,
          //     showVideoProgressIndicator: true,
          //     progressIndicatorColor: Colors.red,
          //   ),
          //   builder: (context, player) {
          //     return Column(
          //       children: [
          //         player,
          //         const SizedBox(height: 20),
          //         Text(
          //           'Now Playing...',
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         ),
          //       ],
          //     );
          //   },
          // ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FlickVideoPlayer(
              flickManager: allVideoPlayerController.flickManager,
            ),
          ),
          kH20sizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: cAmberColor,
                            size: kIconSize16,
                          ),
                          kW6sizedBox,
                          Text(
                            "4.6",
                            style: regular12TextStyle(cWhiteColor),
                          ),
                          kW6sizedBox,
                          SizedBox(
                            height: 22.h,
                            child: VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: cWhiteColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      kW6sizedBox,
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_filled_sharp,
                            color: cPrimaryColor2,
                            size: kIconSize20,
                          ),
                          kW6sizedBox,
                          Text(
                            "2 hr 30 mins",
                            style: regular12TextStyle(cWhiteColor),
                          ),
                          kW6sizedBox,
                          SizedBox(
                            height: 22.h,
                            child: VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: cWhiteColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      kW6sizedBox,
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: cPrimaryColor2,
                            size: kIconSize20,
                          ),
                          kW6sizedBox,
                          Text(
                            "2024",
                            style: regular12TextStyle(cWhiteColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kH16sizedBox,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      allVideoPlayerController.movieTypeList.length * 2 - 1,
                      (index) {
                        if (index.isOdd) return kW8sizedBox;
                        final itemIndex = index ~/ 2;
                        final movieType =
                            allVideoPlayerController.movieTypeList[itemIndex];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: cPrimaryColor2.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(k4BorderRadius),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: k4Padding,
                            vertical: k4Padding,
                          ),
                          child: Text(
                            movieType,
                            style: regular14TextStyle(cWhiteColor),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                kH16sizedBox,
                Text(
                  ksTitle,
                  style: regular14TextStyle(
                    cWhiteColor.withOpacity(0.5),
                  ),
                ),
                kH12sizedBox,
                Text(
                  "Seethamma Andalu Ramayya Sitralu - Tailor",
                  style: medium20TextStyle(cWhiteColor),
                ),
                kH12sizedBox,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Village boy Raju's heart belongs to his childhood sweetheart, Mita. When she leaves for the city and rejects his love, Raju sets out on a mission to win not just her heart. ",
                        style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),
                      ),
                      TextSpan(
                        text: "Read More",
                        style: regular14TextStyle(cWhiteColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            ll('Read More tapped');
                          },
                      ),
                    ],
                  ),
                ),
                kH16sizedBox,
               const Row(
                  children: [
                    CommonContainer(image: kiCrown,),
                    kW10sizedBox,
                    CommonContainer(image: kiFavorite,),
                    kW10sizedBox,
                    CommonContainer(image: kiAdd,),
                    kW10sizedBox,
                    CommonContainer(image: kiDownload,),
                    kW10sizedBox,
                    CommonContainer(image: kiShare,),
                  ],
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonContainer extends StatelessWidget {
  const CommonContainer({super.key, required this.image});
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
