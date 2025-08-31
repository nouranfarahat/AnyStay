import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/theme.dart';
import 'package:anystay/utilities/SharedPref.dart';
import 'package:anystay/utilities/favorite_notifier.dart';
import 'package:anystay/views/widgets/place_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Place> allPlaces;
  final Function(String) onFavoriteToggled;
  final FavoriteNotifier favoriteNotifier;
  const FavoritesScreen({super.key, required this.allPlaces, required this.onFavoriteToggled, required this.favoriteNotifier});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final SharedPrefs _preferences=SharedPrefs();
  List<Place> favoritePlaces=[];
  @override
  void initState() {
    super.initState();
    _loadFavoritePlaces();

    // Listen for favorite changes
    widget.favoriteNotifier.addListener(_onFavoritesChanged);
  }

  void _onFavoritesChanged() {
    _loadFavoritePlaces(); // Refresh when favorites change
  }
  void _loadFavoritePlaces()
  {
    final favoriteIds=_preferences.getFavoritePlaceIds();
    setState(() {
      favoritePlaces=widget.allPlaces
          .where((place)=>favoriteIds.contains(place.id))
          .toList();
    });
  }

  Future<void> _toggleFavorite(String placeId) async {
    // Update the actual place object (shared with DiscoverScreen)
    await widget.onFavoriteToggled(placeId);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          backgroundColor: AppTheme.primaryColor,
        ),
        body:  favoritePlaces.isEmpty
            ? const Center(
          child: Text(
            'No favorites yet!',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            :Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoritePlaces.length,
              itemBuilder: (context, index) {
                final place=favoritePlaces[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PlaceCard(
                    place: place,
                    onFavoritePressed: () => _toggleFavorite(place.id),
                  ),
                );
              },
            )
          // GridView.builder(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 1,
          //       crossAxisSpacing: 16,
          //       mainAxisSpacing: 16,
          //       childAspectRatio: 0.7,
          //     ),
          //     itemCount: places.length,
          //     itemBuilder: (context, index) {
          //       return PlaceCard(
          //         place: places[index],
          //         onFavoritePressed: ()=>{},
          //       );
          //     })
        ));
  }
}
