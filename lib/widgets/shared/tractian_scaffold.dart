import 'package:flutter/material.dart';
import 'package:project_tractian/theme/tractian_colors.dart';

class TractianScaffold extends StatelessWidget {
  const TractianScaffold({
    super.key,
    this.appBarTitle,
    this.appBarLogo,
    this.body,
  });

  final String? appBarTitle;
  final Image? appBarLogo;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColor.white,
      appBar: AppBar(
        backgroundColor: TractianColor.secondaryBlue,
        automaticallyImplyLeading: false,
        title: appBarLogo != null
            ? Center(
                child: appBarLogo,
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
      body: body,
    );
  }
}
