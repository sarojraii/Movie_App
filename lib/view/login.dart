import 'package:flutter/material.dart';
import 'package:movie_app/mobilepage/mobile.dart';
import 'package:movie_app/responsive/responsive.dart';
import 'package:movie_app/webpage/web.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: getDevicetype(MediaQuery.of(context)) == deviceType.mobile
              ? const MobilePage()
              : const WebLoginPage(),
        ),
      ],
    );
  }
}
