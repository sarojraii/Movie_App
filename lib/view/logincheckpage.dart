import 'package:flutter/material.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class LoginCheckPage extends StatefulWidget {
  const LoginCheckPage({super.key});

  @override
  State<LoginCheckPage> createState() => _LoginCheckPageState();
}

class _LoginCheckPageState extends State<LoginCheckPage> {
  @override
  void initState() {
    super.initState();
    loadingPage();
    splashScreen();
  }

  bool? isLoggedIn;
  Future<void> splashScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isLoggedIn = pref.getBool('isLogged');
    print(isLoggedIn);
  }

  Future<void> loadingPage() async {
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return isLoggedIn ?? false
              ? const DashboardPage()
              : const LoginPage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(
            color: Colors.blue,
            backgroundColor: Colors.white,
          )
        ]),
      ),
    );
  }
}
