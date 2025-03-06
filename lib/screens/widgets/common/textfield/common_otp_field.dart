import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class OtpTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String> onChange;
  final ValueChanged<String>? onCompleted;

  const OtpTextField({
    required this.controller,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.onSubmit,
    required this.onChange,
    this.onCompleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoDismissKeyboard: false,
      textStyle: semiBold18TextStyle(cWhiteColor),
      autoFocus: true,
      autoDisposeControllers: false,
      controller: controller,
      useHapticFeedback: true,
      animationDuration: const Duration(milliseconds: 100),
      showCursor: false,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      appContext: context,
      length: 6,
      onSubmitted: onSubmit,
      onChanged: onChange,
      onCompleted: onCompleted,
      pinTheme: PinTheme(
        borderRadius: BorderRadius.circular(k4BorderRadius),
        activeFillColor: cWhiteColor.withOpacity(0.2),
        inactiveFillColor: cWhiteColor.withOpacity(0.2),
        shape: PinCodeFieldShape.box,
        fieldHeight: 50.h,
        fieldWidth: (width-80)/6,
        inactiveColor: cWhiteColor.withOpacity(0.3),
        activeColor: cWhiteColor.withOpacity(0.3),
        selectedColor: cPrimaryColor2,
        selectedFillColor: cWhiteColor.withOpacity(0.2),
      ),
    );
  }
}