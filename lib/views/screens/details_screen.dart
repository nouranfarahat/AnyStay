// views/screens/place_details_screen.dart
import 'package:anystay/controllers/map_controller.dart';
import 'package:anystay/views/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:anystay/controllers/place_controller.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/views/widgets/back_button.dart';
import 'package:anystay/views/screens/map_screen.dart';
import 'package:anystay/theme/theme.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Place place;
  final PlaceController placeController;

  const PlaceDetailsScreen({
    super.key,
    required this.place,
    required this.placeController,
  });

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildImageWithGradient(),
          CustomBackButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.white.withOpacity(0.8),
          ),
        //  _buildFavoriteButton(),

           // top:MediaQuery.of(context).size.height*0.6 ,
             _buildContentContainer()

        ],
      ),
    );



  }
  Widget _buildImageWithGradient(){

    return SizedBox(
      height: MediaQuery.of(context).size.height*0.4,
      width: double.infinity,
      child: Stack(
        children: [
          //Place Image
          Image.network(
            widget.place.coverUrl,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height*0.4,
            width: double.infinity,
          ),

          //Gradient layer on the image
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,

                  colors: [
                AppTheme.primaryColor.withOpacity(0.8),
                AppTheme.primaryColor.withOpacity(0.4),
                AppTheme.primaryColor.withOpacity(0.2),
                Colors.transparent
              ],
              stops: [0.0,0.3,0.6,0.8]),

            ),
          ),
          // Place name
          Positioned(
            bottom: 50,
              left:15,
              child: Text(widget.place.name,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.surfaceColor
              ),)),
          Positioned(
              bottom: 40,
              right:50,
              child:Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.7)),
                child:SingleRatingStar(rating: widget.place.rating)

              ) )
        ],
      ),
    );

  }
  
  Widget _buildContentContainer(){
    return DraggableScrollableSheet(
        initialChildSize: 0.63,
        minChildSize: 0.63,
        maxChildSize: 0.9,
        builder: (context,scrollController)
    {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )
        ),
        child: ListView(
          controller: scrollController,
          children: [
            _buildDescription(),
            _buildOpenHours(),
            _buildTags(),
            _buildMapButton(),

          ],

        ),
      );
    });
  }
  Widget _buildDescription(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description",
        style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(height: 8),
        Text(widget.place.description,
          style: Theme.of(context).textTheme.bodyLarge,),
        const SizedBox(height: 20),

      ],
    );
  }
  Widget _buildOpenHours(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Open Hours",
          style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(height: 8),
        Text(widget.place.openHours,
          style: Theme.of(context).textTheme.bodyLarge,),
        const SizedBox(height: 20),

      ],
    );
  }
  Widget _buildTags(){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tags",
          style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: widget.place.tags.map((tag) => _buildTag(tag)).toList(),
        ),
        const SizedBox(height: 20),

      ],
    );
  }
  Widget _buildTag(String tag) {
    final tagColors = [
      const Color(0xFFB3E5FC),
      const Color(0xFFC8E6C9),
      const Color(0xFFFFECB3),
      const Color(0xFFD7CCC8),
      const Color(0xFFF8BBD0),
      const Color(0xFFE1BEE7),
    ];

    final tagIcons = {
      "View": Icons.visibility,
      "Iconic": Icons.landscape,
      "Skyscraper": Icons.business,
      "Family": Icons.family_restroom,
      "Shopping": Icons.shopping_bag,
      "Entertainment": Icons.movie,
      "Beach": Icons.beach_access,
      "Luxury": Icons.diamond,
      "Nature": Icons.nature,
      "Cultural": Icons.museum,
      "Free": Icons.money_off,
    };

    final color = tagColors[tag.hashCode % tagColors.length-1];
    final icon = tagIcons[tag] ?? Icons.label;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(
            tag,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(
                place: widget.place,
                mapController: MapController(),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Row(children: [
          Icon(Icons.location_on_sharp, color: AppTheme.surfaceColor,),
    const SizedBox(width: 5,),
    Text(
          "View on Map",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        )],
      ),
    ));
  }


  Future<void> _toggleFavorite() async {
    await widget.placeController.toggleFavorite(widget.place.id);
    setState(() {});
  }
}
