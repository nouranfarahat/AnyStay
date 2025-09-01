// screens/map_screen.dart
import 'package:anystay/views/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anystay/models/Place.dart';

class MapScreen extends StatefulWidget {
  final Place place;

  const MapScreen({super.key, required this.place});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late LatLng placeLocation;

  @override
  void initState() {
    super.initState();
    placeLocation = LatLng(widget.place.lat, widget.place.lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: placeLocation,
              zoom: 15.0,
            ),
            markers: {
              Marker(
                markerId: MarkerId(widget.place.id),
                position: placeLocation,
                infoWindow: InfoWindow(
                  title: widget.place.name,
                  snippet: widget.place.category,
                ),
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
          CustomBackButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}