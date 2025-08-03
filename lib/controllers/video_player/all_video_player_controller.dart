// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter_media_downloader/flutter_media_downloader.dart';
// import 'package:vidflix_flutter_app/utils/constants/imports.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class AllVideoPlayerController extends GetxController {
//   late YoutubePlayerController youtubeController;

//   final RxString videoUrl = RxString('https://www.youtube.com/watch?v=K18cpp_-gP8');

//   @override
//   void onInit() {
//     super.onInit();
//     final videoId = YoutubePlayer.convertUrlToId(videoUrl.value);
//     youtubeController = YoutubePlayerController(
//       initialVideoId: videoId ?? '',
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );
//   }

//   @override
//   void onClose() {
//     youtubeController.dispose();
//     super.onClose();
//   }

//   late FlickManager flickManager;
//   final RxList movieTypeList = RxList([
//   "HD","Action", "Super Hit", "Block Buster"
//   ]);

//   final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();
// }

// import 'package:better_player_plus/better_player_plus.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter_media_downloader/flutter_media_downloader.dart';
// import 'package:vidflix_flutter_app/utils/constants/imports.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class AllVideoPlayerController extends GetxController {
//   late FlickManager flickManager;
//   late YoutubePlayerController youtubeController;
//   late BetterPlayerPlaylistController playlistController;

//   final RxString videoUrl = RxString('https://www.youtube.com/watch?v=K18cpp_-gP8');
//   final RxBool isMidRollAdPlaying = RxBool(false);

//   // Ad URLs - using your first code's static URLs
//   final String preRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
//   final String postRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4";
//   final List<Map<String, dynamic>> midRollAds = [
//     {"time": 15, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4", "shown": false},
//     {"time": 30, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4", "shown": false},
//   ];

//   @override
//   void onInit() {
//     super.onInit();
//     final videoId = YoutubePlayer.convertUrlToId(videoUrl.value);
//     youtubeController = YoutubePlayerController(
//       initialVideoId: videoId ?? '',
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ),
//     );
//   }

//   void setupBetterPlayerWithAds(String mainContentUrl) {
//     // Reset mid-roll ad states
//     for (var ad in midRollAds) {
//       ad["shown"] = false;
//     }
//     isMidRollAdPlaying.value = false;

//     final List<BetterPlayerDataSource> playlist = [
//       BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         preRollAdUrl,
//         cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
//       ),
//       BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         mainContentUrl,
//         cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
//       ),
//       BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         postRollAdUrl,
//         cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
//       ),
//     ];

//     playlistController = BetterPlayerPlaylistController(
//       playlist,
//       betterPlayerConfiguration: const BetterPlayerConfiguration(
//         autoPlay: true,
//         controlsConfiguration: BetterPlayerControlsConfiguration(
//           showControls: true,
//           enableSkips: false,
//           enableProgressText: true,
//         ),
//       ),
//       betterPlayerPlaylistConfiguration: const BetterPlayerPlaylistConfiguration(
//         loopVideos: false,
//       ),
//     );

//     // Setup mid-roll ads after controller is initialized
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _setupMidRollAds();
//     });
//   }

//   void _setupMidRollAds() {
//     playlistController.betterPlayerController?.addEventsListener((event) {
//       if (isMidRollAdPlaying.value) return;

//       if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
//         final currentPos = event.parameters!['progress'] ~/ 1000; // Current position in seconds

//         for (final ad in midRollAds) {
//           if (currentPos >= ad["time"] && !ad["shown"]) {
//             ad["shown"] = true;
//             _playMidRollAd(ad["url"]);
//             break; // Only trigger one ad at a time
//           }
//         }
//       }
//     });
//   }

//   void _playMidRollAd(String adUrl) {
//     isMidRollAdPlaying.value = true;
//     playlistController.betterPlayerController?.pause();

//     showDialog(
//       context: Get.context!,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Text("Advertisement"),
//         content: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.8,
//           height: 200,
//           child: BetterPlayer(
//             controller: BetterPlayerController(
//               const BetterPlayerConfiguration(
//                 autoPlay: true,
//                 controlsConfiguration: BetterPlayerControlsConfiguration(
//                   showControls: true,
//                   enableSkips: true,
//                 ),
//               ),
//               betterPlayerDataSource: BetterPlayerDataSource(
//                 BetterPlayerDataSourceType.network,
//                 adUrl,
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               isMidRollAdPlaying.value = false;
//               playlistController.betterPlayerController?.play();
//             },
//             child: const Text("Close"),
//           ),
//         ],
//       ),
//     );
//   }

//   final RxList movieTypeList = RxList([
//     "HD", "Action", "Super Hit", "Block Buster"
//   ]);

//   final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();

