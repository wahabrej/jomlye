import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

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
                       return PlayListWidget(image: "https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1925&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",name: "War Movies",videoCount: "20",);
                      }, separatorBuilder: (context,index)=> kH16sizedBox, itemCount: 5)
                ],
              ),
            ),
          ),
    );
  }
}

class PlayListWidget extends StatelessWidget {
  const PlayListWidget({super.key, required this.image, required this.name, required this.videoCount, this.onPressed});
  final String image,name,videoCount;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(k8BorderRadius),
          child: Image.network(image,width: width-40,height: 225.h,fit: BoxFit.cover,)),
      kH16sizedBox,
      Text(name,style: medium16TextStyle(cWhiteColor),),
      kH10sizedBox,
      Row(
        children: [
        SvgPicture.asset(kiPlay,color: cGreyColor,),
        kW8sizedBox,
        Text("$videoCount Videos",style: regular14TextStyle(cGreyColor.withOpacity(0.8)),),
        const Expanded(child: SizedBox()),
        // CustomIconButton(onPress: (){}, icon: Icons.more_vert),
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