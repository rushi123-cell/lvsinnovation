import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 50.0);

    var firstControlPoint = Offset(size.width / 4, 0.0);
    var firstPoint = Offset(size.width / 2, 40.0);
    path.quadraticBezierTo(
      firstControlPoint.dx, firstControlPoint.dy,
      firstPoint.dx, firstPoint.dy,
    );

    var secondControlPoint = Offset(size.width - (size.width / 4), 80.0);
    var secondPoint = Offset(size.width, 30.0);
    path.quadraticBezierTo(
      secondControlPoint.dx, secondControlPoint.dy,
      secondPoint.dx, secondPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
