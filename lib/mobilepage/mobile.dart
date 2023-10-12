import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:movie_app/view/register_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<MobilePage> createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
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
                const Column(
                  children: [
                    LogoWidget(),
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
                EmailFieldWidget(
                    emailField: _emailField,
                    emailController: emailController,
                    hidden: hidden),
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
                  obscureText: isHidden,
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
                ErrorCheckWidget(
                    emailField: _emailField,
                    passwordField: _passwordField,
                    emailController: emailController,
                    pwController: pwController),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: RegisterPageWidget(),
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

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: const Image(
        height: 150,
        image: NetworkImage(
            'https://s.tmimgcdn.com/scr/800x500/77700/letter-m-logo-template_77760-2-original.jpg'),
      ),
    );
  }
}

class EmailFieldWidget extends StatelessWidget {
  const EmailFieldWidget({
    super.key,
    required GlobalKey<FormFieldState> emailField,
    required this.emailController,
    required this.hidden,
  }) : _emailField = emailField;

  final GlobalKey<FormFieldState> _emailField;
  final TextEditingController emailController;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    return MyField(
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
    );
  }
}

class ErrorCheckWidget extends StatefulWidget {
  const ErrorCheckWidget({
    super.key,
    required GlobalKey<FormFieldState> emailField,
    required GlobalKey<FormFieldState> passwordField,
    required this.emailController,
    required this.pwController,
  })  : _emailField = emailField,
        _passwordField = passwordField;

  final GlobalKey<FormFieldState> _emailField;
  final GlobalKey<FormFieldState> _passwordField;
  final TextEditingController emailController;
  final TextEditingController pwController;

  @override
  State<ErrorCheckWidget> createState() => _ErrorCheckWidgetState();
}

class _ErrorCheckWidgetState extends State<ErrorCheckWidget> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () async {
            bool isEmailVerified = widget._emailField.currentState!.validate();
            bool isPwVerified = widget._passwordField.currentState!.validate();

            if (isEmailVerified && isPwVerified) {
              isLoading = true;

              try {
                var userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.pwController.text);

                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.setString('userInfo', userCredential.user?.email ?? '');

                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()),
                );
              } on FirebaseAuthException catch (e) {
                String? errorMessage;
                switch (e.code) {
                  case 'user-not-found':
                    errorMessage = "Your email address is not registered.";
                    break;
                  case 'wrong-password':
                    errorMessage = "Your password is incorrect.";
                    break;
                  case 'too-many-requests':
                    errorMessage = 'Too many attempt. Please try again later.';
                  default:
                    errorMessage = "An undefined Error happened.";
                }
                isLoading = false;
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
          child: ButtonWidget(
            isLoading: isLoading,
          ),
        );
      },
    );
  }
}

class ButtonWidget extends StatefulWidget {
  final bool isLoading;
  const ButtonWidget({
    required this.isLoading,
    super.key,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.purple.shade200,
      ),
      child: Center(
        child: widget.isLoading
            ? const CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.grey,
              )
            : const Text(
                'Login',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}

class RegisterPageWidget extends StatelessWidget {
  const RegisterPageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ));
          },
          child: const Text(
            'Click here',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
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
                    prefixIcon: const Icon(Icons.email),
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
