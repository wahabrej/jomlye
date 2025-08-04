// // import 'package:flick_video_player/flick_video_player.dart';
// // import 'package:flutter_media_downloader/flutter_media_downloader.dart';
// // import 'package:vidflix_flutter_app/utils/constants/imports.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// // class AllVideoPlayerController extends GetxController {
// //   late YoutubePlayerController youtubeController;

// //   final RxString videoUrl = RxString('https://www.youtube.com/watch?v=K18cpp_-gP8');

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     final videoId = YoutubePlayer.convertUrlToId(videoUrl.value);
// //     youtubeController = YoutubePlayerController(
// //       initialVideoId: videoId ?? '',
// //       flags: const YoutubePlayerFlags(
// //         autoPlay: true,
// //         mute: false,
// //       ),
// //     );
// //   }

// //   @override
// //   void onClose() {
// //     youtubeController.dispose();
// //     super.onClose();
// //   }

// //   late FlickManager flickManager;
// //   final RxList movieTypeList = RxList([
// //   "HD","Action", "Super Hit", "Block Buster"
// //   ]);

// //   final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();
// // }

// // import 'package:better_player_plus/better_player_plus.dart';
// // import 'package:flick_video_player/flick_video_player.dart';
// // import 'package:flutter_media_downloader/flutter_media_downloader.dart';
// // import 'package:vidflix_flutter_app/utils/constants/imports.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// // class AllVideoPlayerController extends GetxController {
// //   late FlickManager flickManager;
// //   late YoutubePlayerController youtubeController;
// //   late BetterPlayerPlaylistController playlistController;

// //   final RxString videoUrl = RxString('https://www.youtube.com/watch?v=K18cpp_-gP8');
// //   final RxBool isMidRollAdPlaying = RxBool(false);

// //   // Ad URLs - using your first code's static URLs
// //   final String preRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
// //   final String postRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4";
// //   final List<Map<String, dynamic>> midRollAds = [
// //     {"time": 15, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4", "shown": false},
// //     {"time": 30, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4", "shown": false},
// //   ];

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     final videoId = YoutubePlayer.convertUrlToId(videoUrl.value);
// //     youtubeController = YoutubePlayerController(
// //       initialVideoId: videoId ?? '',
// //       flags: const YoutubePlayerFlags(
// //         autoPlay: false,
// //         mute: false,
// //       ),
// //     );
// //   }

// //   void setupBetterPlayerWithAds(String mainContentUrl) {
// //     // Reset mid-roll ad states
// //     for (var ad in midRollAds) {
// //       ad["shown"] = false;
// //     }
// //     isMidRollAdPlaying.value = false;

// //     final List<BetterPlayerDataSource> playlist = [
// //       BetterPlayerDataSource(
// //         BetterPlayerDataSourceType.network,
// //         preRollAdUrl,
// //         cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
// //       ),
// //       BetterPlayerDataSource(
// //         BetterPlayerDataSourceType.network,
// //         mainContentUrl,
// //         cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
// //       ),
// //       BetterPlayerDataSource(
// //         BetterPlayerDataSourceType.network,
// //         postRollAdUrl,
// //         cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
// //       ),
// //     ];

// //     playlistController = BetterPlayerPlaylistController(
// //       playlist,
// //       betterPlayerConfiguration: const BetterPlayerConfiguration(
// //         autoPlay: true,
// //         controlsConfiguration: BetterPlayerControlsConfiguration(
// //           showControls: true,
// //           enableSkips: false,
// //           enableProgressText: true,
// //         ),
// //       ),
// //       betterPlayerPlaylistConfiguration: const BetterPlayerPlaylistConfiguration(
// //         loopVideos: false,
// //       ),
// //     );

// //     // Setup mid-roll ads after controller is initialized
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _setupMidRollAds();
// //     });
// //   }

// //   void _setupMidRollAds() {
// //     playlistController.betterPlayerController?.addEventsListener((event) {
// //       if (isMidRollAdPlaying.value) return;

// //       if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
// //         final currentPos = event.parameters!['progress'] ~/ 1000; // Current position in seconds

// //         for (final ad in midRollAds) {
// //           if (currentPos >= ad["time"] && !ad["shown"]) {
// //             ad["shown"] = true;
// //             _playMidRollAd(ad["url"]);
// //             break; // Only trigger one ad at a time
// //           }
// //         }
// //       }
// //     });
// //   }

// //   void _playMidRollAd(String adUrl) {
// //     isMidRollAdPlaying.value = true;
// //     playlistController.betterPlayerController?.pause();

