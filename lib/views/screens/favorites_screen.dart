import 'package:anystay/models/Place.dart';
import 'package:anystay/utilities/SharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Place> allPlaces;
  const FavoritesScreen({super.key, required this.allPlaces});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final SharedPrefs _preferences=SharedPrefs();
  List<Place> favoritePlaces=[];


  void _loadFavPlaaces()
  {
    final favoriteIds=_preferences.getFavoritePlaceIds();
    favoritePlaces=widget.allPlaces
    .where((place)=>favoriteIds.contains(place.id))
    .toList();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
