import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  final Widget desktopScaffold;
  final Widget mobileScaffold;
  final Widget tabletScaffold;

  const ResponsivePage({
    super.key,
    required this.desktopScaffold,
    required this.mobileScaffold,
    required this.tabletScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 650) {
          return mobileScaffold;
        } else if (constraints.maxHeight < 1100) {
          return desktopScaffold;
        } else {
          return desktopScaffold;
        }
      },
    );
  }
}

enum deviceType {
  mobile,
  web,
  tablet,
}

getDevicetype(MediaQueryData mediaQuery) {
  var size = mediaQuery.size.width;
  if (size < 650) {
    return deviceType.mobile;
  } else if (size < 1100) {
    return deviceType.web;
  } else {
    return deviceType.mobile;
  }
}