// //     showDialog(
// //       context: Get.context!,
// //       barrierDismissible: false,
// //       builder: (context) => AlertDialog(
// //         title: const Text("Advertisement"),
// //         content: SizedBox(
// //           width: MediaQuery.of(context).size.width * 0.8,
// //           height: 200,
// //           child: BetterPlayer(
// //             controller: BetterPlayerController(
// //               const BetterPlayerConfiguration(
// //                 autoPlay: true,
// //                 controlsConfiguration: BetterPlayerControlsConfiguration(
// //                   showControls: true,
// //                   enableSkips: true,
// //                 ),
// //               ),
// //               betterPlayerDataSource: BetterPlayerDataSource(
// //                 BetterPlayerDataSourceType.network,
// //                 adUrl,
// //               ),
// //             ),
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.pop(context);
// //               isMidRollAdPlaying.value = false;
// //               playlistController.betterPlayerController?.play();
// //             },
// //             child: const Text("Close"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   final RxList movieTypeList = RxList([
// //     "HD", "Action", "Super Hit", "Block Buster"
// //   ]);

// //   final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();

// //   @override
// //   void onClose() {
// //     youtubeController.dispose();
// //     playlistController.dispose();
// //     super.onClose();
// //   }
// // }

// import 'package:better_player_plus/better_player_plus.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter_media_downloader/flutter_media_downloader.dart';
// import 'package:vidflix_flutter_app/utils/constants/imports.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class AllVideoPlayerController extends GetxController {
//   late FlickManager flickManager;
//   late YoutubePlayerController youtubeController;
//   BetterPlayerController? betterPlayerController;
//   BetterPlayerPlaylistController? playlistController;

//   final RxString videoUrl = RxString('https://www.youtube.com/watch?v=K18cpp_-gP8');
//   final RxBool isMidRollAdPlaying = RxBool(false);

//   // Ad URLs
//   final String preRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
//   final String postRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4";
//   final List<Map<String, dynamic>> midRollAds = [
//     {"time": 15, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4", "shown": false},
//     {"time": 30, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4", "shown": false},
//   ];

//   @override
//   void onInit() {
//     super.onInit();
//     _initializeYouTubeController();
//   }

//   void _initializeYouTubeController() {
//     final videoId = YoutubePlayer.convertUrlToId(videoUrl.value);
//     youtubeController = YoutubePlayerController(
//       initialVideoId: videoId ?? '',
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ),
//     );
//   }

//   // Initialize Better Player with ads
//   Future<void> initializeBetterPlayerWithAds(String mainContentUrl) async {
//     try {
//       // Dispose existing controller if any
//       await _disposeBetterPlayer();
      
//       // Reset mid-roll ad states
//       for (var ad in midRollAds) {
//         ad["shown"] = false;
//       }
//       isMidRollAdPlaying.value = false;

//       // Create playlist data sources
//       final List<BetterPlayerDataSource> playlist = [
//         BetterPlayerDataSource(
//           BetterPlayerDataSourceType.network,
//           preRollAdUrl,
//           cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
//         ),
//         BetterPlayerDataSource(
//           BetterPlayerDataSourceType.network,
//           mainContentUrl,
//           cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
//         ),
//         BetterPlayerDataSource(
//           BetterPlayerDataSourceType.network,
//           postRollAdUrl,
//           cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
//         ),
//       ];

//       // Initialize playlist controller
//       playlistController = BetterPlayerPlaylistController(
//         playlist,
//         betterPlayerConfiguration: const BetterPlayerConfiguration(
//           autoPlay: true,
//           aspectRatio: 16/9,
//           fit: BoxFit.contain,
//           controlsConfiguration: BetterPlayerControlsConfiguration(
//             showControls: true,
//             enableSkips: false,
//             enableProgressText: true,
//             enableMute: true,
//             enableFullscreen: true,
//           ),
//         ),
//         betterPlayerPlaylistConfiguration: const BetterPlayerPlaylistConfiguration(
//           loopVideos: false,
//           nextVideoDelay: Duration(seconds: 1),
//         ),
//       );

//       // Wait for controller to be ready
//       await Future.delayed(const Duration(milliseconds: 500));
      
//       // Setup mid-roll ads
//       _setupMidRollAds();
      
//     } catch (e) {
//       print('Error initializing Better Player: $e');
//     }
//   }

//   void _setupMidRollAds() {
//     if (playlistController?.betterPlayerController == null) return;

//     playlistController!.betterPlayerController!.addEventsListener((event) {
//       if (isMidRollAdPlaying.value) return;

