import 'dart:developer';
import 'package:flixoo_flutter_app/utils/constants/imports.dart';

void heightWidthKeyboardValue(context) {
  height = MediaQuery.of(context).size.height;
  width = MediaQuery.of(context).size.width;
  keyboardValue = MediaQuery.of(context).viewInsets.bottom;
}

double getPaddingTop(context) => MediaQuery.of(context).padding.top;

void unFocus(context) {
  FocusScope.of(context).unfocus();
}

void ll(message) {
  log(message.toString());
}


// show alert dialog
Future<dynamic> showAlertDialog({context, child}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) => child,
  );
}

bool isDeviceScreenLarge() {
  if (height > kSmallDeviceSizeLimit) {
    return true;
  } else {
    return false;
  }
}

void unfocus(context) {
  FocusScope.of(context).unfocus();
}

  // void showSnackBar({required String title, required String message, required Color color, duration}) {
  //   Get.snackbar(
  //     title,
  //     message,
  //     backgroundColor: color,
  //     colorText: cWhiteColor,
  //     maxWidth: 400,
  //     duration: Duration(milliseconds: duration ?? 1500),
  //   );
  // }
//   void showSnackBar({
//   String? title,
//   required String message,
//   required Color color,
//   int? duration,
// }) {
//   if (title == null || title.trim().isEmpty) {
//     // show only message
//     Get.snackbar(
//       "",
//       message,
//       titleText: const SizedBox.shrink(),
//       backgroundColor: color,
//       colorText: cWhiteColor,
//       maxWidth: 400,
//       duration: Duration(milliseconds: duration ?? 1500),
//     );
//   } else {
//     // show both title + message
//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: color,
//       colorText: cWhiteColor,
      
//       maxWidth: 400,
//       duration: Duration(milliseconds: duration ?? 1500),
//     );
//   }
// }
void showSnackBar({
  String? title,
  required String message,
  required Color color,
  int? duration,
}) {
  if (title == null || title.trim().isEmpty) {
    // show only message
    Get.snackbar(
      "",
      "",
      titleText: const SizedBox.shrink(), // no title
      messageText: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w600, // bold 600
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      backgroundColor: color,
      colorText: cWhiteColor,
      maxWidth: 400,
      duration: Duration(milliseconds: duration ?? 1500),
    );
  } else {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      backgroundColor: color,
      colorText: cWhiteColor,
      maxWidth: 400,
      duration: Duration(milliseconds: duration ?? 1500),
    );
  }
}




