import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';
import 'package:vidflix_flutter_app/controllers/payment/payment_controller.dart';

class PaymentHistoryScreen extends StatelessWidget {
 PaymentHistoryScreen({super.key});
 final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k20Padding),
        child: Column(
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
                            ksPaymentHistory.tr,
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
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cWhiteColor.withOpacity(0.2),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: cWhiteColor,
                    size: kIconSize24,
                  ),
                ),
                kW6sizedBox,
                Container(
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
              ],
            ),
            kH8sizedBox,
            Divider(
              thickness: 1,
              color: cWhiteColor.withOpacity(0.2),
            ),
            kH16sizedBox,
            // PaymentHistoryWidget(),
             paymentController.paymentHistoryList.isEmpty
                      ? SizedBox(
                          height: (height * 0.65),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                kiSearchResultPng,
                                width: 200.w,
                                height: 200.h,
                              ),
                              Text(
                                ksNoPaymentHistoryFound.tr,
                                style: medium16TextStyle(cPrimaryColor2),
                              ),
                              kH16sizedBox,
                              Text(
                                ksNoPaymentHistoryFoundPleaseCheckFilter.tr,
                                style:
                                    regular14TextStyle(cWhiteColor.withOpacity(
                                  0.5,
                                )),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : paymentController.isPaymentHistoryLoading.value
                          ? const CircularProgressIndicator()
                          : NotificationListener<ScrollNotification>(
                              onNotification: (scrollNotification) {
                                if (paymentController.paymentHistoryScrollController
                                            .position.userScrollDirection ==
                                        ScrollDirection.reverse &&
                                    scrollNotification.metrics.pixels ==
                                        scrollNotification
                                            .metrics.maxScrollExtent &&
                                    !paymentController.paymentHistoryListScrolled.value) {
                                  paymentController.paymentHistoryListScrolled.value =
                                      true;
                                  if (paymentController.paymentHistoryList.isNotEmpty) {
                                    paymentController.getMorePaymentHistory(null);
                                  }
                                  return true;
                                }
                                return false;
                              },
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(k0Padding),
                          separatorBuilder: (context, index) => kH10sizedBox,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: paymentController.paymentHistoryList.length,
                          itemBuilder: (context, index) {
                            return PaymentHistoryWidget(
                                image: kiCrown,
                                packageName: "Package Name",
                                transactionId: paymentController.paymentHistoryList[index]?.transactionId??"",
                                price: "${Get.find<GlobalController>().currency.value}${paymentController.paymentHistoryList[index]?.amount}",
                                dateTime: DateFormat('dd/MM/yyyy, hh:mm a').format(paymentController.paymentHistoryList[index]!.createdAt!));
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentHistoryWidget extends StatelessWidget {
  const PaymentHistoryWidget(
      {super.key,
      required this.image,
      required this.packageName,
       this.transactionId,
      required this.price,
      required this.dateTime});
  final String? image, packageName, transactionId, price, dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k6BorderRadius),
        color: cWhiteColor.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(k12Padding),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(k8BorderRadius),
                color: cWhiteColor.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: k14Padding),
                child: SvgPicture.asset(
                  kiCrown,
                ),
              ),
            ),
            kW10sizedBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  packageName??"",
                  style: medium16TextStyle(cWhiteColor),
                ),
                kH6sizedBox,
                Text("Transaction ID: $transactionId",
                  style: regular12TextStyle(cWhiteColor),
                ),
              ],
            ),
            kW4sizedBox,
            // const Expanded(child: SizedBox()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price??"",
                    style: medium16TextStyle(cPrimaryColor2),
                     overflow: TextOverflow.ellipsis,
                  ),
                  kH6sizedBox,
                  Text(
                    dateTime??"",
                    style: regular12TextStyle(cWhiteColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: kIconSize12,
              color: cWhiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
