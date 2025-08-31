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
  final FavoriteNotifier _favoriteNotifier=FavoriteNotifier();
  List<Place> allPlaces = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }
  Future<void> _loadPlaces() async {
    final loadedPlaces=await PlaceService.loadPlacesFromAssets();

    final favoritePlaces=SharedPrefs().getFavoritePlaceIds();
    for(var place in loadedPlaces)
      {
        // Set favorite status for each place
        place.isFavorite=favoritePlaces.contains(place.id);
      }

    setState(() {
      allPlaces=loadedPlaces;
      isLoading=false;
    });
  }
  Future<void> _toggleFavorite(String placeId) async
  {
    final _sharedPrefs = SharedPrefs();

    //store the place that has its fav button clicked
    final place=allPlaces.firstWhere((p)=>p.id==placeId);
    place.isFavorite = !place.isFavorite;

    if(place.isFavorite)
      {
        await _sharedPrefs.addFavoritePlace(placeId);
      }
    else
      {
        await _sharedPrefs.removeFavoritePlace(placeId);
      }
    // Notify both screens about the change
    _favoriteNotifier.notifyFavoritesChanged();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
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
      children:  [
         DiscoverScreen(
           places: allPlaces,
           onFavoriteToggle: _toggleFavorite,
         ),
         CategoriesScreen(),
         FavoritesScreen(allPlaces: allPlaces,
           onFavoriteToggled: _toggleFavorite, favoriteNotifier: _favoriteNotifier,),
      ],
    );
  }
}