import 'package:anystay/controllers/place_controller.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/theme.dart';
import 'package:anystay/utilities/SharedPref.dart';
import 'package:anystay/utilities/place_service.dart';
import 'package:anystay/views/screens/details_screen.dart';
import 'package:anystay/views/widgets/place_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DiscoverScreen extends StatefulWidget {
  final List<Place> places; // Receive places from parent
  final Function(String) onFavoriteToggle; // Receive callback from parent
  final PlaceController placeController;

  const DiscoverScreen({super.key, required this.places, required this.onFavoriteToggle, required this.placeController});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  void _navigateToDetails(BuildContext context, Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsScreen(place: place, placeController: widget.placeController,),
      ),
    );
  }
  // List<Place> places = [];
  // final SharedPrefs _sharedPrefs=SharedPrefs();
  //bool isLoading=true;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadPlaces();
  // }
  // Future<void> _loadPlaces() async {
  //   final loadedPlaces=await PlaceService.loadPlacesFromAssets();
  //
  //   final favoritePlaces=_sharedPrefs.getFavoritePlaceIds();
  //   for(var place in loadedPlaces)
  //     {
  //       // Set favorite status for each place
  //       place.isFavorite=favoritePlaces.contains(place.id);
  //     }
  //
  //   setState(() {
  //     places=loadedPlaces;
  //     isLoading=false;
  //   });
  // }
  // Future<void> _toggleFavorite(String placeId) async
  // {
  //   //store the place that has its fav button clicked
  //   final place=places.firstWhere((p)=>p.id==placeId);
  //   place.isFavorite = !place.isFavorite;
  //   if(place.isFavorite)
  //     {
  //       await _sharedPrefs.addFavoritePlace(placeId);
  //     }
  //   else
  //     {
  //       await _sharedPrefs.removeFavoritePlace(placeId);
  //     }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Discover'),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.places.length,
              itemBuilder: (context, index) {
                final place=widget.places[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PlaceCard(
                    place: place,
                    onFavoritePressed: () => widget.onFavoriteToggle(widget.places[index].id),
                    onCardPressed: ()=> _navigateToDetails(context, place),
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
