import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:anystay/controllers/place_controller.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/theme.dart';
import 'package:anystay/views/screens/details_screen.dart';
import 'package:anystay/views/widgets/place_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import '../widgets/carousel_place_card.dart';

class DiscoverScreen extends StatefulWidget {
  final List<Place> places; // Receive places from parent
  final Function(String) onFavoriteToggle; // Receive callback from parent
  final PlaceController placeController;


  const DiscoverScreen(
      {super.key,
      required this.places,
      required this.onFavoriteToggle,
      required this.placeController});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final Random _random = Random();
  int _currentCarouselIndex = 0;
   late List<Place> _randomFeaturedPlaces;
  final carousel_slider.CarouselSliderController _carouselController =
  carousel_slider.CarouselSliderController();

  @override
  void initState() {
    super.initState();
       _randomFeaturedPlaces = _getRandomFeaturedPlaces();
  } // @override
  // void initState() {
  //   super.initState();
  //   _randomFeaturedPlaces = _getRandomFeaturedPlaces();
  // }
  //

  List<Place> _getRandomFeaturedPlaces() {
    if (widget.places.length <= 4) return widget.places;

    final shuffled = List<Place>.from(widget.places)..shuffle(_random);
    return shuffled.take(4).toList();
  }
  void _navigateToDetails(BuildContext context, Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsScreen(
          place: place,
          placeController: widget.placeController,
        ),
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
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: ListView(children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  spacing: 7,
                  children: [
                    Text(
                      "Welcome to Discoveri",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: AppTheme.primaryColor),
                    ),
                    // Image(
                    //   image: AssetImage('assets/images/Logo.png'),
                    //   width: 30,
                    //   height: 30,
                    // ),
                    Icon(Icons.waving_hand,color: Colors.amber,size: 30,)
                  ],
                )),
            const SizedBox(
              height: 25,
            ),
            // the carousel slider
        if (_randomFeaturedPlaces.isNotEmpty) ...[
            SizedBox(
              height: 350,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                    height: 350,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(microseconds: 800),
                    enlargeCenterPage: true,
                    aspectRatio: 0.7,
                    viewportFraction: 0.7,
                    // each slide take 90% of the screen width
                    enlargeFactor: 0.25,
                    reverse: false,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentCarouselIndex = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    autoPlayCurve: Curves.linear),
                itemCount: _randomFeaturedPlaces.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  final place = _randomFeaturedPlaces[index];
                  final isCenter = index == _currentCarouselIndex;
                  return CarouselPlaceCard(
                    place: place,
                    onFavoritePressed: () => widget.onFavoriteToggle(place.id),
                    onTap: () => _navigateToDetails(context, place),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            //Slider indectator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _randomFeaturedPlaces
                  .asMap()
                  .entries
                  .map((item) => Container(
                        height: 12,
                        width: 12,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentCarouselIndex == item.key
                                ? AppTheme.primaryColor
                                : AppTheme.secondaryColor),
                      ))
                  .toList(),
            )],
            const SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text("All Places",
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            const SizedBox(height: 16,),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: widget.places.length,
              itemBuilder: (context, index) {
                final place = widget.places[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PlaceCard(
                    place: place,
                    onFavoritePressed: () =>
                        widget.onFavoriteToggle(widget.places[index].id),
                    onCardPressed: () => _navigateToDetails(context, place),
                  ),
                );
              },
            )
          ]),
        ));
  }
}
