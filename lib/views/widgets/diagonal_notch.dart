import 'package:flutter/material.dart';

class DiagonalNotch extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final TextStyle? textStyle;

  const DiagonalNotch(
      {super.key,
      required this.text,
      required this.color,
      this.width = 12,
      this.height = 60,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(120, 60),
      painter: _DiagonalNotchPainter(color: color),
      child: Container(
        padding: EdgeInsets.only(left: 0, bottom: 17),
        alignment: Alignment.bottomLeft,
        child: Transform.rotate(
          angle: -45 * (3.1415926535 / 180), // -45 degrees in radians
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DiagonalNotchPainter extends CustomPainter {
  final Color color;

  _DiagonalNotchPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(-30, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, -30)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _DiagonalNotchPainter) {
      return oldDelegate.color != color;
    }
    return true;
  }
}
