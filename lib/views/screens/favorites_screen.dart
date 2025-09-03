import 'package:anystay/controllers/place_controller.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/theme.dart';
import 'package:anystay/views/screens/details_screen.dart';
import 'package:anystay/views/widgets/place_card.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  // final List<Place> allPlaces;
  final Function(String) onFavoriteToggled;
  //final FavoriteNotifier favoriteNotifier;
  final PlaceController placeController;
  const FavoritesScreen(
      {super.key,
      required this.onFavoriteToggled,
      required this.placeController});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  //final SharedPrefs _preferences=SharedPrefs();
  List<Place> favoritePlaces = [];

  @override
  void initState() {
    super.initState();
    widget.placeController.favoriteNotifier.addListener(_onFavoritesChanged);

    // Listen for favorite changes
    widget.placeController.favoriteNotifier.addListener(_onFavoritesChanged);
  }

  void _onFavoritesChanged() {
    setState(() {}); // Refresh when favorites change
  }
  // void _loadFavoritePlaces()
  // {
  //   final favoriteIds=_preferences.getFavoritePlaceIds();
  //   setState(() {
  //     widget.placeController.getFavoritePlaces();
  //     favoritePlaces=widget.allPlaces
  //         .where((place)=>favoriteIds.contains(place.id))
  //         .toList();
  //   });
  // }

  // Future<void> _toggleFavorite(String placeId) async {
  //   // Update the actual place object (shared with DiscoverScreen)
  //   await widget.onFavoriteToggled(placeId);
  //
  // }
  void _navigateToDetails(BuildContext context, Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsScreen(
          place: place,
          placeController: widget.placeController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlaces = widget.placeController.getFavoritePlaces();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: favoritePlaces.isEmpty
            ? const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.heart_broken, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                  'No favorites yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                )]),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: favoritePlaces.length,
                  itemBuilder: (context, index) {
                    final place = favoritePlaces[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: PlaceCard(
                        place: place,
                        onFavoritePressed: () =>
                            widget.onFavoriteToggled(place.id),
                        onCardPressed: () => _navigateToDetails(context, place),
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
