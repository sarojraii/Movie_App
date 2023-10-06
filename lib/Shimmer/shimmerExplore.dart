import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerExplore {
  exploreShimmer() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 240,
      ),
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Container(
            height: 240,
            width: 170,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}
