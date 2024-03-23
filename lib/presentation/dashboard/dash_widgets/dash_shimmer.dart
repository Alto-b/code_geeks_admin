
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashStatsShimmer extends StatelessWidget {
  const DashStatsShimmer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                height: screenHeight/6,
                width: screenWidth/6,
                color: Colors.blue,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                height: screenHeight/6,
                width: screenWidth/6,
                color: Colors.blue,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                height: screenHeight/6,
                width: screenWidth/6,
                color: Colors.blue,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                height: screenHeight/6,
                width: screenWidth/6,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                  decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(250)
                ),
                height: screenHeight/2,
                width: screenWidth/3,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(250)
                ),
                height: screenHeight/2,
                width: screenWidth/3,
              ),
            )
          ],
        ),
      ],
    );
  }
}