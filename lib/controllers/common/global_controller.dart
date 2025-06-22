import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:vidflix_flutter_app/screens/widgets/common/buttons/custom_text_button.dart';
import 'package:vidflix_flutter_app/services/api_services.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

import 'sp_controller.dart';

class GlobalController extends GetxController {
  final SpController spController = SpController();
  final ApiServices apiServices = ApiServices();

  //* globally handler user name,email, and others
  final RxString userFirstName = RxString("");
  final RxString userLastName = RxString("");
  final RxString  userEmail = RxString("");
  final RxString  userPhone = RxString("");
  final RxString  userImage = RxString("");
  final RxString  userGender = RxString("");
  final RxString  userToken = RxString("");
  final RxInt  userId = RxInt(-1);
  final RxString privacyPolicyUrl = RxString("");
  final RxString paymentPolicyUrl = RxString("");
  final RxString termsAndConditionUrl = RxString("");


  //* info:: common bottom-sheet
  void commonBottomSheet(
      {required context,
      required Widget content,
      required onPressCloseButton,
      required onPressRightButton,
      required String rightText,
      required TextStyle rightTextStyle,
      required String title,
      required bool isRightButtonShow, 
      double? bottomSheetHeight,
      bool? isScrollControlled,
      Color? bottomSheetColor,
      isSearchShow,
      RxBool? isBottomSheetRightButtonActive,
      bool? isTitleShow=true,
      bool? isDismissible}) {
    showModalBottomSheet<void>(
      isDismissible: isDismissible ?? true,
      isScrollControlled: isScrollControlled ?? false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(k16BorderRadius), topRight: Radius.circular(k16BorderRadius)), color: bottomSheetColor ?? cWhiteColor),
              width: width,
              height: MediaQuery.of(context).viewInsets.bottom > 0.0 ? height * .9 : bottomSheetHeight ?? height * .5,
              constraints: BoxConstraints(minHeight: bottomSheetHeight ?? height * .5, maxHeight: height * .9),
              child: Column(
                children: [
                  kH16sizedBox,
                  Container(
                    decoration: BoxDecoration(
                      color: cWhiteColor,
                      borderRadius: k4CircularBorderRadius,
                    ),
                    height: 2,
                    width: width * .1,
                  ),
                  if(isTitleShow==true)
                  kH40sizedBox,
                  if(isTitleShow==true)
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: k20Padding),
                     child: Divider(
                      thickness: 1,
                      color: cWhiteColor.withOpacity(0.1),
                    ),
                   ),
                  // if (isSearchShow == true)
                  //   Padding(
                  //     padding: const EdgeInsets.only(left: k16Padding, right: k16Padding, top: k16Padding),
                  //     child: CustomModifiedTextField(
                  //       borderRadius: h8,
                  //       controller: searchController,
                  //       prefixIcon: BipHip.search,
                  //       suffixIcon: BipHip.voiceFill,
                  //       hint: ksSearch.tr,
                  //       contentPadding: const EdgeInsets.symmetric(horizontal: k16Padding),
                  //       textInputStyle: regular16TextStyle(cBlackColor),
                  //     ),
                  //   ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: content,
                    ),
                  ),
                  kH4sizedBox,
                ],
              ),
            ),
            // Positioned(
            //   top: h12,
            //   left: 5,
            //   child: CustomIconButton(
            //     onPress: onPressCloseButton,
            //     icon: Icons.close,
            //     iconColor: cIconColor,
            //     size: screenWiseSize(kIconSize24, 4),
            //   ),
            // ),
            if(isTitleShow==true)
            Positioned(
              top: h32,
              child: Text(
                title,
                style: medium16TextStyle(cWhiteColor),
              ),
            ),
            if (isRightButtonShow)
              Positioned(
                top: h20,
                right: 10,
                child: Obx(() => CustomTextButton(
                      onPressed: isBottomSheetRightButtonActive!.value ? onPressRightButton : null,
                      icon: Icons.close,
                      text: rightText,
                      textStyle: isBottomSheetRightButtonActive.value ? rightTextStyle : medium14TextStyle(cWhiteColor),//cLineColor2
                    )),
              ),
          ],
        );
      },
    );
  }

   final ImagePicker _picker = ImagePicker();

  Future<bool> selectImageSource(
      RxBool isChanged, imageLink, imageFile, String source,
      [bool? isFromBottomSheet, isList = false]) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        maxHeight: 480,
        maxWidth: 720,
      );
      if (image != null) {
        final File imageTemporary = File(image.path);
        if (isList) {
          imageFile.add(imageTemporary.obs);
        } else {
          imageFile(imageTemporary);
          ll(imageFile.value);
        }
        isChanged.value = true;
        if (isFromBottomSheet != false) {
          // Get.back();
        }
        return true;
      } else {
        ll('image not selected');
        return false;
      }
    } on PlatformException catch (e) {
      ll("Failed to Pick Image $e");
      return false;
    }
  }

}
