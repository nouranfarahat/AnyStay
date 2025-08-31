import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/theme.dart';
import 'package:anystay/utilities/place_service.dart';
import 'package:anystay/views/widgets/place_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<Place> places = [];

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }
  Future<void> _loadPlaces() async {
    final loadedPlaces=await PlaceService.loadPlacesFromAssets();

    setState(() {
      places=loadedPlaces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('VentureOut'),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: places.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PlaceCard(
                    place: places[index],
                    onFavoritePressed: () => {},
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
