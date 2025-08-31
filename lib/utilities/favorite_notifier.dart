// services/favorite_notifier.dart
import 'package:flutter/foundation.dart';

class FavoriteNotifier with ChangeNotifier {
  void notifyFavoritesChanged() {
    notifyListeners();
  }
}