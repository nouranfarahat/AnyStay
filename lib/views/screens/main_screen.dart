import 'package:anystay/views/screens/discover_screen.dart';
import 'package:anystay/views/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:anystay/controllers/main_screen_controller.dart';
import 'package:anystay/theme/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenController _controller = MainScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _controller.currentIndex,
        onTap: (index) {
          setState(() {
            _controller.changeIndex(index);
          });
        },
      ),
    );
  }

  Widget _buildCurrentScreen() {
    return IndexedStack(
      index: _controller.currentIndex,
      children: const [
         DiscoverScreen(),
        // CategoriesScreen(),
        // FavoritesScreen(),
      ],
    );
  }
}