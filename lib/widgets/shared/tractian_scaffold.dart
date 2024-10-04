import 'package:flutter/material.dart';
import 'package:project_tractian/theme/tractian_colors.dart';

class TractianScaffold extends StatelessWidget {
  const TractianScaffold(
      {super.key, this.appBarTitle, this.appBarLogo, this.body});
  final String? appBarTitle;
  final Image? appBarLogo;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColor.white,
      appBar: AppBar(
        backgroundColor: TractianColor.secondaryBlue,
        title: appBarLogo != null
            ? Center(
                child: appBarLogo,
              )
            : Text(appBarTitle ?? ''),
        leading: appBarLogo == null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
      ),
      body: body,
    );
  }
}
