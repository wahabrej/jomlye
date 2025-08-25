import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    unFocus(context);
    
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Center(
                child: SvgPicture.asset(
                  kiSplashImage,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: height/2.5,
              right: width/2.75,
              child: Column(
                children: [
                  SvgPicture.asset(
                      kiFlixoo,
                      width: 56,
                      height: 75,
                    ),
                    kH30sizedBox,
                    Text(ksFlixoo.tr,style: semiBold20TextStyle(cWhiteColor),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
