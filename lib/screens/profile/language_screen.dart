import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/images.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class LanguageScreen extends StatelessWidget {
 LanguageScreen({super.key});
 final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ksLanguage.tr,
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
                  Text(ksSuggested.tr,style: medium16TextStyle(cWhiteColor),),
                  kH20sizedBox,
                  const CommonLanguageWidget(languageName: "English(US)",fillColor: cPrimaryColor2),
                  kH16sizedBox,
                  const CommonLanguageWidget(languageName: "English(Uk)",borderColor: cWhiteColor,),
                  kH20sizedBox,
                   Divider(
                    thickness: 1,
                    color: cWhiteColor.withOpacity(0.2),
                  ),
                  // ListView.separated(itemBuilder: , separatorBuilder: separatorBuilder, itemCount: ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileController.languageList.length,
                  separatorBuilder: (context,index)=>kH20sizedBox,
                  itemBuilder: (context,index){
                    return CommonLanguageWidget(languageName: profileController.languageList[index],borderColor: cWhiteColor,);
                  }, ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonLanguageWidget extends StatelessWidget {
  final String languageName;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? fillColor;

  const CommonLanguageWidget({
    super.key,
    required this.languageName,
    this.fillColor,
    this.borderColor,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
            Text(
            languageName,
            style: regular16TextStyle(cWhiteColor),
          ),
          const Expanded(child: SizedBox()),
      Container(
        height: 20.h,
        width: 20.w,
        padding: EdgeInsets.all(2.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1.5.h, color: borderColor ?? cPrimaryColor2)),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: fillColor),
        ),
      ),
        ],
      ),
    );
  }
}
