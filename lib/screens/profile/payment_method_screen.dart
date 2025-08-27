import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/controllers/profile/profile_controller.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({
    super.key,
    required this.paymentType,
    required this.planId,
    required this.videoType,
    this.payableAmount
  });
  final String paymentType, planId, videoType;
  final double? payableAmount;

  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSize.h),
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
                            ksSelectPaymentMethod.tr,
                            style: regular16TextStyle(cWhiteColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH20sizedBox,
                  Obx(() => Row(
                        children: [
                          InkWell(
                            splashColor: cTransparentColor,
                            highlightColor: cTransparentColor,
                            onTap: () {
                              profileController.selectedPaymentMethod.value =
                                  "offline";
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: (width - 60) / 3,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(k6BorderRadius),
                                    color: cWhiteColor.withOpacity(0.1),
                                    border: Border.all(
                                      width: 1,
                                      color: profileController
                                                  .selectedPaymentMethod
                                                  .value ==
                                              "offline"
                                          ? cPrimaryColor
                                          : cTransparentColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(k16Padding),
                                    child: SvgPicture.asset(
                                      kiOffline,
                                      color: cWhiteColor,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                kH8sizedBox,
                                Text(
                                  "Offline",
                                  style: semiBold14TextStyle(cWhiteColor),
                                ),
                              ],
                            ),
                          ),
                          kW10sizedBox,
                          InkWell(
                            splashColor: cTransparentColor,
                            highlightColor: cTransparentColor,
                            onTap: () async {
                              try {
                                ll("Stripe payment initiated");
                                profileController.selectedPaymentMethod.value =
                                    "stripe";

                                double amount = payableAmount??-1;

                                if (amount <= 0) {
                                  showSnackBar(
                                      title: "Error",
                                      message: "Invalid payment amount",
                                      color: Colors.red);
                                  return;
                                }

                                await profileController
                                    .paymentSheetInitialization(amount, "USD",paymentType,planId,videoType);
                              } catch (e) {
                                if (kDebugMode) {
                                  ll("Error in payment button tap: ${e.toString()}");
                                }
                                showSnackBar(
                                    title: "Error",
                                    message:
                                        "Failed to process payment. Please try again.",
                                    color: Colors.red);
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: (width - 60) / 3,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(k6BorderRadius),
                                    color: cWhiteColor.withOpacity(0.1),
                                    border: Border.all(
                                      width: 1,
                                      color: profileController
                                                  .selectedPaymentMethod
                                                  .value ==
                                              "stripe"
                                          ? cPrimaryColor
                                          : cTransparentColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(k16Padding),
                                    child: SvgPicture.asset(
                                      kiStripe,
                                      color: cWhiteColor,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                kH8sizedBox,
                                Text(
                                  "Stripe",
                                  style: semiBold14TextStyle(cWhiteColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  if (profileController.selectedPaymentMethod.value ==
                      "offline")
                    kH100sizedBox,
                  if (profileController.selectedPaymentMethod.value ==
                      "offline")
                    Text(
                      "Transaction Key",
                      style: semiBold14TextStyle(cWhiteColor),
                    ),
                  if (profileController.selectedPaymentMethod.value ==
                      "offline")
                    kH12sizedBox,
                  if (profileController.selectedPaymentMethod.value ==
                      "offline")
                    SizedBox(
                      height: kTextFieldHeight.h,
                      child: CustomModifiedTextField(
                        hint: ksEnterHere.tr,
                        controller: profileController
                            .transactionKeyTextEditingController,
                        fillColor: cBlackColor,
                        textInputStyle: regular14TextStyle(cWhiteColor),
                        focusBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k6BorderRadius),
                          borderSide: const BorderSide(
                            width: 1,
                            color: cPrimaryColor2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(k6BorderRadius),
                          borderSide: BorderSide(
                            width: 1,
                            color: cWhiteColor.withOpacity(0.3),
                            style: BorderStyle.solid,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  if (profileController.selectedPaymentMethod.value ==
                      "offline")
                    kH30sizedBox,
                  if (profileController.selectedPaymentMethod.value ==
                      "offline")
                    CustomElevatedButton(
                      label: ksStartPlan.tr,
                      onPressed: () {
                        // Get.toNamed(krPaymentSuccessScreen);
                        profileController.offlinePaymentMethod(
                            paymentType: paymentType,
                            planId: planId,
                            videoType: videoType);
                      },
                      buttonColor: cPrimaryColor2,
                      buttonHeight: 40.h,
                      buttonWidth: width - 40,
                      textStyle: regular14TextStyle(cWhiteColor),
                    ),
                ],
              )),
        ),
      ),
    );
  }
}
