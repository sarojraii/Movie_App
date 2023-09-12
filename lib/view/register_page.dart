import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/view/dashboard.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // final _formKey = GlobalKey<FormState>();
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
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(8.0),
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
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
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
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
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
  // final _NameKey = GlobalKey<FormFieldState>();

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

              // Show Form Field Error
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
