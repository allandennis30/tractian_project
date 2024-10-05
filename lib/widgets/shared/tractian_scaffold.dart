import 'package:flutter/material.dart';
import 'package:project_tractian/theme/tractian_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_tractian/widgets/shared/tractian_search_bar_filter.dart';

class TractianScaffold extends StatelessWidget {
  const TractianScaffold({
    super.key,
    this.appBarTitle,
    this.appBarLogoPath,
    this.body,
    this.showFilter = false,
  });

  final String? appBarTitle;
  final String? appBarLogoPath;
  final Widget? body;
  final bool showFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColor.white,
      appBar: AppBar(
        backgroundColor: TractianColor.secondaryBlue,
        automaticallyImplyLeading: false,
        title: appBarLogoPath != null
            ? Center(
                child: SvgPicture.asset(
                  appBarLogoPath!,
                  height: 18,
                ),
              )
            : Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      appBarTitle ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
      ),
      body: Column(
        children: [
          if (showFilter)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TractianSearchBarFilter(
                onChanged: (value) {
                  print("Texto de pesquisa: $value");
                },
              ),
            ),
          Expanded(child: body ?? Container()),
        ],
      ),
    );
  }
}