//   @override
//   void onClose() {
//     youtubeController.dispose();
//     playlistController.dispose();
//     super.onClose();
//   }
// }

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AllVideoPlayerController extends GetxController {
  late FlickManager flickManager;
  late YoutubePlayerController youtubeController;
  BetterPlayerController? betterPlayerController;
  BetterPlayerPlaylistController? playlistController;

  final RxString videoUrl = RxString('https://www.youtube.com/watch?v=K18cpp_-gP8');
  final RxBool isMidRollAdPlaying = RxBool(false);

  // Ad URLs
  final String preRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
  final String postRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4";
  final List<Map<String, dynamic>> midRollAds = [
    {"time": 15, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4", "shown": false},
    {"time": 30, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4", "shown": false},
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeYouTubeController();
  }

  void _initializeYouTubeController() {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl.value);
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  // Initialize Better Player with ads
  Future<void> initializeBetterPlayerWithAds(String mainContentUrl) async {
    try {
      // Dispose existing controller if any
      await _disposeBetterPlayer();
      
      // Reset mid-roll ad states
      for (var ad in midRollAds) {
        ad["shown"] = false;
      }
      isMidRollAdPlaying.value = false;

      // Create playlist data sources
      final List<BetterPlayerDataSource> playlist = [
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          preRollAdUrl,
          cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
        ),
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          mainContentUrl,
          cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
        ),
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          postRollAdUrl,
          cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
        ),
      ];

      // Initialize playlist controller
      playlistController = BetterPlayerPlaylistController(
        playlist,
        betterPlayerConfiguration: const BetterPlayerConfiguration(
          autoPlay: true,
          aspectRatio: 16/9,
          fit: BoxFit.contain,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            showControls: true,
            enableSkips: false,
            enableProgressText: true,
            enableMute: true,
            enableFullscreen: true,
          ),
        ),
        betterPlayerPlaylistConfiguration: const BetterPlayerPlaylistConfiguration(
          loopVideos: false,
          nextVideoDelay: Duration(seconds: 1),
        ),
      );

      // Wait for controller to be ready
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Setup mid-roll ads
      _setupMidRollAds();
      
    } catch (e) {
      print('Error initializing Better Player: $e');
    }
  }

  void _setupMidRollAds() {
    if (playlistController?.betterPlayerController == null) return;

    playlistController!.betterPlayerController!.addEventsListener((event) {
      if (isMidRollAdPlaying.value) return;

      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        final progress = event.parameters?['progress'];
        if (progress == null) return;
        
        final currentPos = (progress as Duration).inSeconds;

        for (final ad in midRollAds) {
          if (currentPos >= ad["time"] && !ad["shown"]) {
            ad["shown"] = true;
            _playMidRollAd(ad["url"]);
            break;
          }
        }
      }
    });
  }

  String generateGoogleDriveDirectUrl(String sharedUrl, String apiKey) {
  final regExp = RegExp(r'd/([a-zA-Z0-9_-]+)');
  final match = regExp.firstMatch(sharedUrl);
  if (match != null && match.groupCount > 0) {
    final fileId = match.group(1);
    // Construct direct API URL for downloading video file
    return "https://www.googleapis.com/drive/v3/files/$fileId?alt=media&key=$apiKey";
  }
  return sharedUrl; // fallback: original URL (in case it's not a Google Drive link)
}


  void _playMidRollAd(String adUrl) {
    if (Get.context == null) return;
    
    isMidRollAdPlaying.value = true;
    playlistController?.betterPlayerController?.pause();

    BetterPlayerController? adController;

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        adController = BetterPlayerController(
          const BetterPlayerConfiguration(
            autoPlay: true,
            aspectRatio: 16/9,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              showControls: true,
              enableSkips: true,
              enableFullscreen: false,
            ),
          ),
          betterPlayerDataSource: BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            adUrl,
            cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
          ),
        );

        return AlertDialog(
          title: const Text("Advertisement"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 200,
            child: BetterPlayer(controller: adController!),
          ),
          actions: [
            TextButton(
              onPressed: () {
                adController?.dispose();
                Navigator.pop(context);
                isMidRollAdPlaying.value = false;
                playlistController?.betterPlayerController?.play();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _disposeBetterPlayer() async {
    try {
      betterPlayerController?.dispose();
      playlistController?.dispose();
      betterPlayerController = null;
      playlistController = null;
    } catch (e) {
      print('Error disposing Better Player: $e');
    }
  }

  final RxList movieTypeList = RxList([
    "HD", "Action", "Super Hit", "Block Buster"
  ]);

  final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();

  @override
  void onClose() {
    youtubeController.dispose();
    _disposeBetterPlayer();
    super.onClose();
  }
}