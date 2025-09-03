// widgets/back_button.dart
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;

  const CustomBackButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.iconColor = AppTheme.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor),
        onPressed: onPressed,
      ),
    );
  }
}