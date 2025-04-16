import 'package:flick_video_player/flick_video_player.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/video_player/all_video_player_controller.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  VideoPlayerScreen({super.key});
  final AllVideoPlayerController allVideoPlayerController = Get.find<AllVideoPlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: Column(
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
        ],
      ),
    );
  }
}
