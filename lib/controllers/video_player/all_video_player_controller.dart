import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AllVideoPlayerController extends GetxController {
  late YoutubePlayerController youtubeController;

  final String videoUrl = 'https://www.youtube.com/watch?v=K18cpp_-gP8';

  @override
  void onInit() {
    super.onInit();
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void onClose() {
    youtubeController.dispose();
    super.onClose();
  }

  late FlickManager flickManager;
}
