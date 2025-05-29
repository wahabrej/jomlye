import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});
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
          title: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 200.w,
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
                    SizedBox(
                      width: 160.w,
                      child: Center(
                          child: Text(
                        ksFrequentlyAskedQuestions.tr,
                        style: regular16TextStyle(cWhiteColor),
                        overflow: TextOverflow.ellipsis,
                      )),
                    ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 1,
                color: cWhiteColor.withOpacity(0.2),
              ),
              kH16sizedBox,
              Text(
                ksPurchaseAndPayment.tr,
                style: semiBold20TextStyle(cWhiteColor),
              ),
              kH12sizedBox,
              ListView.separated(
                  shrinkWrap: true,
                  padding:  EdgeInsets.zero,
                   separatorBuilder: (context, index) => kH16sizedBox,
                  itemCount: profileController.paymentFaqList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(() => InkWell(
                      splashColor: cTransparentColor,
                      highlightColor: cTransparentColor,
                          onTap: () {
                            profileController.selectedPaymentFaqIndex.value = index;
                          },
                          child:
                              profileController.selectedPaymentFaqIndex.value == index
                                  ? 
                                  Container(
                                    decoration: BoxDecoration(
                                      color: cWhiteColor.withOpacity(0.2),
                                      border: Border.all(width: 0.5,color: cPrimaryColor2),
                                      borderRadius: BorderRadius.circular(k12BorderRadius),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Padding(
                                           padding: const EdgeInsets.only(top: k20Padding,right: k20Padding,left: k20Padding),
                                           child: Row(
                                             children: [
                                               SizedBox(
                                                width: width-101,
                                                 child: Text(
                                                  profileController
                                                          .paymentFaqList[index]?.question??"",
                                                  style: medium16TextStyle(cWhiteColor),
                                                  overflow: TextOverflow.clip,
                                                  ),
                                               ),
                                             const Expanded(child: SizedBox(),),
                                              Padding(
                                               padding: const EdgeInsets.only(bottom: k10Padding),
                                               child:  InkWell(
                                                splashColor: cTransparentColor,
                                                highlightColor: cTransparentColor,
                                                onTap: (){
                                                  profileController.selectedPaymentFaqIndex.value = -1;
                                                },
                                                child: const Icon(Icons.minimize_sharp,color: cPrimaryColor2,size: kIconSize20,)),
                                             ),
                                             ],
                                           ),
                                         ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: k20Padding,right: k20Padding,bottom: k20Padding,top: k16Padding),
                                              child: SizedBox(
                                                width: width-105,
                                                child: Text(profileController
                                                              .paymentFaqList[index]?.answer??"",style: regular14TextStyle(cWhiteColor.withOpacity(0.7),),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                  : Row(
                                      children: [
                                        Text(
                                          profileController
                                                  .paymentFaqList[index]?.question??"",
                                          style: medium16TextStyle(cWhiteColor),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        kW20sizedBox,
                                        const Icon(
                                          Icons.add,
                                          size: kIconSize16,
                                          color: cWhiteColor,
                                        ),
                                      ],
                                    ),
                        ));
                  },
                 ),
            kH20sizedBox,
            Text(
                ksOrder.tr,
                style: semiBold20TextStyle(cWhiteColor),
              ),
              kH12sizedBox,
              ListView.separated(
                  shrinkWrap: true,
                  padding:  EdgeInsets.zero,
                   separatorBuilder: (context, index) => kH16sizedBox,
                  itemCount: profileController.orderFaqList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(() => InkWell(
                      splashColor: cTransparentColor,
                      highlightColor: cTransparentColor,
                          onTap: () {
                            profileController.selectedOrderFaqIndex.value = index;
                          },
                          child:
                              profileController.selectedOrderFaqIndex.value == index
                                  ? 
                                  Container(
                                    decoration: BoxDecoration(
                                      color: cWhiteColor.withOpacity(0.2),
                                      border: Border.all(width: 0.5,color: cPrimaryColor2),
                                      borderRadius: BorderRadius.circular(k12BorderRadius),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Padding(
                                           padding: const EdgeInsets.only(top: k20Padding,right: k20Padding,left: k20Padding),
                                           child: Row(
                                             children: [
                                               SizedBox(
                                                width: width-101,
                                                 child: Text(
                                                  profileController
                                                          .orderFaqList[index]?.question??"",
                                                  style: medium16TextStyle(cWhiteColor),
                                                  overflow: TextOverflow.clip,
                                                  ),
                                               ),
                                             const Expanded(child: SizedBox(),),
                                              Padding(
                                               padding: const EdgeInsets.only(bottom: k10Padding),
                                               child:  InkWell(
                                                splashColor: cTransparentColor,
                                                highlightColor: cTransparentColor,
                                                onTap: (){
                                                  profileController.selectedOrderFaqIndex.value = -1;
                                                },
                                                child: const Icon(Icons.minimize_sharp,color: cPrimaryColor2,size: kIconSize20,)),
                                             ),
                                             ],
                                           ),
                                         ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: k20Padding,right: k20Padding,bottom: k20Padding,top: k16Padding),
                                              child: SizedBox(
                                                width: width-105,
                                                child: Text(profileController
                                                              .orderFaqList[index]?.answer??"",style: regular14TextStyle(cWhiteColor.withOpacity(0.7),),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                  : Row(
                                      children: [
                                        Text(
                                          profileController
                                                  .orderFaqList[index]?.question??"",
                                          style: medium16TextStyle(cWhiteColor),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        kW20sizedBox,
                                        const Icon(
                                          Icons.add,
                                          size: kIconSize16,
                                          color: cWhiteColor,
                                        ),
                                      ],
                                    ),
                        ));
                  },
                 ),
           
           
            ],
          ),
        ),
      ),
    );
  }
}
