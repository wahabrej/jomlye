import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class PlayListScreen extends StatelessWidget {
   PlayListScreen({super.key});
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
                        width: 100.w,
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
                                ksPlaylist.tr,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                    Divider(
                        thickness: 1,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                      kH16sizedBox,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                       return PlayListWidget(image: profileController.playlistList[index].thumbnail??"",name: profileController.playlistList[index].name??"",videoCount: profileController.playlistList[index].totalVideo??0,onPressed: (){
                        Get.find<GlobalController>().commonBottomSheet(context: context, content: PlayListBottomSheetContent(), onPressCloseButton: (){Get.back();}, onPressRightButton: (){}, rightText: "", rightTextStyle: medium14TextStyle(cWhiteColor), title: ksPlaylist.tr, isRightButtonShow: false,bottomSheetColor: cBlackColor2,bottomSheetHeight: height*0.12.h,isTitleShow: false,);
                       },);
                      }, separatorBuilder: (context,index)=> kH16sizedBox, itemCount: profileController.playlistList.length)
                ],
              ),
            ),
          ),
    );
  }
}

class PlayListWidget extends StatelessWidget {
  const PlayListWidget({super.key, required this.image, required this.name, required this.videoCount, this.onPressed});
  final String image,name;
  final int? videoCount;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(k8BorderRadius),
          child: Image.network(image,width: width-40,height: 225.h,fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) => SizedBox(
            width: width,
            child: SvgPicture.asset(
              kiDummyMovie,
              height:  225.h,
              width: width,
              fit: BoxFit.cover,
            ),
          ),)),
      kH16sizedBox,
      Text(name,style: medium16TextStyle(cWhiteColor),),
      kH10sizedBox,
      Row(
        children: [
        SvgPicture.asset(kiPlay,color: cGreyColor,),
        kW8sizedBox,
        if(videoCount!=null)
        Text("$videoCount Videos",style: regular14TextStyle(cGreyColor.withOpacity(0.8)),),
        const Expanded(child: SizedBox()),
        InkWell(
          splashColor: cTransparentColor,
          highlightColor: cTransparentColor,
          onTap: onPressed,
          child: const Icon(Icons.more_vert,color: cWhiteColor,size: kIconSize20,)),
        ],
      ),
      ],
    );
  }
}



class PlayListBottomSheetContent extends StatelessWidget {
  PlayListBottomSheetContent({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            kH8sizedBox,
            ListView.separated(
                separatorBuilder: (context, index) => kH8sizedBox,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profileController.playListValueList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                    child: Row(
                      children: [
                        Icon(profileController.playListValueList[index]["icon"],size: kIconSize16,color: cWhiteColor,),
                        kW8sizedBox,
                        InkWell(
                          onTap: () {
                            // profileController.selectedPlayListValue.value =
                            //     profileController.playListValueList[index]["title"];
                                Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(k8Padding),
                            child: Text(
                              profileController.playListValueList[index]["title"],
                              style: medium14TextStyle(cWhiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ));
  }
}