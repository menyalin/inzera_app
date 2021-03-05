import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscountLabel extends StatelessWidget {
  final String label;
  final double angle;
  final double fontSize;
  final int padding;
  DiscountLabel({this.label, this.fontSize, this.angle, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 5),
      transform: Matrix4.rotationZ(angle ?? -0.45),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE65078),
            Color(0xFF771D32),
          ],
        ),
        // color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
