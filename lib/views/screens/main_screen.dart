import 'package:anystay/controllers/place_controller.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/utilities/SharedPref.dart';
import 'package:anystay/utilities/favorite_notifier.dart';
import 'package:anystay/utilities/place_service.dart';
import 'package:anystay/views/screens/categories_screen.dart';
import 'package:anystay/views/screens/discover_screen.dart';
import 'package:anystay/views/screens/favorites_screen.dart';
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
  final PlaceController _placeController = PlaceController();

  // final FavoriteNotifier _favoriteNotifier=FavoriteNotifier();
  // List<Place> allPlaces = [];
  // bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    try {
      await _placeController.loadAllPlaces();
      setState(() {});
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> _toggleFavorite(String placeId) async {
    await _placeController.toggleFavorite(placeId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_placeController.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
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
      children: [
        DiscoverScreen(
          places: _placeController.allPlaces,
          onFavoriteToggle: _toggleFavorite,
        ),
        CategoriesScreen(),
        FavoritesScreen(
          onFavoriteToggled: _toggleFavorite,
          placeController: _placeController,
        ),
      ],
    );
  }
}
