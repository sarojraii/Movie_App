import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProvider {
  shimmer() {
    return Container(
      width: 500,
      height: 230,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                height: 230,
                width: 140,
                margin: EdgeInsets.all(10),
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
