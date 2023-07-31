import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: 150,
                child: Image(
                  image: NetworkImage(
                      'https://wallpaperaccess.com/full/259316.jpg'),
                ),
              ),
              Container(
                height: 200,
                width: 150,
                child: Image(
                  image: NetworkImage(
                      'https://wallpaperaccess.com/full/259316.jpg'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
