// widgets/single_rating_star.dart
import 'package:flutter/material.dart';

class SingleRatingStar extends StatelessWidget {
  final double rating;
  final double size;
  final Color filledColor;
  final Color emptyColor;
  final bool showNumber;
  final TextStyle? numberStyle;
  final MainAxisAlignment alignment;

  const SingleRatingStar({
    super.key,
    required this.rating,
    this.size = 30.0,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
    this.showNumber = true,
    this.numberStyle,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Single star with rating indicator
        _buildRatingStar(),
        if (showNumber) ...[
          const SizedBox(width: 6),
          // Rating number
          Text(
            rating.toStringAsFixed(1),
            style: numberStyle ??
                TextStyle(
                  fontSize: size * 0.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildRatingStar() {
    return Stack(
      children: [
        // Background (empty star)
        Icon(
          Icons.star,
          size: size,
          color: emptyColor,
        ),
        // Filled portion based on rating
        ClipRect(
          clipper: _StarClipper(rating: rating),
          child: Icon(
            Icons.star,
            size: size,
            color: filledColor,
          ),
        ),
      ],
    );
  }

  // Alternative: Star with border and filled interior
  Widget _buildFilledStar() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: filledColor.withOpacity(_calculateFillOpacity()),
        shape: BoxShape.circle,
        border: Border.all(
          color: filledColor,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.star,
          size: size * 0.7,
          color: filledColor.withOpacity(_calculateIconOpacity()),
        ),
      ),
    );
  }

  double _calculateFillOpacity() {
    // Convert rating (0-5) to opacity (0-1)
    return (rating / 5.0).clamp(0.0, 1.0);
  }

  double _calculateIconOpacity() {
    // Show icon clearly when rating is high, fade when low
    return rating > 2.5 ? 1.0 : 0.7;
  }

  // Static methods for quick usage
  static Widget small(double rating, {bool showNumber = true}) {
    return SingleRatingStar(
      rating: rating,
      size: 20.0,
      showNumber: showNumber,
      numberStyle: const TextStyle(fontSize: 12.0),
    );
  }

  static Widget medium(double rating, {bool showNumber = true}) {
    return SingleRatingStar(
      rating: rating,
      size: 30.0,
      showNumber: showNumber,
      numberStyle: const TextStyle(fontSize: 14.0),
    );
  }

  static Widget large(double rating, {bool showNumber = true}) {
    return SingleRatingStar(
      rating: rating,
      size: 40.0,
      showNumber: showNumber,
      numberStyle: const TextStyle(fontSize: 16.0),
    );
  }

  // Version without number - just the visual star
  static Widget visualOnly(double rating, {double size = 30.0}) {
    return SingleRatingStar(
      rating: rating,
      size: size,
      showNumber: false,
    );
  }
}

// Custom clipper to show partial fill based on rating
class _StarClipper extends CustomClipper<Rect> {
  final double rating;

  _StarClipper({required this.rating});

  @override
  Rect getClip(Size size) {
    // Calculate fill percentage (rating from 0 to 5, convert to 0 to 1)
    final fillPercentage = (rating / 5.0).clamp(0.0, 1.0);
    return Rect.fromLTRB(0, 0, size.width * fillPercentage, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
