import 'package:vidflix_flutter_app/controllers/common/global_controller.dart';
import 'package:vidflix_flutter_app/controllers/profile/profile_controller.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_button.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/textfield/custom_textfield.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: cBlackColor,
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSize.h),
        //* info:: appBar
        child: CustomAppBar(
          hasBackButton: false,
          title: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 80.w,
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
                      ksBack.tr,
                      style: regular16TextStyle(cWhiteColor),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
        body: Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                //         kH24sizedBox,
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: [
                //             CustomElevatedButton(
                //                 label: ksBack,
                //                 onPressed: () {
                //                   Get.back();
                //                 },
                //                 prefixIcon: Icons.arrow_back_ios,
                //                 prefixIconColor: cWhiteColor,
                //                 buttonWidth: 80,
                //                 buttonHeight: 32,
                //                 buttonColor: cWhiteColor.withOpacity(0.1),
                //         isCircularHead: true),
                //   ],
                // ),
                kH20sizedBox,
                Text(
                  ksFillYourProfile,
                  style: semiBold24TextStyle(cWhiteColor),
                ),
                kH60sizedBox,
       profileController.profileImageFile.value == null ? Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: cWhiteColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          profileController.getUserImage.value,
                          width: 50,
                          height: 50,
                          color: cWhiteColor,
                                 errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                      Icons.person,
                                      size: 80,
                                      color: cPrimaryColor2,
                                    ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            showImageSourcePopup(context);
                          },
                          child: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cWhiteColor,
                              border:
                                  Border.all(width: 1, color: cPrimaryColor2),
                            ),
                            // child: SvgPicture.asset(kiEditProfile,width: 14.w,height: 14.w,),
                            child: Center(
                                child: Image.asset(
                              kiEditProfile,
                              width: 14.w,
                              height: 14.w,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ):Stack(
                  children: [
                            //  Center(
                            //                 child: Container(
                            //                   width: 100.w,
                            //                   height: 100.h,
                            //                   decoration: const BoxDecoration(
                            //                     shape: BoxShape.circle,
                            //                   ),
                            //                   child: CircleAvatar(
                            //                     backgroundColor: cWhiteColor.withOpacity(0.2),
                            //                     child: Image.file(
                            //                       width: 100.w,
                            //                       height: 100.h,
                            //                       fit: BoxFit.cover,
                            //                       profileController
                            //                           .profileImageFile
                            //                           .value!,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                        Center(
                        child: Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: cPrimaryColor2.withOpacity(0.2),
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: cPrimaryColor2.withOpacity(0.2),
                            child: ClipOval(
                              child: Image.file(
                                width: 98.w,
                                height: 98.h,
                                fit: BoxFit.fill,
                                profileController.profileImageFile.value!,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 60,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 0,
                      left: 60.w,
                      right: 0,
                      child: InkWell(
                        onTap: (){
                          profileController.isProfileImageChnaged.value = false;
                          profileController.profileImageLink.value = "";
                          profileController.profileImageFile.value = null;
                        },
                        child: Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: cWhiteColor,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1,color: cRedColor),
                          ),
                          child: const Icon(Icons.close,size: 12,color: cRedColor,),
                        ),
                      ),
                    ),
                  ],
                ),
                kH20sizedBox,
                Text(
                  ksFirstName.tr,
                  style: regular16TextStyle(cWhiteColor),
                ),
                kH8sizedBox,
                SizedBox(
                  height: kTextFieldHeight,
                  child: CustomModifiedTextField(
                    hint: ksEnterHere.tr,
                    controller: profileController.firstNameTextEditingController,
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
                kH12sizedBox,
                Text(
                  ksLastName.tr,
                  style: regular16TextStyle(cWhiteColor),
                ),
                kH8sizedBox,
                SizedBox(
                  height: kTextFieldHeight,
                  child: CustomModifiedTextField(
                    hint: ksEnterHere.tr,
                    controller: profileController.lastNameTextEditingController,
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
                kH12sizedBox,
                Text(
                  ksPhoneNumber.tr,
                  style: regular16TextStyle(cWhiteColor),
                ),
                kH8sizedBox,
                  SizedBox(
                  height: kTextFieldHeight,
                  child: CustomModifiedTextField(
                    hint: ksEnterHere.tr,
                    controller: profileController.phoneTextEditingController,
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
                // Container(
                //         height: kTextFieldHeight.h,
                //         alignment: Alignment.center,
                //         padding: EdgeInsets.only(left: 12.w, right: 4.w),
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           border: Border.all(color: const Color(0xffF4F4F4)),
                //           borderRadius: BorderRadius.all(
                //             Radius.circular(5.r),
                //           ),
                //         ),
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Expanded(
                //               flex: 7,
                //               child: CountryPickerDropdown(
                //                 //itemFilter:  (c) => ['GB'].contains(c.isoCode),
                //                 initialValue: 'BD',
                //                 isFirstDefaultIfInitialValueNotProvided:
                //                     false,
                //                 isExpanded: true,
                //                 itemBuilder: (Country country) => Row(
                //                   children: <Widget>[
                //                     CountryPickerUtils.getDefaultFlagImage(
                //                         country),
                //                     Text("+${country.phoneCode}"),
                //                   ],
                //                 ),
                //                 onValuePicked: (Country country) {
                //                   // setState(() {
                //                   //   phoneCode = country.phoneCode;
                //                   // });
                //                 },
                //               ),
                //             ),
                //             Expanded(
                //               flex: 9,
                //               child: TextFormField(
                //                 controller: profileController.phoneNumberTextEditingController,
                //                 keyboardType: TextInputType.phone,
                //                 decoration: InputDecoration(
                //                   contentPadding: EdgeInsets.only(
                //                     left: 8.w,
                //                     right: 8.w,
                //                     bottom: 5.h,
                //                   ),
                //                   border: InputBorder.none,
                //                   hintText: ksEnterHere,
                //                   hintStyle: regular14TextStyle(cWhiteColor),
                //                 ),
                //                 onChanged: (value) {},
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),

// SizedBox(
//   height: 46.h,
//   child: IntlPhoneField(
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.black, // Background color
//                 // labelText: 'Phone Number',
//                 // labelStyle: TextStyle(color: Colors.white54),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.white24),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.white24),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               initialCountryCode: 'BD', // Default to Bangladesh
//               dropdownIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
//               showCountryFlag: true, // Show country flag
//               disableLengthCheck: true, // Avoid length restriction issues
//               showDropdownIcon: true, // Show dropdown icon
//               style: TextStyle(color: Colors.white),
//               onChanged: (phone) {
//                 // setState(() {
//                 //   phoneNumber = phone.completeNumber; // Store full number
//                 // });
//                 print(phone.completeNumber); // Full number with country code
//               },
//             ),
// ),
                kH12sizedBox,
                Text(
                  ksEmailAddress.tr,
                  style: regular16TextStyle(cWhiteColor),
                ),
                kH8sizedBox,
                SizedBox(
                  height: kTextFieldHeight,
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
                kH12sizedBox,
                Text(
                  ksGender.tr,
                  style: regular16TextStyle(cWhiteColor),
                ),
                kH8sizedBox,
                GestureDetector(
                  onTap: () {
                    Get.find<GlobalController>().commonBottomSheet(
                        context: context,
                        bottomSheetColor: cBlackColor2,
                        content: GenderContent(),
                        bottomSheetHeight: height * 0.3,
                        onPressCloseButton: () {
                          Get.back();
                        },
                        onPressRightButton: () {},
                        rightText: "",
                        rightTextStyle: semiBold14TextStyle(cPrimaryColor2),
                        title: ksSelectGender.tr,
                        isRightButtonShow: false,
                        isBottomSheetRightButtonActive: true.obs);
                  },
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Text(
                            profileController.selectedGender.value.isEmpty
                                ? ksSelectGender.tr
                                : profileController.selectedGender.value,
                            style: semiBold14TextStyle(cWhiteColor),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                kH20sizedBox,
                Row(
                  children: [
                    CustomElevatedButton(
                      label: ksCancel.tr,
                      onPressed: () {
                        Get.back();
                      },
                      buttonWidth: (width - 56) / 2,
                      buttonHeight: kButtonHeight.h,
                      buttonColor: cWhiteColor.withOpacity(0.2),
                    ),
                    kW16sizedBox,
                    CustomElevatedButton(
                      label: ksContinue.tr,
                      onPressed: () async{
                        await profileController.updateProfile();
                      },
                      buttonWidth: (width - 56) / 2,
                      buttonHeight: kButtonHeight.h,
                      buttonColor: cPrimaryColor2,
                    ),
                  ],
                ),
                kH40sizedBox,
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class GenderContent extends StatelessWidget {
  GenderContent({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            kH8sizedBox,
            ListView.separated(
                separatorBuilder: (context, index) => kH12sizedBox,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profileController.genderList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                    child: InkWell(
                      onTap: () {
                        profileController.selectedGender.value =
                            profileController.genderList[index];
                            Get.back();
                      },
                      child: Container(
                        width: width - 40,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(k6BorderRadius),
                          border: Border.all(
                              width: 1,
                              color: profileController.selectedGender.value == profileController.genderList[index]
                                  ? cPrimaryColor2:cLineColor),
                          color:cBlackColor2,
                          // color: profileController.selectedGender.value == profileController.genderList[index]
                          //     ? cPrimaryColor2.withOpacity(0.2) : cBlackColor2,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(k8Padding),
                          child: Text(
                            profileController.genderList[index],
                            style: medium14TextStyle(cWhiteColor),
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ));
  }
}

void showGenderMenu(BuildContext context, ProfileController controller) {
  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        offset.dy + renderBox.size.height * 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    items: controller.genderList.map((String gender) {
      return PopupMenuItem<String>(
        value: gender,
        child: Text(gender),
        onTap: () {
          Future.delayed(Duration.zero, () {
            controller.selectedGender.value = gender;
          });
        },
      );
    }).toList(),
  );
}

void showImageSourcePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(k8BorderRadius.r),
        // ),
        backgroundColor: cBlackColor2,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: k20Padding, vertical: k40Padding),
          width: width.w,
          decoration: BoxDecoration(
            color: cBlackColor2,
            borderRadius: BorderRadius.circular(k16BorderRadius.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ksSelectImageSource.tr,
                style: semiBold16TextStyle(cWhiteColor),
              ),
              kH20sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                       Get.back();
                      Get.find<GlobalController>().selectImageSource(
                          Get.find<ProfileController>().isProfileImageChnaged,
                          Get.find<ProfileController>().profileImageLink,
                          Get.find<ProfileController>().profileImageFile,
                          "camera");
                    },
                    child: Container(
                      width: (width * 0.6) / 2,
                      height: 36.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k4BorderRadius.r),
                        color: cPrimaryColor2,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: k16Padding.w),
                        child: Center(
                            child: Text(
                          ksCamera,
                          style: medium14TextStyle(cWhiteColor),
                        )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      Get.find<GlobalController>().selectImageSource(
                          Get.find<ProfileController>().isProfileImageChnaged,
                          Get.find<ProfileController>().profileImageLink,
                          Get.find<ProfileController>().profileImageFile,
                          "gallery");
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.6) / 2,
                      height: 36.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(k4BorderRadius.r),
                        color: cPrimaryColor2,
                      ),
                      child: Center(
                          child: Text(
                        ksGallery,
                        style: medium14TextStyle(cWhiteColor),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showCongratulationsPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();
        Get.toNamed(krProfileScreen);
      });
      return Dialog(
          backgroundColor: cBlackColor2,
          child: Container(
            width: width - 90,
            height: height * 0.46,
            // color: cBlackColor2,
            decoration: BoxDecoration(
              color: cBlackColor2,
              borderRadius: BorderRadius.circular(k8BorderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: k20Padding),
              child: Column(
                children: [
                  kH40sizedBox,
                  Stack(
                    children: [
                      Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: cPrimaryColor2,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(k25Padding),
                          child: SvgPicture.asset(
                            kiUser,
                            width: 50.w,
                            height: 50.h,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 0,
                        child: Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: cWhiteColor),
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        left: 0,
                        child: Container(
                          width: 10.w,
                          height: 10.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: cWhiteColor),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 50,
                        right: 50,
                        child: Container(
                          width: 4.w,
                          height: 4.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: cWhiteColor),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 40,
                        child: Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: cWhiteColor),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 40,
                        child: Container(
                          width: 16.w,
                          height: 16.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: cWhiteColor),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        // bottom: 0,
                        right: 0,
                        child: Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: cWhiteColor),
                        ),
                      ),
                    ],
                  ),
                  kH24sizedBox,
                  Text(
                    "Congratulations Mark!",
                    style: medium16TextStyle(cWhiteColor),
                  ),
                  kH12sizedBox,
                  Text(
                    "Your account has been created successfully. Welcome aboard! Start exploring a world of movies, TV shows, and series tailored just for you. Enjoy your journey!",
                    style: regular14TextStyle(cWhiteColor.withOpacity(0.8)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ));
    },
  );
}
