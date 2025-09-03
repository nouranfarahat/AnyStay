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
                      const Icon(Icons.heart_broken,
                          size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        'No favorites yet!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      )
                    ]),
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
                )));
  }
}