//       if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
//         final progress = event.parameters?['progress'];
//         if (progress == null) return;
        
//         final currentPos = (progress as Duration).inSeconds;

//         for (final ad in midRollAds) {
//           if (currentPos >= ad["time"] && !ad["shown"]) {
//             ad["shown"] = true;
//             _playMidRollAd(ad["url"]);
//             break;
//           }
//         }
//       }
//     });
//   }

//   String generateGoogleDriveDirectUrl(String sharedUrl, String apiKey) {
//   final regExp = RegExp(r'd/([a-zA-Z0-9_-]+)');
//   final match = regExp.firstMatch(sharedUrl);
//   if (match != null && match.groupCount > 0) {
//     final fileId = match.group(1);
//     // Construct direct API URL for downloading video file
//     return "https://www.googleapis.com/drive/v3/files/$fileId?alt=media&key=$apiKey";
//   }
//   return sharedUrl; // fallback: original URL (in case it's not a Google Drive link)
// }


//   void _playMidRollAd(String adUrl) {
//     if (Get.context == null) return;
    
//     isMidRollAdPlaying.value = true;
//     playlistController?.betterPlayerController?.pause();

//     BetterPlayerController? adController;

//     showDialog(
//       context: Get.context!,
//       barrierDismissible: false,
//       builder: (context) {
//         adController = BetterPlayerController(
//           const BetterPlayerConfiguration(
//             autoPlay: true,
//             aspectRatio: 16/9,
//             controlsConfiguration: BetterPlayerControlsConfiguration(
//               showControls: true,
//               enableSkips: true,
//               enableFullscreen: false,
//             ),
//           ),
//           betterPlayerDataSource: BetterPlayerDataSource(
//             BetterPlayerDataSourceType.network,
//             adUrl,
//             cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
//           ),
//         );

//         return AlertDialog(
//           title: const Text("Advertisement"),
//           content: SizedBox(
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: 200,
//             child: BetterPlayer(controller: adController!),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 adController?.dispose();
//                 Navigator.pop(context);
//                 isMidRollAdPlaying.value = false;
//                 playlistController?.betterPlayerController?.play();
//               },
//               child: const Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _disposeBetterPlayer() async {
//     try {
//       betterPlayerController?.dispose();
//       playlistController?.dispose();
//       betterPlayerController = null;
//       playlistController = null;
//     } catch (e) {
//       print('Error disposing Better Player: $e');
//     }
//   }

//   final RxList movieTypeList = RxList([
//     "HD", "Action", "Super Hit", "Block Buster"
//   ]);

//   final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();

