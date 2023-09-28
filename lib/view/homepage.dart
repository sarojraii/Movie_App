import 'package:flutter/material.dart';
import 'package:movie_app/mobilepage/mobile_homepage.dart';
import '../responsive/responsive.dart';
import '../webpage/web-homepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: getDevicetype(MediaQuery.of(context)) == deviceType.mobile
              ? const MobileHomePage()
              : const WebHomePage(),
        ),
      ],
    );
  }
}
