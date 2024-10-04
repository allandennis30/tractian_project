import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

enum ButtonType { large, small }

class TractianButton extends StatefulWidget {
  const TractianButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonType = ButtonType.large,
    this.backgroundColor = Colors.transparent,
    this.iconPath,
    this.textColor,
    this.isToggle = false,
  });

  final VoidCallback onPressed;
  final String label;
  final ButtonType buttonType;
  final Color backgroundColor;
  final Color? textColor;
  final String? iconPath;
  final bool isToggle;

  @override
  TractianButtonState createState() => TractianButtonState();
}

class TractianButtonState extends State<TractianButton> {
  var isSelected = false.obs;
  var switchTextColor = Colors.white.obs;
  void toggleSelection() {
    if (widget.isToggle) {
      isSelected.value = !isSelected.value;

      switchTextColor.value = isSelected.value ? Colors.white : Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = widget.buttonType == ButtonType.large ? 76.0 : 32.0;

    return Obx(() {
      Color buttonColor =
          isSelected.value ? Colors.blue : widget.backgroundColor;

      return SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: () {
            toggleSelection();
            widget.onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            textStyle: TextStyle(
              fontSize: widget.buttonType == ButtonType.large ? 18.0 : 12.0,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.iconPath != null) ...[
                SvgPicture.asset(
                  widget.iconPath!,
                  width: 24.0,
                  height: 24.0,
                ),
                const SizedBox(width: 12),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: switchTextColor.value,
                  fontFamily: 'Roboto',
                ),
              ),
              if (!widget.isToggle) const Spacer()
            ],
          ),
        ),
      );
    });
  }
}
