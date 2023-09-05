import 'package:flutter/material.dart';
import 'package:lostpaws_app/presentation/constants.dart';

class CustomToolTip extends ShapeBorder {
  final bool usePadding;
  final double width;

  const CustomToolTip(this.width, {this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 20));
    return Path()
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 4)))
      ..moveTo(rect.bottomCenter.dx + getPaddingX(), rect.bottomCenter.dy)
      ..relativeLineTo(10, 20)
      ..relativeLineTo(10, -20)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  /// Returns the appropriate horizontal padding that aligns the tooltip with
  /// the icon it should be displayed above.
  double getPaddingX() {
    return width / 2 - defaultPadding * 6.5;
  }
}
