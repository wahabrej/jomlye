import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';

class LiveTvPlayerScreen extends StatelessWidget {
 LiveTvPlayerScreen({super.key,this.liveTvUrl});
 final AllVideoPlayerController allVideoPLayerController = Get.find<AllVideoPlayerController>();
 final HomeController homeController = Get.find<HomeController>();
 final String? liveTvUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                kH30sizedBox,
                // SizedBox(
                //   width: width,
                //   child: YoYoPlayer(
                //   // aspectRatio: 16 / 9,
                //   // url: homeController.liveTvDetailsData.value?.streamUrl??"",
                //   // url: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
                //   url: liveTvUrl??"",
                //   videoStyle: const VideoStyle(),
                //   videoLoadingStyle: const VideoLoadingStyle(),
                //       ),
                // ),
          kH20sizedBox,
          Row(
            children: [
              Container(
                width: 50.w,
                height: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  color: cPrimaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: cGreyBoxColor2,
                        shape: BoxShape.circle,
                      ),
                    ),
                    kW4sizedBox,
                    Center(child: Text(ksLive.tr,style: regular14TextStyle(cWhiteColor),)),
                  ],
                ),
              ),
              const Spacer(),
              Text(homeController.liveTvDetailsData.value?.stream1?.quality??"",style: regular14TextStyle(cWhiteColor),),
            ],
          ),
          kH16sizedBox,
          Text(ksChannelName.tr,style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),),
            ],
          ),
        ),
      ),
    );
  }
}