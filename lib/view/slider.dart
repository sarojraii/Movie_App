import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SliderWidget(),
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: AnotherCarousel(
            images: const [
              AssetImage('view/asset/cm.jpg'),
              AssetImage('view/asset/gog.jpg'),
              AssetImage('view/asset/captain.jpg'),
            ],
          ),
        ),
      ],
    );
  }
}
