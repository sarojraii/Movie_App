import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/db/notes_db.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:movie_app/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Firebase.apps.isNotEmpty) {
    print("Firebase is connected!");
  } else {
    print("Firebase is not connected.");
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool _isChecking = false;
  // bool get isChecking => _isChecking;

  // set isChecking(bool value) {
  //   _isChecking = value;
  //   setState(() {});
  // }

  // bool isLoggedIn = false;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     isChecking = true;
  //     await check();
  //     isChecking = false;
  //   });
  // }

  // Future<void> check() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   isLoggedIn = sp.getBool('login') ?? false;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedSplashScreen(
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
          // nextScreen: isChecking
          //     ? Container()
          //     : !isLoggedIn
          //         ? LoginPage()
          //         : DashboardPage()
          nextScreen: LoginPage(),
        ),
      ),
    );
  }
}
