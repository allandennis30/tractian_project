import 'package:flutter/material.dart';
import 'package:project_tractian/theme/tractian_colors.dart';
import 'package:project_tractian/widgets/shared/tractian_button.dart';

class TractianSearchBarFilter extends StatelessWidget {
  const TractianSearchBarFilter({
    super.key,
    this.onChanged,
    this.hintText = 'Buscar Ativo ou Local',
    this.backgroundColor = TractianColor.gray,
  });

  final ValueChanged<String>? onChanged;
  final String hintText;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.only(
            top: 12,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                  color: TractianColor.gray500, fontFamily: 'Roboto'),
              hintText: hintText,
              border: InputBorder.none,
              icon: const Icon(Icons.search, color: TractianColor.gray500),
            ),
          ),
        ),
        Row(
          children: [
            TractianButton(
              leftIconPath: 'assets/logo/energy.svg',
              buttonType: ButtonType.small,
              onPressed: () {},
              label: 'Sensor de Energia',
              isToggle: true,
              backgroundColor: Colors.red,
              textColor: TractianColor.primaryBlue,
            ),
            TractianButton(
              leftIconPath: 'assets/logo/info.svg',
              buttonType: ButtonType.small,
              onPressed: () {},
              label: 'Sensor de Energia',
              isToggle: true,
              backgroundColor: Colors.red,
              textColor: TractianColor.primaryBlue,
            ),
          ],
        )
      ],
    );
  }
}
