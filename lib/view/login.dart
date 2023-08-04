import 'package:flutter/material.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:movie_app/view/home_page.dart';
import 'package:movie_app/view/slider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      prefixIcon: const Icon(Icons.lock),
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
              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.purple.shade200,
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage()),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
