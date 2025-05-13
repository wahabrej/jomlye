
import 'package:vidflix_flutter_app/utils/constants/imports.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool?> onChanged;
  final TextStyle textStyle;
  final double? width, height;
  final Color? fillColorl,borderColor;

  const CustomCheckBox({
    required this.value,
    required this.label,
    required this.onChanged,
    required this.textStyle,
    super.key,
    this.width,
    this.height,
    this.fillColorl,
    this.borderColor,
  });

  Widget buildCheckBox() {
    return Container(
      width: width ?? (isDeviceScreenLarge() ? h18 : h16),
      height: height ?? (isDeviceScreenLarge() ? h18 : h16),
      decoration: BoxDecoration(
        border: Border.all(color: value ? cWhiteColor : borderColor ?? cWhiteColor, width: 1),
        borderRadius: BorderRadius.circular(k4BorderRadius.r),
        color: value ? cPrimaryColor2 : fillColorl ?? cBlackColor,
      ),

      child: value
          ? Icon(
              Icons.check,
              color: cWhiteColor,
              size: isDeviceScreenLarge() ? kIconSize14 : kIconSize12,
            )
          : null,
    );
  }

  Widget buildLabel() {
    return Expanded(
      child: Text(
        label.toString(),
        textAlign: TextAlign.justify,
        style: textStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: cTransparentColor,
      onTap: () => onChanged(value),
      child: Container(
        width: 150,
        color: cTransparentColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCheckBox(),
              const SizedBox(width: 8),
              buildLabel(),
              kEmptySizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
