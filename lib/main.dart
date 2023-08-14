import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Center(
            child: Container(
              height: 700,
              width: 500,
              child: Image(
                image: NetworkImage(
                  'https://s.tmimgcdn.com/scr/800x500/77700/letter-m-logo-template_77760-2-original.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          nextScreen: LoginPage()),
    );
  }
}
