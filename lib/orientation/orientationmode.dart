import 'package:flutter/material.dart';
import 'package:movie_app/mobilepage/mobile.dart';
import 'package:movie_app/webpage/web.dart';

class OrientationMode extends StatelessWidget {
  const OrientationMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return const MobilePage();
            } else {
              return const WebLoginPage();
            }
          },
        ),
      ],
    );
  }
}
