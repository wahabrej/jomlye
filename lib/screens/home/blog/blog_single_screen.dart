import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class BlogSingleScreen extends StatelessWidget {
  BlogSingleScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: SingleChildScrollView(
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
                                ksBlogSinglePage.tr,
                                style: regular16TextStyle(cWhiteColor),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kH8sizedBox,
                Divider(
                  thickness: 1,
                  color: cWhiteColor.withOpacity(0.2),
                ),
                kH16sizedBox,
                Text(
                  "The US government is sending its first high level delegation to China since",
                  style: medium18TextStyle(cWhiteColor),
                ),
                kH16sizedBox,
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: cPrimaryColor2,
                      size: kIconSize16,
                    ),
                    kW10sizedBox,
                    Text(
                      "06 Jan 2025",
                      style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
                    ),
                    kW10sizedBox,
                    SizedBox(
                      height: 10,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                    ),
                    kW10sizedBox,
                    const Icon(
                      Icons.mode_comment_outlined,
                      color: cPrimaryColor2,
                      size: kIconSize16,
                    ),
                    kW10sizedBox,
                    Text(
                      "10",
                      style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
                    ),
                    kW10sizedBox,
                    SizedBox(
                      height: 10,
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                    ),
                    kW10sizedBox,
                    const Icon(
                      Icons.person_outline_sharp,
                      color: cPrimaryColor2,
                      size: kIconSize16,
                    ),
                    kW10sizedBox,
                    Text(
                      "By Esther Howard",
                      style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),
                    ),
                  ],
                ),
                kH20sizedBox,
                ClipRRect(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa54OMxsrzyzRkNgqGlTT6iKs79aImGXmJGAU7HrKeqAS0gZKSXMJOxkk&s",width: width-40,height: 240.h,fit: BoxFit.cover,)),
                  kH20sizedBox,
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero.",style: regular14TextStyle(cWhiteColor.withOpacity(0.7),),),
                  kH20sizedBox,
                           ClipRRect(
                  borderRadius: BorderRadius.circular(k4BorderRadius),
                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTa54OMxsrzyzRkNgqGlTT6iKs79aImGXmJGAU7HrKeqAS0gZKSXMJOxkk&s",width: width-40,height: 240.h,fit: BoxFit.cover,)),
                 kH20sizedBox,
                 Text("What is shoes trend in 2022 ?",style: medium16TextStyle(cWhiteColor)),
                 kH20sizedBox,
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero.",style: regular14TextStyle(cWhiteColor.withOpacity(0.7),),),
                kH20sizedBox,
                Container(
                  decoration: BoxDecoration(
                    color: cWhiteColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(k6BorderRadius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: k20Padding,vertical: k30Padding),
                    child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. ",style: regular16TextStyle(cWhiteColor),),
                  ),
                ),
                kH20sizedBox,
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero. Nam eget pulvinar ante. Suspendisse ante arcu, venenatis at purus eget, porta ultrices nulla. Nam eget pulvinar ante. Suspendisse ante arcu, venenatis at purus eget, porta ultrices nulla.",style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),),
                kH20sizedBox,
                             GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: homeController.latestBlogList.length,
                    itemBuilder: (context, index) {
                           return SizedBox(
                            width: width-72,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(k4BorderRadius),
                              child: Image.network(homeController.latestBlogList[index]["image"], width: width-72,
                              height: 120,fit: BoxFit.cover,),
                            ));
                    },
                  ),
                  kH24sizedBox,
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam tempus, lectus a gravida aliquam, eros lacus laoreet sem, vel consequat eros augue sit amet nunc. Vivamus tortor massa, rhoncus quis elementum sit amet, bibendum viverra libero.",style: regular14TextStyle(cWhiteColor.withOpacity(0.7)),),
                  kH20sizedBox,
                  Text("What is shoes trend in 2022 ?",style: medium16TextStyle(cWhiteColor),),       
                  kH20sizedBox,
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: homeController.blogBulletPointList.length,
                    itemBuilder: (context,index){
                      return Row(
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cWhiteColor,
                            ),
                            child: Text(homeController.blogBulletPointList[index]),
                          ),
                        ],
                      );
                    }
                  ),
                         ],
            ),
          ),
        ),
      ),
    );
  }
}
