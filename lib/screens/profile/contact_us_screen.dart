import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});
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
              width: 120.w,
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
                      ksContactUs.tr,
                      style: regular16TextStyle(cWhiteColor),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 1,
                color: cWhiteColor.withOpacity(0.2),
              ),
              kH8sizedBox,
              SizedBox(
                  width: width,
                  height: 92.h,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(k6BorderRadius),
                      child: Image.asset(
                        kiContactUsPng,
                        width: width,
                        fit: BoxFit.cover,
                      ))),
              kH16sizedBox,
              Text(
                ksFullName.tr,
                style: medium16TextStyle(cWhiteColor),
              ),
              kH8sizedBox,
              SizedBox(
                height: 46,
                child: CustomModifiedTextField(
                  hint: ksEnterName.tr,
                  controller: profileController.fullNameTextEditingController,
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
              kH16sizedBox,
              Text(
                ksEmail.tr,
                style: semiBold16TextStyle(cWhiteColor),
              ),
              kH8sizedBox,
              SizedBox(
                height: 46,
                child: CustomModifiedTextField(
                  hint: ksEnterEmailAddress.tr,
                  controller: profileController.emailTextEditingController,
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
               kH16sizedBox,
              Text(
                ksSubject.tr,
                style: semiBold16TextStyle(cWhiteColor),
              ),
              kH8sizedBox,
              SizedBox(
                height: 46,
                child: CustomModifiedTextField(
                  hint: ksEnterSubject.tr,
                  controller: profileController.subjectTextEditingController,
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
               kH16sizedBox,
              Text(
                ksMessage.tr,
                style: semiBold16TextStyle(cWhiteColor),
              ),
              kH8sizedBox,
              SizedBox(
                child: CustomModifiedTextField(
                  hint: ksWriteYourMessage.tr,
                  controller: profileController.messageTextEditingController,
                  maxLines: 5,
                  inputType: TextInputType.multiline,
                  inputAction: TextInputAction.newline,
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
              kH20sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(label: ksSend.tr, onPressed: (){},buttonColor: cPrimaryColor2,buttonWidth: 120.w,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
