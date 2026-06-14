import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/common/sp_controller.dart';
import 'package:flixoo_flutter_app/controllers/home/home_controller.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final double width;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cBlackColor2,
      height: kBottomNavHeight.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavbarItem(
                width: width,
                isSelected: selectedIndex == 0,
                title: ksHome.tr,
                onPressed: () async{
                  await Get.find<HomeController>().loadBannerAd();
                  Get.offAllNamed(krHomeScreen);
                },
                image: kiHome,
              ),
              _BottomNavbarItem(
                width: width,
                isSelected: selectedIndex == 1,
                title: ksLive.tr,
                onPressed: () async {
                  // Navigate to live stream
                  await Get.find<HomeController>().disposeBannerAd();
                  await Get.find<HomeController>().getTvChannel();
                  Get.toNamed(krTvChannelsViewAllScreen);
                },
                image: kiLiveStream,
              ),
              _BottomNavbarItem(
                width: width,
                isSelected: selectedIndex == 2,
                title: ksMovies.tr,
                onPressed: () async {
                  // Navigate to popcorn section
                  Get.find<HomeController>().selectedTitle.value = "";
                  await Get.find<HomeController>().disposeBannerAd();
                  await Get.find<HomeController>().getMovieList(movieType: "");
                  Get.toNamed(krMovieViewAllScreen);
                },
                image: kiPopcorn,
              ),
              _BottomNavbarItem(
                width: width,
                isSelected: selectedIndex == 3,
                title: ksTv.tr,
                onPressed:() async {
                        Get.find<HomeController>().resetBottomSheetData();
                       Get.find<ProfileController>().temporaryPlayListCheckBoxStateList
                            .clear();
                        Get.find<HomeController>().isViewAllSearchEnable.value = false;
                        Get.find<HomeController>().viewAllTextEditingController.clear();
                        Get.find<HomeController>().selectedTitle.value = ksPopularTvShows;
                        await Get.find<HomeController>().getTvShows();
                        await Get.find<HomeController>().disposeBannerAd();
                        Get.toNamed(krTvShowsViewAllScreen);
                        // Get.toNamed(krMovieViewAllScreen);
                      },
                image: kiTvScreen,
              ),
              _BottomNavbarItem(
                width: width,
                isSelected: selectedIndex == 4,
                title: ksProfile.tr,
                onPressed: () async{
                await Get.find<HomeController>().disposeBannerAd();
                  if(Get.find<GlobalController>().userToken.value==""){
                    Get.toNamed(krSignInScreen);
                  }
                  else{
                    Get.toNamed(krProfileScreen);
                    final int userId = await SpController().getUserId()??-1;
                    await Get.find<ProfileController>().getProfile(userId: userId);
                  }
                },
                image: kiProfile,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNavbarItem extends StatelessWidget {
  final double width;
  final bool isSelected;
  final String title;
  final String? image;
  final VoidCallback? onPressed;

  const _BottomNavbarItem({
    required this.width,
    required this.isSelected,
    required this.title,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavHeight.h - .5,
      width: isSelected ? width * .3 : width * .175,
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: isSelected
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: cPrimaryColor2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      image.toString(),
                      height: isDeviceScreenLarge() ? 24 : 20,
                      width: isDeviceScreenLarge() ? 24 : 20,
                      color: cWhiteColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: medium16TextStyle(cWhiteColor),
                    ),
                  ],
                ),
              )
            : SvgPicture.asset(
                image.toString(),
                height: isDeviceScreenLarge() ? kIconSize24 : kIconSize20,
                width: isDeviceScreenLarge() ? kIconSize24 : kIconSize20,
                color: cWhiteColor,
              ),
      ),
    );
  }
}
