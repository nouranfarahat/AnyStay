import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();
  late final SharedPreferences _sharedPrefs;

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

//Get favorite places

Set<String> getFavoritePlaceIds()
{
  return _sharedPrefs?.getStringList('favorite_places')?.toSet()??{};
}

Future<bool> addFavoritePlace(String placeId) async{
    final favoritePlaces=getFavoritePlaceIds();
    favoritePlaces.add(placeId);
    return await _sharedPrefs?.setStringList("favorite_places", favoritePlaces.toList())??false;
}
  Future<bool> removeFavoritePlace(String placeId) async{
    final favoritePlaces=getFavoritePlaceIds();
    favoritePlaces.remove(placeId);
    return await _sharedPrefs?.setStringList("favorite_places", favoritePlaces.toList())??false;
  }

  bool isPlaceFavorite(String placeId)
  {
    return getFavoritePlaceIds().contains(placeId);
  }
}