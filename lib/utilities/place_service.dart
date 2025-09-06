import 'dart:convert';

import 'package:anystay/models/Place.dart';
import 'package:flutter/services.dart';

class PlaceService {
  static Future<List<Place>> loadPlacesFromAssets() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/places.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Place.fromJson(json)).toList();
    } catch (e) {
      print('Error loading places:$e');
      return [];
    }
  }
}
