import 'package:anystay/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VentureOut'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: const Center(
        child: Text('Welcome to the main app!'),
      ),
    );
  }
}