import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProvider {
  shimmer() {
    return SizedBox(
      width: 500,
      height: 230,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: const Color(0xFFE0E0E0),
              highlightColor: Colors.white,
              child: Container(
                height: 230,
                width: 140,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }),
    );
  }
}
