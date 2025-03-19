import 'package:vidflix_flutter_app/utils/constants/images.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required bool isFirstButtonClicked,
    required bool isSecondButtonClicked,
    required bool isThirdButtonClicked,
    required bool isFourthButtonClicked,
    required bool isFifthButtonClicked,
    required double width,
  })  : _isFirstButtonClicked = isFirstButtonClicked,
        _isSecondButtonClicked = isSecondButtonClicked,
        _isThirdButtonClicked = isThirdButtonClicked,
        _isFourthButtonClicked = isFourthButtonClicked,
        _isFifthButtonClicked = isFifthButtonClicked,
        _width = width;

  final bool _isFirstButtonClicked;
  final bool _isSecondButtonClicked;
  final bool _isThirdButtonClicked;
  final bool _isFourthButtonClicked;
  final bool _isFifthButtonClicked;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cBlackColor2,
      height: kBottomNavHeight.h,
      child: Column(  //* Obx(() => 
              children: [
                // const Divider(
                //   height: .5,
                //   thickness: .5,
                //   color: cLineColor,
                // ),
                Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //* Home
          _BottomNavbarItem(
            width: _width,
            isClicked: _isFirstButtonClicked,
            title: ksHome.tr,
            onPressed: () {
              Get.offAllNamed(krHomeScreen);
            },
            image: kiHome,
          ),
          // const SizedBox(
          //   height: 48,
          //   child: VerticalDivider(
          //     thickness: 1,
          //     color: cDividerColor,
          //     width: 1,
          //   ),
          // ),
          //* Live Stream
          _BottomNavbarItem( 
            width: _width,
            isClicked: _isSecondButtonClicked,
            title: "",
            onPressed: () async{
        // Get.offAllNamed(krProfileScreen);
        // await Get.find<ProfileController>().getProfile();
      },
      image: kiLiveStream,
    ),
        //* Popcorn
          _BottomNavbarItem( 
            width: _width,
            isClicked: _isThirdButtonClicked,
            title: "",
            onPressed: () async{
        // Get.offAllNamed(krProfileScreen);
        // await Get.find<ProfileController>().getProfile();
      },
      image: kiPopcorn,
    ),
        //* Tv Screen
          _BottomNavbarItem( 
            width: _width,
            isClicked: _isFourthButtonClicked,
            title: "",
            onPressed: () async{
        // Get.offAllNamed(krProfileScreen);
        // await Get.find<ProfileController>().getProfile();
      },
      image: kiTvScreen,
    ),
        //* Profile
          _BottomNavbarItem( 
            width: _width,
            isClicked: _isFifthButtonClicked,
            title: "",
            onPressed: () async{
           Get.toNamed(krProfileScreen);
        // await Get.find<ProfileController>().getProfile();
      },
      image: kiProfile,
    ),
  ],
),
        ],
      ),
      // ),
    );
  }
}

class _BottomNavbarItem extends StatelessWidget {
  const _BottomNavbarItem({
    super.key,
    required this.width,
    required this.isClicked,
    required this.title,
    required this.image,
    required this.onPressed,
  });

  final double width;
  final bool isClicked;
  final String title;
  final String? image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavHeight.h - .5,
      width: width * .2,
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: k4Padding),
              child: Row(
                children: [
                  SvgPicture.asset(image.toString(),height: isDeviceScreenLarge() ? 24 : 20,width: isDeviceScreenLarge() ? 24 : 20,color: isClicked ? cPrimaryColor2 : cIconColor,),
                 kW6sizedBox,
                 Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: medium16TextStyle(isClicked ? cWhiteColor : cBlackColor),
                ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 3.0),
            //   child: Text(
            //     title,
            //     overflow: TextOverflow.ellipsis,
            //     style: medium16TextStyle(isClicked ? cWhiteColor : cBlackColor),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class _BottomNavbarItem extends StatelessWidget {
//   const _BottomNavbarItem({
//     super.key,
//     required this.width,
//     required this.isClicked,
//     required this.title,
//     required this.image,
//     required this.onPressed,
//   });

//   final double width;
//   final bool isClicked;
//   final String title;
//   final String? image;
//   final VoidCallback? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: kBottomNavHeight.h - .5,
//       width: width * .2,
//       child: TextButton(
//         style: kTextButtonStyle,
//         onPressed: onPressed,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               children: [
//                 SvgPicture.asset(image.toString(),height: isDeviceScreenLarge() ? 24 : 20,width: isDeviceScreenLarge() ? 24 : 20,color: isClicked ? cPrimaryColor2 : cIconColor,),
//                 Visibility(
//                   visible: false,
//                   child: Positioned(
//                     right: 2,
//                     top: 0,
//                     child: Container(
//                       height: 6,
//                       width: 6,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: cPrimaryColor),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 3.0),
//               child: Text(
//                 title,
//                 overflow: TextOverflow.ellipsis,
//                 style: medium16TextStyle(isClicked ? cWhiteColor : cBlackColor),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }