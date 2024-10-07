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
          height: 32,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                color: TractianColor.gray500,
                fontFamily: 'Roboto',
              ),
              hintText: hintText,
              border: InputBorder.none,
              icon: const Padding(
                padding: EdgeInsets.only(
                  left: 18,
                ),
                child: Icon(
                  Icons.search,
                  color: TractianColor.gray500,
                  size: 18,
                  applyTextScaling: false,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TractianButton(
              leftIconPath: 'assets/logo/energy.svg',
              buttonType: ButtonType.small,
              onPressed: () {},
              label: 'Sensor de Energia',
              isToggle: true,
              backgroundColor: Colors.red,
            ),
            const SizedBox(width: 8),
            TractianButton(
              leftIconPath: 'assets/logo/info.svg',
              buttonType: ButtonType.small,
              onPressed: () {},
              label: 'Crítico',
              isToggle: true,
              backgroundColor: Colors.red,
            ),
          ],
        )
      ],
    );
  }
}
