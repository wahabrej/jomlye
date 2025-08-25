import 'package:flixoo_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: k20Padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 160.w,
                  height: 160.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cWhiteColor.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(k50Padding),
                    child: SvgPicture.asset(
                      kiCheck2,
                      color: cPrimaryColor2,
                    ),
                  ),
                ),
              ),
              kH24sizedBox,
              Text(
                "Free plan subscription is successful!",
                style: semiBold20TextStyle(cWhiteColor),
              ),
              kH12sizedBox,
              Text(
                ksLetsContinueEnjoyingflixoo.tr,
                style: medium16TextStyle(
                  cWhiteColor.withOpacity(0.5),
                ),
              ),
              kH12sizedBox,
              Container(
                width: width - 40,
                decoration: BoxDecoration(
                  color: cBlackColor2,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(k20Padding),
                  child: Column(
                    children: [
                      PaymentScreenCommonRow(
                        title: "Plan name",
                        subTitle: "Free Plan",
                      ),
                      kH12sizedBox,
                      PaymentScreenCommonRow(
                        title: "Plan cost",
                        subTitle: "\$0.00",
                      ),
                      kH12sizedBox,
                      PaymentScreenCommonRow(
                        title: "Validity",
                        subTitle: "Lifetime",
                      ),
                      kH12sizedBox,
                      PaymentScreenCommonRow(
                        title: "Account Connect limit",
                        subTitle: "1",
                      ),
                      kH12sizedBox,
                      PaymentScreenCommonRow(
                        title: "Expire date",
                        subTitle: "Unlimited",
                      ),
                      kH12sizedBox,
                      PaymentScreenCommonRow(
                        title: "Ads",
                        subTitle: "Allowed",
                      ),
                      kH12sizedBox,
                      PaymentScreenCommonRow(
                        title: "Download",
                        subTitle: "Not Allowed",
                      ),
                      kH12sizedBox,
                      PaymentScreenCommonRow(
                        title: "Premium Content",
                        subTitle: "Not Allowed",
                      ),
                    ],
                  ),
                ),
              ),
              kH30sizedBox,
              CustomElevatedButton(
                label: ksBackToHome,
                onPressed: () {
                  Get.offAllNamed(krHomeScreen);
                },
                buttonHeight: 40.h,
                buttonColor: cPrimaryColor2,
                buttonWidth: width - 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentScreenCommonRow extends StatelessWidget {
  const PaymentScreenCommonRow(
      {super.key, required this.title, required this.subTitle});
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title: ",
          style: regular16TextStyle(cWhiteColor),
        ),
        Text(
          subTitle,
          style: regular16TextStyle(cWhiteColor),
        ),
      ],
    );
  }
}