//   @override
//   void onClose() {
//     youtubeController.dispose();
//     _disposeBetterPlayer();
//     super.onClose();
//   }
// }

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:video_player/video_player.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AllVideoPlayerController extends GetxController {
  late FlickManager flickManager;
  late YoutubePlayerController youtubeController;
  VideoPlayerController? videoController;
  RxBool isInitialized = false.obs;
   //!for video player
  // void initVideo(String url) async {
  //   videoController = VideoPlayerController.network(url);
  //   await videoController!.initialize();
  //   isInitialized.value = true;
  //   update();
  // }
  
  // @override
  // void onClose() {
  //   videoController?.dispose();
  //   super.onClose();
  // }

  final RxString videoUrl = RxString('https://www.youtube.com/watch?v=K18cpp_-gP8');
  final RxBool isMidRollAdPlaying = RxBool(false);
  final RxBool isPlayerInitialized = RxBool(false);
  final RxBool isInitializing = RxBool(false);

  // Ad URLs
  final String preRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
  final String postRollAdUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4";
  final List<Map<String, dynamic>> midRollAds = [
    {"time": 15, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4", "shown": false},
    {"time": 30, "url": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4", "shown": false},
  ];

  // Store the current main content URL to avoid re-initialization
  String? currentMainContentUrl;

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

  // // Initialize Better Player Plus with ads - only if URL changed
  // Future<void> initializeBetterPlayerWithAds(String mainContentUrl) async {
  //   // Check if already initialized with the same URL
  //   if (isPlayerInitialized.value && currentMainContentUrl == mainContentUrl) {
  //     return;
  //   }

  //   // Prevent multiple simultaneous initializations
  //   if (isInitializing.value) {
  //     return;
  //   }

  //   try {
  //     isInitializing.value = true;
      
  //     // Dispose existing controller if any
  //     await _disposeBetterPlayer();
      
  //     // Reset states
  //     for (var ad in midRollAds) {
  //       ad["shown"] = false;
  //     }
  //     isMidRollAdPlaying.value = false;
  //     isPlayerInitialized.value = false;

  //     // Store current URL
  //     currentMainContentUrl = mainContentUrl;

  //     // Create playlist data sources
  //     final List<BetterPlayerDataSource> playlist = [
  //       BetterPlayerDataSource(
  //         BetterPlayerDataSourceType.network,
  //         preRollAdUrl,
  //         cacheConfiguration: const BetterPlayerCacheConfiguration(
  //           useCache: true,
  //           preCacheSize: 10 * 1024 * 1024,
  //           maxCacheSize: 100 * 1024 * 1024,
  //         ),
  //       ),
  //       BetterPlayerDataSource(
  //         BetterPlayerDataSourceType.network,
  //         mainContentUrl,
  //         cacheConfiguration: const BetterPlayerCacheConfiguration(
  //           useCache: true,
  //           preCacheSize: 20 * 1024 * 1024,
  //           maxCacheSize: 200 * 1024 * 1024,
  //         ),
  //         videoFormat: BetterPlayerVideoFormat.other,
  //       ),
  //       BetterPlayerDataSource(
  //         BetterPlayerDataSourceType.network,
  //         postRollAdUrl,
  //         cacheConfiguration: const BetterPlayerCacheConfiguration(
  //           useCache: true,
  //           preCacheSize: 10 * 1024 * 1024,
  //           maxCacheSize: 100 * 1024 * 1024,
  //         ),
  //       ),
  //     ];

  //     // Initialize playlist controller
  //     playlistController = BetterPlayerPlaylistController(
  //       playlist,
  //       betterPlayerConfiguration: BetterPlayerConfiguration(
  //         autoPlay: true,
  //         aspectRatio: 16/9,
  //         fit: BoxFit.contain,
  //         autoDispose: false,
  //         startAt: Duration.zero,
  //         controlsConfiguration: const BetterPlayerControlsConfiguration(
  //           showControls: true,
  //           enableSkips: false,
  //           enableProgressText: true,
  //           enableMute: true,
  //           enableFullscreen: true,
  //           enablePlaybackSpeed: true,
  //           controlsHideTime: Duration(seconds: 3),
  //           enableOverflowMenu: true,
  //         ),
  //         eventListener: _onBetterPlayerEvent,
  //       ),
  //       betterPlayerPlaylistConfiguration: const BetterPlayerPlaylistConfiguration(
  //         loopVideos: false,
  //         nextVideoDelay: Duration(seconds: 1),
  //       ),
  //     );

  //     // Wait for controller to be ready
  //     await Future.delayed(const Duration(milliseconds: 800));
      
  //     // Setup mid-roll ads
  //     _setupMidRollAds();
      
  //     isPlayerInitialized.value = true;
      
  //   } catch (e) {
  //     print('Error initializing Better Player Plus: $e');
  //     isPlayerInitialized.value = false;
  //   } finally {
  //     isInitializing.value = false;
  //   }
  // }

  // void _onBetterPlayerEvent(BetterPlayerEvent event) {
  //   if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
  //     // Reset position when video initializes
  //     Future.delayed(const Duration(milliseconds: 100), () {
  //       playlistController?.betterPlayerController?.seekTo(Duration.zero);
  //     });
  //   }
  // }

  // void _setupMidRollAds() {
  //   if (playlistController?.betterPlayerController == null) return;

  //   playlistController!.betterPlayerController!.addEventsListener((event) {
  //     if (isMidRollAdPlaying.value) return;

  //     if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
  //       final progress = event.parameters?['progress'];
  //       if (progress == null) return;
        
  //       final currentPos = (progress as Duration).inSeconds;
  //       final currentDataSource = playlistController?.betterPlayerController?.betterPlayerDataSource;
        
  //       // Only trigger mid-roll ads for main content (second item in playlist)
  //       if (currentDataSource?.url == currentMainContentUrl) {
  //         for (final ad in midRollAds) {
  //           if (currentPos >= ad["time"] && !ad["shown"]) {
  //             ad["shown"] = true;
  //             _playMidRollAd(ad["url"]);
  //             break;
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  
  
  final RxString finalUrl = RxString("");

  Future<void> parseVideoUrl({required String fileUrl,required String fileSource}) async {
          final apiKey = Get.find<GlobalController>().googleDriveApiKey;
           finalUrl.value = "";
          if (fileSource == "gdrive") {
          finalUrl.value =await generateGoogleDriveDirectUrl(fileUrl, apiKey.value);
          } else {
            finalUrl.value = fileUrl;
          }
  }

  Future<String> generateGoogleDriveDirectUrl(String sharedUrl, String apiKey) async{
    final regExp = RegExp(r'd/([a-zA-Z0-9_-]+)');
    final match = regExp.firstMatch(sharedUrl);
    if (match != null && match.groupCount > 0) {
      final fileId = match.group(1);
      // Construct direct API URL for downloading video file
      return "https://www.googleapis.com/drive/v3/files/$fileId?alt=media&key=$apiKey";
    }
    return sharedUrl; // fallback: original URL (in case it's not a Google Drive link)
  }

  // void _playMidRollAd(String adUrl) {
  //   if (Get.context == null) return;
    
  //   isMidRollAdPlaying.value = true;
    // playlistController?.betterPlayerController?.pause();

    // BetterPlayerController? adController;

  //   showDialog(
  //     context: Get.context!,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       adController = BetterPlayerController(
  //         BetterPlayerConfiguration(
  //           autoPlay: true,
  //           aspectRatio: 16/9,
  //           fit: BoxFit.contain,
  //           controlsConfiguration: const BetterPlayerControlsConfiguration(
  //             showControls: true,
  //             enableSkips: true,
  //             enableFullscreen: false,
  //             controlsHideTime: Duration(seconds: 2),
  //           ),
  //         ),
  //         betterPlayerDataSource: BetterPlayerDataSource(
  //           BetterPlayerDataSourceType.network,
  //           adUrl,
  //           cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
  //         ),
  //       );

  //       return AlertDialog(
  //         title: const Text("Advertisement"),
  //         content: SizedBox(
  //           width: MediaQuery.of(context).size.width * 0.8,
  //           height: 200,
  //           child: BetterPlayer(controller: adController!),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               adController?.dispose();
  //               Navigator.pop(context);
  //               isMidRollAdPlaying.value = false;
  //               playlistController?.betterPlayerController?.play();
  //             },
  //             child: const Text("Close"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<void> _disposeBetterPlayer() async {
  //   try {
  //     betterPlayerController?.dispose();
  //     playlistController?.dispose();
  //     betterPlayerController = null;
  //     playlistController = null;
  //     isPlayerInitialized.value = false;
  //     currentMainContentUrl = null;
  //   } catch (e) {
  //     print('Error disposing Better Player Plus: $e');
  //   }
  // }

  // Method to reset player for new content
  // void resetPlayer() {
  //   _disposeBetterPlayer();
  // }

  // @override
  // void onClose() {
  //   youtubeController.dispose();
  //   _disposeBetterPlayer();
  //   videoController?.dispose();
  //   super.onClose();
  // }
  // }

  final RxList movieTypeList = RxList([
    "HD", "Action", "Super Hit", "Block Buster"
  ]);

  final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();

BetterPlayerController? betterPlayerController;
  RxBool isBetterPlayerInitialized = false.obs;
  RxBool isPlaying = false.obs;
  RxBool hasError = false.obs;
  
  void initBetterPlayerVideo(String videoUrl) async {
    try {
      hasError.value = false;
      
      // Dispose previous controller if exists
      if (betterPlayerController != null) {
        betterPlayerController!.dispose();
      }
      
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoUrl,
      );
      
      BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: false,
        looping: false,
        allowedScreenSleep: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          enableMute: true,
          enableFullscreen: true,
          enableProgressText: true,
          enableProgressBar: true,
          showControls: true,
        ),
      );
      
      betterPlayerController = BetterPlayerController(
        betterPlayerConfiguration,
        betterPlayerDataSource: betterPlayerDataSource,
      );
      
      // Add listeners
      betterPlayerController!.addEventsListener(_onPlayerEvent);
      
      isInitialized.value = true;
      
    } catch (e) {
      hasError.value = true;
      print('Video initialization error: $e');
    }
  }
  
  void _onPlayerEvent(BetterPlayerEvent event) {
    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.play:
        isPlaying.value = true;
        break;
      case BetterPlayerEventType.pause:
        isPlaying.value = false;
        break;
      case BetterPlayerEventType.exception:
        hasError.value = true;
        break;
      default:
        break;
    }
  }
  
  void play() {
    betterPlayerController?.play();
  }
  
  void pause() {
    betterPlayerController?.pause();
  }
  
  void togglePlayPause() {
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }
  
  @override
  void onClose() {
    betterPlayerController?.dispose();
    super.onClose();
  }

}