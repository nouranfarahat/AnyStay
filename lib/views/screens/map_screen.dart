// views/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/controllers/map_controller.dart';
import 'package:anystay/views/widgets/back_button.dart';

class MapScreen extends StatefulWidget {
  final Place place;
  final MapController mapController;

  const MapScreen({
    super.key,
    required this.place,
    required this.mapController,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.mapController.animateToPlace(widget.place);
    });
  }

  @override
  void dispose() {
    widget.mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            widget.mapController.getInitialCameraPosition(widget.place),
            markers: widget.mapController.getMarkers(widget.place),
            onMapCreated: widget.mapController.onMapCreated,
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