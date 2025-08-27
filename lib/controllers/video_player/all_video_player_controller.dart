
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:video_player/video_player.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AllVideoPlayerController extends GetxController {
  late FlickManager flickManager;
 late YoutubePlayerController youtubeController;
  VideoPlayerController? videoController;
  RxBool isInitialized = false.obs;

  final RxBool isMidRollAdPlaying = RxBool(false);
  final RxBool isPlayerInitialized = RxBool(false);
  final RxBool isInitializing = RxBool(false);

  // Store the current main content URL to avoid re-initialization
  String? currentMainContentUrl;

  @override
  void onInit() {
    super.onInit();
    _initializeYouTubeController(videoUrl: "https://www.youtube.com/watch?v=u6Xsayqxij0");
  }

  Future<void> _initializeYouTubeController({required String? videoUrl}) async{
    final videoId =  YoutubePlayer.convertUrlToId(videoUrl??"");
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

  Future<void> parseVideoUrl(
      {required String fileUrl, required String fileSource}) async {
    final apiKey = Get.find<GlobalController>().googleDriveApiKey;
    finalUrl.value = "";
    if (fileSource == "gdrive") {
      finalUrl.value =
          await generateGoogleDriveDirectUrl(fileUrl, apiKey.value);
    } else {
      finalUrl.value = fileUrl;
    }
  }

  Future<String> generateGoogleDriveDirectUrl(
      String sharedUrl, String apiKey) async {
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

  // final RxList movieTypeList =
  //     RxList(["HD", "Action", "Super Hit", "Block Buster"]);

  // final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();

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

      BetterPlayerConfiguration betterPlayerConfiguration =
          BetterPlayerConfiguration(
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
    youtubeController.dispose();
    flickManager.dispose();
    super.onClose();
  }
  final RxInt totalSeconds = RxInt(0); 
  final RxInt currentSeconds = RxInt(0); 
 //!video player function
    void videoPlayerFunction(
      {required bool? isFree,
      required bool? isRental,
      required bool? isRented,
      required bool? isSubscribed,
      required String? fileUrl,
      required String? fileSource,int? seekToPosition=0}) async{
    if ((isFree == false && isRental == true && isRented == true) ||
        (isFree == false &&
            isRented == false &&
            Get.find<GlobalController>().subscribedUserCheck.value==true) ||
        isFree == true) {
      if (fileSource == "youtube") {
        ll("here in youtube");
        final RxString videoUrl = RxString(fileUrl??"");
        // ll("in my youtube player controller loaded data $youtubeController");
       await _initializeYouTubeController(videoUrl: videoUrl.value);
                      youtubeController =
                                          YoutubePlayerController(
                                        initialVideoId: videoUrl.value,
                                        // initialVideoId: 'https://www.youtube.com/watch?v=u6Xsayqxij0',
                                        flags: const YoutubePlayerFlags(
                                          autoPlay: true,
                                          mute: false,
                                        ),
                                      );
      } else if (fileSource != "youtube" &&
          fileSource.toString().toLowerCase() != "gdrive") {
            ll("here in flickManager");
                                      // flickManager = FlickManager(
                                      //   videoPlayerController:
                                      //       VideoPlayerController.network(
                                      //           "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
                                      // );
                                      // flickManager = FlickManager(
                                      //   videoPlayerController:
                                      //       VideoPlayerController.network(
                                      //           fileUrl??"",
                                      //           ),
                                      // );
                                      flickManager = FlickManager(
  videoPlayerController: VideoPlayerController.network(fileUrl ?? "")
    ..initialize().then((_) {
      final seekSeconds = seekToPosition; 
      if (seekSeconds != null && seekSeconds > 0) {
        flickManager.flickVideoManager!.videoPlayerController
            !.seekTo(Duration(seconds: seekSeconds));
      }
      flickManager.flickVideoManager!.videoPlayerController?.addListener(() {
        final controller = flickManager.flickVideoManager!.videoPlayerController!;
        totalSeconds.value = controller.value.duration.inSeconds;
        currentSeconds.value = controller.value.position.inSeconds;
      });
    }),
    
);

          }
    }
  }
  //   int? seekPositionInSeconds;
  
  // void videoPlayerFunction({
  //   required bool? isFree,
  //   required bool? isRental,
  //   required bool? isRented,
  //   required bool? isSubscribed,
  //   required String? fileUrl,
  //   required String? fileSource,
  //   int? seekPosition=10, // Add this parameter
  // }) async {
  //   // Store the seek position
  //   seekPositionInSeconds = seekPosition;
    
  //   if ((isFree == false && isRental == true && isRented == true) ||
  //       (isFree == false &&
  //           isRented == false &&
  //           Get.find<GlobalController>().subscribedUserCheck.value == true) ||
  //       isFree == true) {
      
  //     if (fileSource == "youtube") {
  //       final RxString videoUrl = RxString(fileUrl ?? "");
  //       await _initializeYouTubeController(videoUrl: videoUrl.value);
        
  //       youtubeController = YoutubePlayerController(
  //         initialVideoId: videoUrl.value,
  //         flags: const YoutubePlayerFlags(
  //           autoPlay: true,
  //           mute: false,
  //         ),
  //       );
        
  //       // Seek to position for YouTube after initialization
  //       if (seekPositionInSeconds != null) {
  //         _seekToPosition();
  //       }
        
  //     } else if (fileSource != "youtube" &&
  //         fileSource.toString().toLowerCase() != "gdrive") {
        
  //       flickManager = FlickManager(
  //         videoPlayerController: VideoPlayerController.network(fileUrl ?? ""),
  //       );
        
  //       // Seek to position for regular video after initialization
  //       if (seekPositionInSeconds != null) {
  //         _seekToPositionFlick(fileUrl??"");
  //       }
  //     }
  //   }
  // }
  
  // // Method to seek YouTube player
  // void _seekToPosition() {
  //   if (youtubeController != null && seekPositionInSeconds != null) {
  //     youtubeController!.seekTo(Duration(seconds: seekPositionInSeconds!));
  //   }
  // }
  
  // // Method to seek Flick player
  // void _seekToPositionFlick(String fileUrl) async {
  //   if (flickManager.flickControlManager != null && seekPositionInSeconds != null) {
    
  //     // Wait for the video to be initialized
  //     // await flickManager!.flickControlManager!.initialize();
  //     flickManager.flickControlManager!.seekTo(Duration(seconds: seekPositionInSeconds!));
  //        flickManager = FlickManager(
  //         videoPlayerController: VideoPlayerController.network(fileUrl ?? ""),
  //       );
  //         ll("Here in seek $seekPositionInSeconds");
  //   }
  // }


}
