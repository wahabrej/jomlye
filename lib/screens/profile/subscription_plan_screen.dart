import 'package:vidflix_flutter_app/controllers/payment/payment_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class SubscriptionPlanScreen extends StatelessWidget {
   SubscriptionPlanScreen({super.key});
   final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
          appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSize.h),
          //   //* info:: appBar
          child: CustomAppBar(
            hasBackButton: false,
            title: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width:  180,
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
                        ksSubscriptionPlan.tr,
                        style: regular16TextStyle(cWhiteColor),
                        textAlign: TextAlign.center,
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
              kW12sizedBox,
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Column(
              children: [
                      // Row(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         Get.back();
                      //       },
                      //       child: Container(
                      //         height: h32,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(100.r),
                      //           color: cWhiteColor.withOpacity(0.2),
                      //         ),
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //               horizontal: k12Padding, vertical: k2Padding),
                      //           child: Row(
                      //             children: [
                      //               const Icon(
                      //                 Icons.arrow_back_ios,
                      //                 size: kIconSize12,
                      //                 color: cWhiteColor,
                      //               ),
                      //               kW4sizedBox,
                      //               Center(
                      //                   child: Text(
                      //                 ksSubscriptionPlan.tr,
                      //                 style: regular16TextStyle(cWhiteColor),
                      //               )),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     const Expanded(
                      //       child: SizedBox(),
                      //     ),
                      //     SvgPicture.asset(
                      //       kiVidflix,
                      //       width: 24.w,
                      //       height: h24.h,
                      //       color: cPrimaryColor2,
                      //     ),
                      //     kW4sizedBox,
                      //     Text(
                      //       ksVidflix.tr,
                      //       style: semiBold20TextStyle(cWhiteColor),
                      //     ),
                      //   ],
                      // ),      
                   
                   
                    kH8sizedBox,
                    Divider(
                      color: cWhiteColor.withOpacity(0.2),
                    ),
                    kH8sizedBox,
                    Container(
                      width: width-40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        color: cWhiteColor.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k10Padding,vertical: k20Padding), //* in figma: padding: const EdgeInsets.symmetric(horizontal: k20Padding,vertical: k30Padding),
                        child: Row(
                          children: [
                            Container(
                              width: h36.w,
                              height: h36.h,
                              decoration: BoxDecoration(
                                color: cPrimaryColor2,
                                borderRadius: BorderRadius.circular(k8BorderRadius),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(k10Padding),
                                child: SvgPicture.asset(kiCrown,),
                              ),
                            ),
                            kW12sizedBox,
                            Text("You enrolled free plan!",style: medium16TextStyle(cWhiteColor),),
                            // const Expanded(child: SizedBox()),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(k4BorderRadius),
                            //     color: cBlackColor,
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(horizontal: k8Padding,vertical: k6Padding),
                            //     child: Row(
                            //       children: [
                            //         Text(ksUpgrade,style: medium14TextStyle(cWhiteColor),),
                            //         kW4sizedBox,
                            //         const Icon(Icons.keyboard_arrow_down_rounded,size: kIconSize14,color: cWhiteColor,),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    kH16sizedBox,
                    Container(
                      width: width-40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        color: cWhiteColor.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding,vertical: k30Padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Free Lifetime",style: regular16TextStyle(cWhiteColor),),
                            kH20sizedBox,
                            Text("Enjoy Free Entertainment",style: semiBold24TextStyle(cWhiteColor),),
                            kH16sizedBox,
                             Divider(
                              thickness: 1,
                              color: cWhiteColor.withOpacity(0.2),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(kiActiveCheck,width: h14.w,height: h14.h,),
                                kW10sizedBox,
                                Expanded(child: Text("Enjoy unrestricted access to thousands of shows and movies with minimal ads.",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                              ],
                            ),
                            kH12sizedBox,
                            Row(
                              children: [
                                SvgPicture.asset(kiActiveCheck,width: h14.w,height: h14.h,),
                                kW10sizedBox,
                                Expanded(child: Text("Watch on your favorite devices",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                              ],
                            ),
                            kH12sizedBox,
                            Row(
                              children: [
                                SvgPicture.asset(kiActiveCheck,width: h14.w,height: h14.h,),
                                kW10sizedBox,
                                Expanded(child: Text("Switch plans or cancel anytime",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                              ],
                            ),
                            kH12sizedBox,
                            Row(
                              children: [
                                SvgPicture.asset(kiActiveCheck,width: h14.w,height: h14.h,),
                                kW10sizedBox,
                                Expanded(child: Text("World famous movies, Dramas, TVs.",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                              ],
                            ),
                            kH12sizedBox,
                            Row(
                              children: [
                                SvgPicture.asset(kiCheck,width: h14.w,height: h14.h,),
                                kW10sizedBox,
                                Expanded(child: Text("Download from thousands of titles to watch offline",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                              ],
                            ),
                            kH12sizedBox,
                            Row(
                              children: [
                                SvgPicture.asset(kiCheck,width: h14.w,height: h14.h,),
                                kW10sizedBox,
                                Expanded(child: Text("Download from thousands of titles to watch",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                              ],
                            ),
                            kH35sizedBox,
                            CustomElevatedButton(label: ksGetStarted.tr, onPressed: (){
                              Get.toNamed(krPaymentMethodScreen);
                            },buttonColor: cPrimaryColor2,textStyle: regular14TextStyle(cWhiteColor),buttonWidth: width-80,buttonHeight: 40.h,),
                          ],
                        ),
                      ),
                    ),
                   ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                     itemCount: paymentController.subscriptionPlanList.length,
                     separatorBuilder: (context,index)=> kH16sizedBox,
                     itemBuilder: (context,index){
                      return Container(
                      width: width-42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k8BorderRadius),
                        color: cBlackColor,
                        border: Border.all(width: 1,color: cPrimaryColor2.withOpacity(0.5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: k20Padding,vertical: k30Padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(paymentController.subscriptionPlanList[index]!.price.toString(),style: regular16TextStyle(cWhiteColor),),
                            kH20sizedBox,
                            Text(paymentController.subscriptionPlanList[index]?.name??"",style: semiBold24TextStyle(cWhiteColor),),
                            kH16sizedBox,
                             Divider(
                              thickness: 1,
                              color: cWhiteColor.withOpacity(0.2),
                            ),
                            Row(
                              children: [
                                // SvgPicture.asset("Validity",width: h14.w,height: h14.h,),
                                Text("Validity : ",style: regular14TextStyle(cWhiteColor),),
                                // kW10sizedBox,
                                Expanded(child: Text("${paymentController.subscriptionPlanList[index]!.day.toString()} days",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                              ],
                            ),
                            kH10sizedBox,
                            Row(
                              children: [
                                // SvgPicture.asset("Validity",width: h14.w,height: h14.h,),
                                Text("Total Screen : ",style: regular14TextStyle(cWhiteColor),),
                                // kW10sizedBox,
                                Expanded(child: Text("${paymentController.subscriptionPlanList[index]!.screens.toString()} Screens",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                              ],
                            ),
                            // kH12sizedBox,
                            // Row(
                            //   children: [
                            //     SvgPicture.asset(kiActiveCheck,width: h14.w,height: h14.h,),
                            //     kW10sizedBox,
                            //     Expanded(child: Text("Watch on your favorite devices",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                            //   ],
                            // ),
                            // kH12sizedBox,
                            // Row(
                            //   children: [
                            //     SvgPicture.asset(kiActiveCheck,width: h14.w,height: h14.h,),
                            //     kW10sizedBox,
                            //     Expanded(child: Text("Switch plans or cancel anytime",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                            //   ],
                            // ),
                            // kH12sizedBox,
                            // Row(
                            //   children: [
                            //     SvgPicture.asset(kiActiveCheck,width: h14.w,height: h14.h,),
                            //     kW10sizedBox,
                            //     Expanded(child: Text("World famous movies, Dramas, TVs.",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                            //   ],
                            // ),
                            // kH12sizedBox,
                            // Row(
                            //   children: [
                            //     SvgPicture.asset(kiCheck,width: h14.w,height: h14.h,),
                            //     kW10sizedBox,
                            //     Expanded(child: Text("Download from thousands of titles to watch offline",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                            //   ],
                            // ),
                            // kH12sizedBox,
                            // Row(
                            //   children: [
                            //     SvgPicture.asset(kiCheck,width: h14.w,height: h14.h,),
                            //     kW10sizedBox,
                            //     Expanded(child: Text("Download from thousands of titles to watch",style: regular14TextStyle(cWhiteColor).copyWith(height: 1.5),overflow: TextOverflow.clip)),
                            //   ],
                            // ),
                            kH30sizedBox,
                            CustomElevatedButton(label: ksGetStarted.tr, onPressed: (){
                              Get.toNamed(krPaymentMethodScreen);
                            },buttonColor: cPrimaryColor2,textStyle: regular14TextStyle(cWhiteColor),buttonWidth: width-82,buttonHeight: 40.h,),
                          ],
                        ),
                      ),
                    );
                     },),
                    kH20sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

