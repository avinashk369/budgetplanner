import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';

class Ripple extends StatelessWidget {
  final double radius;

  const Ripple({
    required this.radius,
  }) : assert(radius != null);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: screenWidth / 2 - radius,
      bottom: 2 * kPaddingL - radius,
      child: Container(
        width: 2 * radius,
        height: 2 * radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kDark,
        ),
      ),
    );
  }
}
