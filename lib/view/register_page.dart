import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameKey = GlobalKey<FormFieldState>();
  final _secondNameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Builder(builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormWidget(
                          firstNameKey: _firstNameKey,
                          firstNameController: firstNameController,
                          secondNameKey: _secondNameKey,
                          secondNameController: secondNameController,
                          emailKey: _emailKey,
                          emailController: emailController,
                          passwordKey: _passwordKey,
                          passwordController: passwordController),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonWidget(
                          firstNameKey: _firstNameKey,
                          secondNameKey: _secondNameKey,
                          emailKey: _emailKey,
                          passwordKey: _passwordKey),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required GlobalKey<FormFieldState> firstNameKey,
    required GlobalKey<FormFieldState> secondNameKey,
    required GlobalKey<FormFieldState> emailKey,
    required GlobalKey<FormFieldState> passwordKey,
  })  : _firstNameKey = firstNameKey,
        _secondNameKey = secondNameKey,
        _emailKey = emailKey,
        _passwordKey = passwordKey;

  final GlobalKey<FormFieldState> _firstNameKey;
  final GlobalKey<FormFieldState> _secondNameKey;
  final GlobalKey<FormFieldState> _emailKey;
  final GlobalKey<FormFieldState> _passwordKey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _firstNameKey.currentState!.validate();
        _secondNameKey.currentState!.validate();
        _emailKey.currentState!.validate();
        _passwordKey.currentState!.validate();
      },
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.purple.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required GlobalKey<FormFieldState> firstNameKey,
    required this.firstNameController,
    required GlobalKey<FormFieldState> secondNameKey,
    required this.secondNameController,
    required GlobalKey<FormFieldState> emailKey,
    required this.emailController,
    required GlobalKey<FormFieldState> passwordKey,
    required this.passwordController,
  })  : _firstNameKey = firstNameKey,
        _secondNameKey = secondNameKey,
        _emailKey = emailKey,
        _passwordKey = passwordKey;

  final GlobalKey<FormFieldState> _firstNameKey;
  final TextEditingController firstNameController;
  final GlobalKey<FormFieldState> _secondNameKey;
  final TextEditingController secondNameController;
  final GlobalKey<FormFieldState> _emailKey;
  final TextEditingController emailController;
  final GlobalKey<FormFieldState> _passwordKey;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Myform(
          hintText: 'First Name',
          labelText: 'First Name',
          formkey: _firstNameKey,
          textFieldController: firstNameController,
          validators: (input) {
            if (input == null || input.isEmpty) {
              return 'Please Enter Your First Name';
            }
            return null;
          },
        ),
        Myform(
          hintText: 'Second Name',
          labelText: 'Second Name',
          formkey: _secondNameKey,
          textFieldController: secondNameController,
          validators: (input) {
            if (input == null || input.isEmpty) {
              return 'Please Enter your Second Name';
            }
            return null;
          },
        ),
        Myform(
          hintText: 'Email',
          labelText: 'Email',
          formkey: _emailKey,
          textFieldController: emailController,
          validators: (value) {
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!);
            if (value == null || value.isEmpty) {
              return 'Please Enter Email Address';
            } else if (emailValid == false) {
              return 'Please Enter Valid Email Address';
            }
            return null;
          },
        ),
        Myform(
          hintText: 'Password',
          labelText: 'Password',
          formkey: _passwordKey,
          textFieldController: passwordController,
          validators: (input) {
            RegExp regex = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
            if (input == null || input.isEmpty) {
              return 'Please Enter Password';
            } else {
              if (!regex.hasMatch(input)) {
                return 'Invalid Password';
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}

class Myform extends StatefulWidget {
  final GlobalKey formkey;
  final String hintText;
  final String labelText;
  final TextEditingController textFieldController;
  final String? Function(dynamic)? validators;

  const Myform({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.formkey,
    required this.textFieldController,
    required this.validators,
  });

  @override
  State<Myform> createState() => _MyformState();
}

class _MyformState extends State<Myform> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormField(
        validator: widget.validators,
        key: widget.formkey,
        builder: (FormFieldState formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  if (formFieldState.hasError) {
                    formFieldState.reset();
                    formFieldState.save();
                  }
                  formFieldState.didChange(value);
                },
                controller: widget.textFieldController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: formFieldState.hasError ? Colors.red : null,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                ),
              ),
              _showError(formFieldState, formFieldState.errorText),
            ],
          );
        },
      ),
    );
  }

  _showError(FormFieldState formFieldState, String? errorText) {
    if (formFieldState.hasError) {
      return Container(
        height: 50,
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          errorText!,
          style: const TextStyle(
            color: Color(0xFFFF0000),
            fontSize: 12,
          ),
        ),
      );
    } else {
      return const SizedBox(height: 40);
    }
  }
}
