import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/home/home_controller.dart';
import 'package:vidflix_flutter_app/screens/home/view_all_screens/all_blogs_view_all_screen.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/images.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class SearchScreen extends StatelessWidget {
 SearchScreen({super.key});
 final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        child: Obx(() => Column(
                  children: [
                    kH60sizedBox,
                    SizedBox(
                      width: width-40,
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            height: kTextFieldHeight.h,
                             width: (width-95),
                            child: CustomModifiedTextField(
                                      hint: ksSearch.tr,
                                      controller: homeController.searchTextEditingController,
                                      fillColor: cBlackColor,
                                      textInputStyle: regular14TextStyle(cWhiteColor),
                                      focusBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(k6BorderRadius),
                                        borderSide: const BorderSide(
                                          width: 1,
                                  color: cPrimaryColor2,
                                ),
                              ),
                              prefixIcon: Icons.search,
                              suffixIcon: homeController.isSearchSuffixIconShow.value ? Icons.close:null,
                              suffixIconSize: kIconSize24,
                              suffixIconColor: cWhiteColor,
                              onSuffixPress: (){
                                homeController.searchTextEditingController.clear();
                                homeController.isSearchSuffixIconShow.value = false;
                              },
                              onChanged: (value){
                                if(homeController.searchTextEditingController.text!=""){
                                homeController.isSearchSuffixIconShow.value = true;
                                }
                                else{
                                homeController.isSearchSuffixIconShow.value = false;
                                }
                              },
                               border: 
                            OutlineInputBorder(
                              borderRadius: BorderRadius.circular(k6BorderRadius),
                              borderSide:  BorderSide(width: 1,color: cWhiteColor.withOpacity(0.3), style: BorderStyle.solid,),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                              ),
                  ),
                  kW10sizedBox, 
                  GestureDetector(
                      onTap: () {
                          Get.find<GlobalController>().commonBottomSheet(
                            context: context,
                            bottomSheetHeight: height*0.65,
                            isScrollControlled: true,
                            content: AllBlogBottomSheetContent(),
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: () {},
                            rightText: "",
                            rightTextStyle: semiBold14TextStyle(cWhiteColor),
                            title: ksFilterBlogs.tr,
                            isRightButtonShow: false,
                            bottomSheetColor: cBlackColor);
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cPrimaryColor2,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(k12Padding),
                          child: SvgPicture.asset(
                            kiFilter,
                            color: cWhiteColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            kH8sizedBox,
            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(ksSearchResults.tr,style: medium16TextStyle(cWhiteColor),),
            //         Text("Shown 0 results",style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),),
            //       ],
            //     ),
            //   ],
            // ),
            // // Container(
            // //   child: SvgPicture.asset(kiSearchResult,width: 200.w,height: 200.h,color: cWhiteColor,)),
            // SizedBox(
            //   height: (height*0.75),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Image.asset(kiSearchResultPng,width: 200.w,height: 200.h,),
            //       Text(ksNoVideoFound.tr,style: medium16TextStyle(cPrimaryColor2),),
            //       kH16sizedBox,
            //       Text(ksNoVideosFoundPleaseCheckFilter.tr,style: regular14TextStyle(cWhiteColor.withOpacity(0.5,)),textAlign: TextAlign.center,),
            //     ],
            //   )),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ksSearchResults.tr,style: medium16TextStyle(cWhiteColor),),
                    Text("Shown 20 results",style: regular14TextStyle(cWhiteColor.withOpacity(0.5)),),
                  ],
                ),
              ],
            ),
            // Container(
            //   child: SvgPicture.asset(kiSearchResult,width: 200.w,height: 200.h,color: cWhiteColor,)),
            SizedBox(
              height: (height*0.75),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(k4BorderRadius),
                        child: Image.network("https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjV8fHVzZXJ8ZW58MHx8MHx8fDA%3D",width: 70.w,height: 105.h,fit: BoxFit.cover,)),
                        kW14sizedBox,
                        Column(
                          children: [
                     Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: cWhiteColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            width: 1.33,
                            color: cPrimaryColor2.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          "Action",
                          style: semiBold14TextStyle(cWhiteColor),
                        ),
                      ),
                      kH8sizedBox,
                      Text("Furry 2024 | War movie",style: medium16TextStyle(cWhiteColor),),
                      kH8sizedBox,
                      
                          ],
                        ),
                    ],
                  ),
                ],
              )),
              
          ],
        ),
      ),
      ),
    );
  }
}