import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class VideoQualityScreen extends StatelessWidget {
   VideoQualityScreen({super.key});
   final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
         appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSize.h),
        //   //* info:: appBar
          child: CustomAppBar(
            hasBackButton: false,
            title:  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 140,
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
                                ksVideoQuality.tr,
                                style: regular16TextStyle(cWhiteColor),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                       SvgPicture.asset(
                      kiVidflix,
                      width: h24.w,
                      height: h24.h,
                      color: cPrimaryColor2,
                    ),
                    kW4sizedBox,
                    Center(
                      child: Text(
                        ksVidflix.tr,
                        style: semiBold20TextStyle(cWhiteColor),
                      ),
                    ),
                    kW20sizedBox,
                    ],
          ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Column(
              children: [
                      Divider(
                    thickness: 1,
                    color: cWhiteColor.withOpacity(0.2),
                  ),
                  kH16sizedBox,
                  ListView.separated(separatorBuilder: (context,index)=>kH16sizedBox, 
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileController.videoQualityList.length,itemBuilder: (context,index){
                    return Obx(() => VideoQualityItem(
                                          videoQuality: profileController.videoQualityList[index]["quality"],
                                          state: profileController.videoQualityList[index]["state"],
                                          onPressed: (){
                                           profileController.videoQualityList[index]["state"] = true;
                                          },
                                        ));
                  },),
              ],
            ),
          ),
    );
  }
}

class VideoQualityItem extends StatelessWidget {
  const VideoQualityItem({super.key, required this.videoQuality, required this.state, this.onPressed});
  final String videoQuality;
  final bool state;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: cTransparentColor,
      splashColor: cTransparentColor,
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: cWhiteColor,
            ),
          ),
          kW12sizedBox,
          Text(videoQuality,style: regular16TextStyle(cWhiteColor),),
          const Expanded(child: SizedBox()),
           Container(
          height: 20.h,
          width: 20.w,
          padding: EdgeInsets.all(2.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.5.h, color: state==true ? cPrimaryColor2:cWhiteColor.withOpacity(0.5))),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: state==true ? cPrimaryColor2 : null),
          ),
        ),
        ],
      ),
    );
  }
}