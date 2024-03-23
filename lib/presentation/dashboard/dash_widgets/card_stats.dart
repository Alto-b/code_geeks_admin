
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class cardStats extends StatelessWidget {
  const cardStats({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.title,
    this.count
  });

  final double screenHeight;
  final double screenWidth;
  final String? title;
  final String? count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: screenHeight/6,
        width: screenWidth/6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(title!,style: GoogleFonts.poppins(
              fontSize: 25,fontWeight: FontWeight.w600,color: Colors.grey.shade400
            ),),
            Text(count!,style: GoogleFonts.poppins(
              fontSize: 35,fontWeight: FontWeight.w700,color: Colors.grey
            ),)
          ],
        ),
      ),
    );
  }
}
