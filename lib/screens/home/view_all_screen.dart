import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/home/home_screen.dart';
import 'package:vidflix_flutter_app/utils/constants/images.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class ViewAllScreen extends StatelessWidget {
 ViewAllScreen({super.key});
 final HomeController homeController = Get.find<HomeController>();
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
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: h32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: cWhiteColor.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: k12Padding,vertical: k2Padding),
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back_ios,size: kIconSize12,color: cWhiteColor,),
                              kW4sizedBox,
                              Center(child: Text("All TV Series",style: regular16TextStyle(cWhiteColor),)),
                            ],
                          ),
                        ),
                      ),
                    ),
                     const Expanded(child: SizedBox(),),
                            Container(
                      width: 46.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                      child: const Icon(Icons.search,color: cWhiteColor,size: 32,),
                    ),
                    kW6sizedBox,
                    Container(
                       width: 46.w,
                      height: 46.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: cPrimaryColor2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: SvgPicture.asset(kiFilter,color: cWhiteColor,),
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
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: homeController.viewAllMovieList.length,
                    itemBuilder: (context, index) {
                           return MovieContentContainer(
                            movieImage: homeController.viewAllMovieList[index]["movieImage"],
                            seasonName: homeController.viewAllMovieList[index]["season"],
                            isPremium: homeController.viewAllMovieList[index]["isPremium"],
                            isSeason: homeController.viewAllMovieList[index]["isSeason"],
                          );
                    },
                  ),
                 
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}