import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: k20Padding),
            child: Obx(
              () => Column(
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
                                  ksSelectMethod.tr,
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
                  Text(
                    ksOnlinePayment.tr,
                    style: semiBold16TextStyle(cWhiteColor),
                  ),
                  kH16sizedBox,
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: k10Padding,
                      mainAxisSpacing: k10Padding,
                      childAspectRatio: 1.02,
                    ),
                    itemCount: profileController.paymentMethodList.length,
                    itemBuilder: (context, index) {
                      return Obx(() => InkWell(
                            splashColor: cTransparentColor,
                            highlightColor: cTransparentColor,
                            onTap: () {
                              profileController
                                  .selectedPaymentMethodIndex.value = index;
                            },
                            child: Container(
                              width: (width - 70) / 4,
                              height: 80.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(k6BorderRadius),
                                color: cWhiteColor.withOpacity(0.1),
                                border: Border.all(
                                    width: 1,
                                    color: profileController
                                                .selectedPaymentMethodIndex
                                                .value ==
                                            index
                                        ? cPrimaryColor2
                                        : cTransparentColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(k16Padding),
                                child: Image.network(
                                    profileController.paymentMethodList[index],fit: BoxFit.cover,),
                              ),
                            ),
                          ));
                    },
                  ),
                  kH30sizedBox,
                  CustomElevatedButton(
                    label: ksStartPlan.tr,
                    onPressed: () {
                      Get.toNamed(krPaymentSuccessScreen);
                    },
                    buttonColor: cPrimaryColor2,
                    buttonHeight: 40.h,
                    buttonWidth: width - 40,
                    textStyle: regular14TextStyle(cWhiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
