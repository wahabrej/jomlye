import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';

class LiveTvPlayerScreen extends StatelessWidget {
 LiveTvPlayerScreen({super.key});
 final AllVideoPlayerController allVideoPLayerController = Get.find<AllVideoPlayerController>();
 final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Column(
          children: [
            kH60sizedBox,
            YoYoPlayer(
      aspectRatio: 16 / 9,
      // url: homeController.liveTvDetailsData.value?.streamUrl??"",
      url: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
      videoStyle: VideoStyle(),
      videoLoadingStyle: VideoLoadingStyle(),
    )
          ],
        ),
      ),
    );
  }
}