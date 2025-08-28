import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flixoo_flutter_app/controllers/common/global_controller.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';
import 'package:flixoo_flutter_app/controllers/payment/payment_controller.dart';

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
                          style: regular14TextStyle(cWhiteColor.withOpacity(
                            0.5,
                          )),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : paymentController.isPaymentHistoryLoading.value
                    ? const CircularProgressIndicator()
                    : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 560.h,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(k0Padding),
                                  separatorBuilder: (context, index) =>
                                      kH10sizedBox,
                                      // physics: const NeverScrollableScrollPhysics(),
                                  itemCount: paymentController
                                      .paymentHistoryList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.find<GlobalController>()
                                            .commonBottomSheet(
                                                context: context,
                                                content:
                                                    PaymentHistoryBottomSheetContent(
                                                  timeAndDate: DateFormat(
                                                          'dd/MM/yyyy, hh:mm a')
                                                      .format(paymentController
                                                          .paymentHistoryList[
                                                              index]!
                                                          .createdAt!),
                                                          paymentMethod:  "${paymentController.paymentHistoryList[index]?.paymentMethod}",
                                                          
                                                  amount:
                                                      "${Get.find<GlobalController>().currency.value}${paymentController.paymentHistoryList[index]?.price}",
                                                      transactionId: "${paymentController.paymentHistoryList[index]?.trxId}",
                                                ),
                                                onPressCloseButton: () {},
                                                onPressRightButton: () {},
                                                rightText: "Done",
                                                rightTextStyle:
                                                    regular14TextStyle(
                                                        cWhiteColor),
                                                title: "Package Name",
                                                isRightButtonShow: false,
                                                bottomSheetColor:
                                                    cBlackColor2);
                                      },
                                      child: PaymentHistoryWidget(
                                          image: kiCrown,
                                          packageName: "Package Name",
                                          transactionId: paymentController
                                                  .paymentHistoryList[index]
                                                  ?.trxId ??
                                              "",
                                          price:
                                              "${Get.find<GlobalController>().currency.value}${paymentController.paymentHistoryList[index]?.price}",
                                          dateTime: DateFormat(
                                                  'dd/MM/yyyy, hh:mm a')
                                              .format(paymentController
                                                  .paymentHistoryList[index]!
                                                  .createdAt!)),
                                    );
                                  }),
                            ),
                          ],
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
                  packageName ?? "",
                  style: medium16TextStyle(cWhiteColor),
                ),
                kH6sizedBox,
                SizedBox(
                  width: (width*0.4),
                  child: Text(
                    "Transaction ID: $transactionId",
                    style: regular12TextStyle(cWhiteColor),
                    overflow: TextOverflow.ellipsis,
                  ),
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
                    price ?? "",
                    style: medium16TextStyle(cPrimaryColor2),
                    overflow: TextOverflow.ellipsis,
                  ),
                  kH6sizedBox,
                  Text(
                    dateTime ?? "",
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

class PaymentHistoryBottomSheetContent extends StatelessWidget {
  const PaymentHistoryBottomSheetContent(
      {super.key, this.timeAndDate, this.amount, this.transactionId,this.paymentMethod});
  final String? timeAndDate, amount, transactionId,paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kH16sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Row(
            children: [
              SizedBox(
                width: (width - 56) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ksPaymentGetway.tr,
                      style: regular14TextStyle(cWhiteColor),
                    ),
                    kH10sizedBox,
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: cWhiteColor.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(k6BorderRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              paymentMethod??"",
                              style: regular14TextStyle(cWhiteColor),
                            ),
                            // Image.network(
                            //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcuU7XHlUY2MShKGdYaPQb2GmaEOpyX0AJgg&s",
                            //   width: 24.w,
                            //   height: 24.h,
                            //   errorBuilder: (context, error, stackTrace) {
                            //     return SvgPicture.asset(
                            //       kiMoney,
                            //       width: 20.w,
                            //       height: 20.h,
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kW16sizedBox,
              SizedBox(
                width: (width - 56) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ksTimeAndDate.tr,
                      style: regular14TextStyle(cWhiteColor),
                    ),
                    kH10sizedBox,
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: cWhiteColor.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(k6BorderRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              timeAndDate ?? "",
                              style: regular14TextStyle(cWhiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        kH16sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Row(
            children: [
              SizedBox(
                width: (width - 56) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ksAmount.tr,
                      style: regular14TextStyle(cWhiteColor),
                    ),
                    kH10sizedBox,
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: cWhiteColor.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(k6BorderRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              amount ?? "",
                              style: regular14TextStyle(cWhiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kW16sizedBox,
              SizedBox(
                width: (width - 56) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ksTransactionId.tr,
                      style: regular14TextStyle(cWhiteColor),
                    ),
                    kH10sizedBox,
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: cWhiteColor.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(k6BorderRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(k12Padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                transactionId ?? "",
                                style: regular14TextStyle(cWhiteColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: transactionId ?? ""));
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //       content: Text('Copied to clipboard ')),
                                  // );
                                },
                                child: SvgPicture.asset(kiCopy)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
