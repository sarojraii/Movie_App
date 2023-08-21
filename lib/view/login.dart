import 'package:flutter/material.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:movie_app/view/home_page.dart';
import 'package:movie_app/view/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/db/simple_preference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  // void initState() {
  //   super.initState();
  //   check();
  // }

  // Future<void> check() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   bool isLoggedIn = sp.getBool('login') ?? false;
  //   if (isLoggedIn) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => DashboardPage(),
  //       ),
  //     );
  //   }
  //

  bool _isHidden = true;
  bool get isHidden => _isHidden;

  set isHidden(bool value) {
    _isHidden = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    child: const Image(
                      height: 150,
                      image: NetworkImage(
                          'https://s.tmimgcdn.com/scr/800x500/77700/letter-m-logo-template_77760-2-original.jpg'),
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  obscureText: _isHidden,
                  controller: pwController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isHidden = !isHidden;
                        },
                        icon: isHidden
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off_rounded),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () async {
                  if (emailController.text.isEmpty ||
                      pwController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Form Incomplete'),
                          content: const Text(
                              'Please fill in both email and password.'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    final SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.setString('Email', emailController.text);
                    sp.setString('password', pwController.text);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.purple.shade200,
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account?'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Click here',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // Column(
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => DashboardPage()),
              //         );
              //       },
              //       child: const Text(
              //         'Skip',
              //         style: TextStyle(
              //             fontSize: 20,
              //             color: Colors.red,
              //             decoration: TextDecoration.underline),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
