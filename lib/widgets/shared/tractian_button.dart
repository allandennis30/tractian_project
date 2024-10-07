import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_tractian/theme/tractian_colors.dart';

enum ButtonType { large, small }

class TractianButton extends StatefulWidget {
  const TractianButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonType = ButtonType.large,
    this.backgroundColor = Colors.transparent,
    this.centerIconPath,
    this.textColor,
    this.isToggle = false,
    this.leftIconPath,
  });

  final VoidCallback onPressed;
  final String label;
  final ButtonType buttonType;
  final Color backgroundColor;
  final Color? textColor;
  final String? centerIconPath;
  final bool isToggle;
  final String? leftIconPath;

  @override
  TractianButtonState createState() => TractianButtonState();
}

class TractianButtonState extends State<TractianButton> {
  var isSelected = false.obs;
  var switchTextColor = TractianColor.gray700.obs;

  @override
  void initState() {
    super.initState();

    switchTextColor.value =
        widget.isToggle ? TractianColor.gray700 : TractianColor.white;
  }

  void toggleSelection() {
    if (widget.isToggle) {
      isSelected.value = !isSelected.value;

      switchTextColor.value =
          isSelected.value ? TractianColor.white : TractianColor.gray700;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = widget.buttonType == ButtonType.large ? 76.0 : 32.0;

    return Obx(() {
      Color buttonColor = widget.backgroundColor;
      if (widget.isToggle) {
        isSelected.value
            ? buttonColor = TractianColor.primaryBlue
            : buttonColor = TractianColor.white;
      }

      Color borderColor =
          isSelected.value ? TractianColor.primaryBlue : TractianColor.gray200;

      return SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: () {
            toggleSelection();
            widget.onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            elevation: 0,
            textStyle: TextStyle(
                fontSize: widget.buttonType == ButtonType.large ? 18.0 : 14.0,
                fontWeight: widget.buttonType == ButtonType.large
                    ? FontWeight.normal
                    : FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
              side: BorderSide(
                color: borderColor,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.buttonType == ButtonType.small &&
                  widget.leftIconPath != null) ...[
                SvgPicture.asset(
                  widget.leftIconPath!,
                  width: 16.0,
                  height: 16.0,
                  color: switchTextColor.value,
                ),
                const SizedBox(width: 8),
              ],
              if (widget.centerIconPath != null) ...[
                SvgPicture.asset(
                  widget.centerIconPath!,
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
