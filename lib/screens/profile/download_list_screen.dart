import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class DownloadListScreen extends StatelessWidget {
  DownloadListScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Column(
              children: [
                kH40sizedBox,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: h32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: cWhiteColor.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: k12Padding, vertical: k2Padding),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back_ios,
                                size: kIconSize12,
                                color: cWhiteColor,
                              ),
                              kW4sizedBox,
                              Center(
                                  child: Text(
                                ksDownloadList.tr,
                                style: regular16TextStyle(cWhiteColor),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    SvgPicture.asset(
                      kiVidflix,
                      width: h24.w,
                      height: h24.h,
                      color: cPrimaryColor2,
                    ),
                    kW4sizedBox,
                    Text(
                      ksVidflix.tr,
                      style: semiBold20TextStyle(cWhiteColor),
                    ),
                  ],
                ),
                kH8sizedBox,
                Divider(
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH8sizedBox,
                ListView.separated(
                  padding: const EdgeInsets.all(k0Padding),
                  separatorBuilder: (context, index) => kH16sizedBox,
                  itemCount: profileController.downloadedMovieList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CommonMovieListWidget(
                      movieImage: profileController.downloadedMovieList[index]
                          ["movieImage"],
                      movieName: profileController.downloadedMovieList[index]
                          ["movieName"],
                      movieDuration: profileController.downloadedMovieList[index]
                          ["movieDuration"],
                      movieSize: profileController.downloadedMovieList[index]
                          ["movieSize"],
                      movieTagList: profileController.downloadedMovieList[index]
                          ["movieTagList"],
                    );
                  },
                ),
                kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommonMovieListWidget extends StatelessWidget {
  const CommonMovieListWidget(
      {super.key,
      required this.movieImage,
      this.movieTagList,
      required this.movieName,
      required this.movieDuration,
      required this.movieSize});
  final String movieImage, movieName, movieDuration, movieSize;
  final List? movieTagList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(k4BorderRadius),
            child: Image.network(
              movieImage,
              width: 150.w,
              height: 90.h,
              fit: BoxFit.cover,
            )),
            kW12sizedBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (int i = 0; i < movieTagList!.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: k6Padding),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cWhiteColor.withOpacity(0.2),
                          border: Border.all(
                              width: 1, color: cPrimaryColor2.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(k4BorderRadius.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: k8Padding, vertical: k2Padding),
                          child: Text(
                            movieTagList?[i],
                            style: regular12TextStyle(cWhiteColor),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              kH4sizedBox,
              Text(movieName,
                  style: medium14TextStyle(cWhiteColor),
                  overflow: TextOverflow.clip),
              kH4sizedBox,
              Text(movieDuration,
                  style: regular8TextStyle(cWhiteColor.withOpacity(0.7)),
                  overflow: TextOverflow.clip),
              kH6sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomElevatedButton(
                    label: movieSize,
                    onPressed: () {},
                    buttonColor: cPrimaryColor2,
                    buttonWidth: 50.w,
                    buttonHeight: 18.h,
                  ),
                ],
              ),
            ],
          ),
        ),
        kW20sizedBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: h36.w,
              height: h36.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                color: cWhiteColor.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(k10Padding),
                child: SvgPicture.asset(kiDelete),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
