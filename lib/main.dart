import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/provider.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:movie_app/view/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splashpage_package/splashpage_package.dart';

Future web() async {
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

  runApp(const MyApp());
}

Future main() async {
  await web();
  if (Firebase.apps.isNotEmpty) {
    print("firebase is connected");
  } else {
    print('Not connected');
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(
          images: 'image/movie logo.jpg',
          nextScreen: LoginPage(),
          text: 'SplashScreen',
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
