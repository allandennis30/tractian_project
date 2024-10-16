import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TractianIconProvider {
  static Widget getIcon(String iconName,
      {double width = 22, double height = 22}) {
    switch (iconName) {
      case 'local':
        return SvgPicture.asset(
          'assets/icons/local.svg',
          width: width,
          height: height,
        );
      case 'asset':
        return SvgPicture.asset(
          'assets/icons/asset.svg',
          width: width,
          height: height,
        );
      case 'component':
        return SvgPicture.asset(
          'assets/icons/component.svg',
          width: width,
          height: height,
        );
      case 'energy':
        return SvgPicture.asset(
          'assets/icons/energy.svg',
          width: 12,
          height: 12,
        );
      case 'alert':
        return SvgPicture.asset(
          'assets/icons/alert.svg',
          width: 12,
          height: 12,
        );
      default:
        return const Icon(
          Icons.help_outline,
          size: 16.0,
          color: Colors.black,
        );
    }
  }
}
