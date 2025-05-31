import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AllVideoPlayerController extends GetxController {
  late YoutubePlayerController youtubeController;

  final RxString videoUrl = RxString('https://www.youtube.com/watch?v=K18cpp_-gP8');

  @override
  void onInit() {
    super.onInit();
    final videoId = YoutubePlayer.convertUrlToId(videoUrl.value);
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
  final RxList movieTypeList = RxList([
  "HD","Action", "Super Hit", "Block Buster"
  ]);

//   Future<bool> requestStoragePermission() async {
//   if (Platform.isAndroid) {
//     ll("1");
//     if (await Permission.storage.isGranted) return true;

//     // For Android 11+
//     if (Platform.isAndroid && (await Permission.manageExternalStorage.status.isDenied)) {
//     ll("2");
//       final status = await Permission.manageExternalStorage.request();
//       return status.isGranted;
//     }
//     ll("3");

//     final status = await Permission.storage.request();
//     return status.isGranted;
//   } else {
//     ll("4");
//     return true;
//   }
// }


//   var downloadProgress = 0.0.obs;
//   var isDownloading = false.obs;

//   Future<void> downloadVideo(String url, String fileName) async {
//   try {
//     if (!await requestStoragePermission()) {
//       Get.snackbar("Permission Denied", "Storage permission is required.");
//       return;
//     }

//     isDownloading.value = true;
//     downloadProgress.value = 0;

//     Directory dir = Platform.isAndroid
//         ? Directory('/storage/emulated/0/Download') // Save in Downloads folder
//         : await getApplicationDocumentsDirectory();

//     String filePath = '${dir.path}/$fileName';

//     Dio dio = Dio();

//     await dio.download(
//       url,
//       filePath,
//       onReceiveProgress: (received, total) {
//         if (total != -1) {
//           downloadProgress.value = received / total;
//         }
//       },
//     );

//     Get.snackbar("Download Complete", "Saved to $filePath");
//   } catch (e) {
//     Get.snackbar("Error", "Download failed: $e");
//   } finally {
//     isDownloading.value = false;
//   }
// }


  //  Future<void> downloadVideo(String videoUrl, String fileName) async {
  //   try {
  //     // Request permission
  //     bool hasPermission = await requestStoragePermission();
  //     if (!hasPermission) {
  //       throw Exception('Storage permission denied');
  //     }

  //     // Get download directory
  //     Directory? directory;
  //     if (Platform.isAndroid) {
  //       directory = await getExternalStorageDirectory();
  //     } else {
  //       directory = await getApplicationDocumentsDirectory();
  //     }

  //     String savePath = '${directory!.path}/$fileName';

  //     // Download with progress tracking
  //     Dio dio = Dio();
  //     await dio.download(
  //       videoUrl,
  //       savePath,
  //       onReceiveProgress: (received, total) {
  //         if (total != -1) {
  //           double progress = received / total;
  //           print('Download progress: ${(progress * 100).toStringAsFixed(0)}%');
  //           // You can update UI here with progress
  //         }
  //       },
  //     );

  //     print('Video downloaded to: $savePath');
  //   } catch (e) {
  //     print('Download error: $e');
  //     throw e;
  //   }
  // }

  // static Future<bool> requestStoragePermission() async {
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     status = await Permission.storage.request();
  //   }
  //   return status.isGranted;
  // }

  final MediaDownload flutterMediaDownloaderPlugin = MediaDownload();
}

