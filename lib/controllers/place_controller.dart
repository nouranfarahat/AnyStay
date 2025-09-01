import 'package:anystay/models/Place.dart';
import 'package:anystay/utilities/SharedPref.dart';
import 'package:anystay/utilities/favorite_notifier.dart';
import 'package:anystay/utilities/place_service.dart';

class PlaceController{
  final FavoriteNotifier _favoriteNotifier=FavoriteNotifier();
  final PlaceService _placeService=PlaceService();
  final SharedPrefs _sharedPrefs = SharedPrefs();
  List<Place> _allPlaces = [];
  List<Place> get allPlaces => _allPlaces;

  bool _isLoading = true;
  bool get isLoading => _isLoading;


  Future<void> loadAllPlaces() async {
    final loadedPlaces=await PlaceService.loadPlacesFromAssets();
    final favoritePlaces=SharedPrefs().getFavoritePlaceIds();
    for(var place in loadedPlaces)
    {
      // Set favorite status for each place
      place.isFavorite=favoritePlaces.contains(place.id);
    }

      _allPlaces=loadedPlaces;
      _isLoading=false;

  }
  Future<void> toggleFavorite(String placeId) async
  {
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
  }

  List<Place> getFavoritePlaces()
  {
    final favoriteIds=_sharedPrefs.getFavoritePlaceIds();
      return allPlaces
          .where((place)=>favoriteIds.contains(place.id))
          .toList();

  }

  FavoriteNotifier get favoriteNotifier => _favoriteNotifier;

}