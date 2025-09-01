// controllers/map_controller.dart
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anystay/models/Place.dart';

class MapController {
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> _controllerCompleter = Completer();

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _controllerCompleter.complete(controller);
  }

  CameraPosition getInitialCameraPosition(Place place) {
    return CameraPosition(
      target: LatLng(place.lat, place.lng),
      zoom: 15.0,
    );
  }

  Set<Marker> getMarkers(Place place) {
    return {
      Marker(
        markerId: MarkerId(place.id),
        position: LatLng(place.lat, place.lng),
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.category,
        ),
      ),
    };
  }

  Future<void> animateToPlace(Place place) async {
    final controller = await _controllerCompleter.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(place.lat, place.lng),
          zoom: 15.0,
        ),
      ),
    );
  }

  void dispose() {
    _mapController.dispose();
  }
}