
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:video_player/video_player.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/models/subtitle_model.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AllVideoPlayerController extends GetxController {
  late FlickManager flickManager;
  late YoutubePlayerController youtubeController;
  VideoPlayerController? videoController;
  RxBool isInitialized = false.obs;

  /// True once [flickManager] has been created at least once. Guards against
  /// touching a `late` field that was never assigned (e.g. for YouTube videos).
  final RxBool isFlickInitialized = false.obs;

  /// The subtitle track the user picked from the selector sheet. `null` means
  /// subtitles are off. Drives which `.vtt`/`.srt` file the overlay loads, and
  /// whether the overlay is shown at all.
  final Rxn<SubtitleModel> selectedSubtitle = Rxn<SubtitleModel>();

  /// Whether the in-player subtitle/language selector panel is open. We drive
  /// the selector with our own overlay (instead of a [PopupMenuButton]) so it
  /// works the same in portrait and in flick's fullscreen route — a popup menu
  /// renders into the root navigator overlay and gets clipped/dismissed by the
  /// fullscreen route + auto-hiding landscape controls.
  final RxBool isSubtitleMenuOpen = false.obs;

  void toggleSubtitleMenu() {
    isSubtitleMenuOpen.value = !isSubtitleMenuOpen.value;
  }

  void closeSubtitleMenu() {
    if (isSubtitleMenuOpen.value) isSubtitleMenuOpen.value = false;
  }

  /// Selects a subtitle track, or `null` to turn subtitles off.
  void selectSubtitle(SubtitleModel? subtitle) {
    selectedSubtitle.value = subtitle;
    isSubtitleMenuOpen.value = false;
  }

  /// Resets the device back to portrait and restores the system UI overlays.
  /// Called when leaving the player / exiting fullscreen so we never get stuck
  /// on a black landscape screen.
  Future<void> resetOrientationToPortrait() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  /// Handles a back press from the player screen.
  ///
  /// Returns `false` when we only exited fullscreen (the screen should stay),
  /// and `true` when the screen is allowed to pop. We intentionally do NOT
  /// dispose [flickManager] here — disposing it during the pop transition (or
  /// while its fullscreen overlay is still active) is what caused the black
  /// screen. The manager is reused/replaced on the next playback instead.
  Future<bool> handlePlayerBack() async {
    if (isFlickInitialized.value) {
      try {
        final controlManager = flickManager.flickControlManager;
        if (controlManager != null && controlManager.isFullscreen) {
          controlManager.exitFullscreen();
          await resetOrientationToPortrait();
          return false;
        }
        controlManager?.pause();
      } catch (_) {}
    }
    try {
      youtubeController.pause();
    } catch (_) {}
    await resetOrientationToPortrait();
    return true;
  }

  final RxBool isMidRollAdPlaying = RxBool(false);
  final RxBool isPlayerInitialized = RxBool(false);
  final RxBool isInitializing = RxBool(false);

  // Store the current main content URL to avoid re-initialization
  String? currentMainContentUrl;

  @override
  void onInit() {
    super.onInit();
    _initializeYouTubeController(
        videoUrl: "https://www.youtube.com/watch?v=u6Xsayqxij0");
  }

  Future<void> _initializeYouTubeController({required String? videoUrl}) async {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl ?? "");
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }


  final RxString finalUrl = RxString("");

  Future<void> parseVideoUrl(
      {required String fileUrl, required String fileSource}) async {
    final apiKey = Get
        .find<GlobalController>()
        .googleDriveApiKey;
    finalUrl.value = "";
    if (fileSource == "gdrive") {
      finalUrl.value =
      await generateGoogleDriveDirectUrl(fileUrl, apiKey.value);
    } else {
      finalUrl.value = fileUrl;
    }
  }

  Future<String> generateGoogleDriveDirectUrl(String sharedUrl,
      String apiKey) async {
    final regExp = RegExp(r'd/([a-zA-Z0-9_-]+)');
    final match = regExp.firstMatch(sharedUrl);
    if (match != null && match.groupCount > 0) {
      final fileId = match.group(1);
      // Construct direct API URL for downloading video file
      return "https://www.googleapis.com/drive/v3/files/$fileId?alt=media&key=$apiKey";
    }
    return sharedUrl; // fallback: original URL (in case it's not a Google Drive link)
  }


  Future<void> downloadVideo(BuildContext context, String url) async {
    try {
      FileDownloader.downloadFile(
        url: url,
        name: 'video_${DateTime
            .now()
            .millisecondsSinceEpoch}.mp4',
        onProgress: (name, progress) {
          print('Download progress: $progress%');
        },
        onDownloadCompleted: (path) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Download completed: $path')),
          );
        },
        onDownloadError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Download error: $error')),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }

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

  void videoPlayerFunction({
    required bool? isFree,
    required bool? isRental,
    required bool? isRented,
    required bool? isSubscribed,
    required String? fileUrl,
    required String? fileSource,
    int? seekToPosition = 0
  }) async {
    // Validate URL before proceeding
    if (fileUrl == null || fileUrl.isEmpty) {
      print("Error: Video URL is null or empty");
      return;
    }

    // Your existing logic...
    if ((isFree == false && isRental == true && isRented == true) ||
        (isFree == false &&
            isRented == false &&
            Get
                .find<GlobalController>()
                .subscribedUserCheck
                .value == true) ||
        isFree == true) {
      if (fileSource == "youtube") {
        // YouTube logic...
      } else if (fileSource != "youtube" &&
          fileSource.toString().toLowerCase() != "gdrive") {
        ll("Attempting to play video: $fileUrl");

        try {
          // Release the previous player (if any) before building a new one so
          // we don't leak native resources when switching servers / videos.
          if (isFlickInitialized.value) {
            try {
              flickManager.dispose();
            } catch (_) {}
          }
          isFlickInitialized.value = true;
          flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(
              fileUrl,
              httpHeaders: {
                'User-Agent': 'Mozilla/5.0 (compatible; MyApp/1.0)',
              },
            )
              ..initialize().then((_) {
                final seekSeconds = seekToPosition;
                if (seekSeconds != null && seekSeconds > 0) {
                  flickManager.flickVideoManager!.videoPlayerController!
                      .seekTo(Duration(seconds: seekSeconds));
                }
                flickManager.flickVideoManager!.videoPlayerController
                    ?.addListener(() {
                  final controller = flickManager.flickVideoManager!
                      .videoPlayerController!;
                  totalSeconds.value = controller.value.duration.inSeconds;
                  currentSeconds.value = controller.value.position.inSeconds;
                });
              }).catchError((error) {
                ll("Video initialization error: $error");
                _handleVideoError(error);
              }),
          );
        } catch (e) {
          ll("FlickManager creation error: $e");
          _handleVideoError(e);
        }
      }
    }
  }

  void _handleVideoError(dynamic error) {
    Get.snackbar(
      "Video Error",
      "Unable to play this video. Please try again later.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

