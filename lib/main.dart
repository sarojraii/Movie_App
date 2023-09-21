import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/provider.dart';
import 'package:movie_app/view/login.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyDqhe-4Wv51xtN1w3i-tiN8vgTikvTzoTw",
            projectId: "web-app-5780c",
            messagingSenderId: "864158121509",
            appId: "1:864158121509:web:61c485aa741e388f58c9cc")
        : null,
  );

  Future main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if (Firebase.apps.isNotEmpty) {
      print("flutter is connected");
    } else {
      print('Not connected');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SplashScreenWidget(),
        ),
      ),
    );
  }

  // const MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: HomePage(),
  // );
}

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Center(
        child: Container(
          height: 700,
          width: 500,
          child: const Image(
            image: NetworkImage(
              'https://s.tmimgcdn.com/scr/800x500/77700/letter-m-logo-template_77760-2-original.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      nextScreen: const LoginPage(),
    );
  }
}
