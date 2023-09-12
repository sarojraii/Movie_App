import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:movie_app/view/home_page.dart';
import 'package:movie_app/view/profile_page.dart';
import 'package:movie_app/view/register_page.dart';
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

  final _emailField = GlobalKey<FormFieldState>();
  final _passwordField = GlobalKey<FormFieldState>();

  bool _isHidden = true;

  bool get isHidden => _isHidden;

  set isHidden(bool value) {
    _isHidden = value;
    setState(() {});
  }

  bool _hidden = true;

  bool get hidden => _hidden;

  set hidden(bool value) {
    _hidden = value;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyField(
                  formkey: _emailField,
                  hintText: 'Email',
                  suffixIcon: null,
                  textEditingController: emailController,
                  obscureText: !hidden,
                  validators: (value) {
                    RegExp regex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                    if (value == null || value.isEmpty) {
                      return 'please fill the Email';
                    }
                    if (!regex.hasMatch(value)) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyField(
                  formkey: _passwordField,
                  hintText: 'Password',
                  textEditingController: pwController,
                  suffixIcon: IconButton(
                    onPressed: () {
                      isHidden = !isHidden;
                    },
                    icon: isHidden
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off_rounded),
                  ),
                  obscureText: _isHidden,
                  validators: (value) {
                    RegExp validPass = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if (value == null || value.isEmpty) {
                      return 'please fill the Password ';
                    }
                    if (!validPass.hasMatch(value)) {
                      return 'Invalid Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                // InkWell(
                //   onTap: () async {
                //     if (emailController.text.isEmpty ||
                //         pwController.text.isEmpty) {
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return AlertDialog(
                //             title: const Text('Form Incomplete'),
                // content: const Text(
                //     'Please fill in both email and password.'),
                //             actions: <Widget>[
                //               TextButton(
                //                 child: const Text('OK'),
                //                 onPressed: () {
                //                   Navigator.of(context).pop();
                //                 },
                //               ),
                //             ],
                //           );
                //         },
                //       );
                //     } else {
                //       // final SharedPreferences sp =
                //       //     await SharedPreferences.getInstance();
                //       // sp.setString('Email', emailController.text);
                //       // sp.setString('password', pwController.text);

                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute(
                //       //     builder: (context) => DashboardPage(),
                //       //   ),
                //       // );
                //       FirebaseAuth.instance.createUserWithEmailAndPassword(
                //           email: emailController.text,
                //           password: pwController.text);
                //     }
                //   },
                //   child: Container(
                //     height: 40,
                //     width: 150,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: Colors.purple.shade200,
                //     ),
                //     child: const Center(
                //       child: Text(
                //         'Login',
                //         style:
                //             TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () async {
                    if (_emailField.currentState!.validate() &&
                        _passwordField.currentState!.validate()) {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: pwController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        String? errorMessage;
                        switch (e.code) {
                          case 'user-not-found':
                            errorMessage =
                                "Your email address is not registered.";
                            break;
                          case 'wrong-password':
                            errorMessage = "your password is incorrect";
                            break;
                          case 'too-many-requests':
                            errorMessage =
                                'Too many attempt. Please try again later.';
                          default:
                            errorMessage = "An undefined Error happened.";
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(errorMessage!),
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
                      }
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont have an account?'),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                        },
                        child: const Text(
                          'Click here',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyField extends StatefulWidget {
  final GlobalKey formkey;
  final String hintText;
  final TextEditingController textEditingController;
  final dynamic suffixIcon;
  final bool obscureText;
  final String? Function(dynamic)? validators;

  const MyField({
    super.key,
    required this.formkey,
    required this.hintText,
    required this.textEditingController,
    required this.suffixIcon,
    required this.obscureText,
    required this.validators,
  });

  @override
  State<MyField> createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormField(
        validator: widget.validators,
        key: widget.formkey,
        builder: (FormFieldState formFieldState) {
          return Column(
            children: [
              TextFormField(
                onChanged: (String value) {
                  if (formFieldState.hasError) {
                    formFieldState.reset();
                    formFieldState.save();
                  } else {
                    formFieldState.didChange(value);
                  }
                },
                controller: widget.textEditingController,
                keyboardType: TextInputType.text,
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: widget.suffixIcon,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
              ),
              _showError(formFieldState, formFieldState.errorText)
            ],
          );
        },
      ),
    );
  }

  _showError(FormFieldState formFieldState, String? errorText) {
    if (formFieldState.hasError) {
      return Container(
        height: 20,
        // color: Colors.blue,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          formFieldState.errorText!,
          style: const TextStyle(
            color: Color(0xFFFF0000),
            fontSize: 12,
          ),
        ),
      );
    } else {
      return const SizedBox(height: 20);
    }
  }
}
