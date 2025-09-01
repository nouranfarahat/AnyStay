// screens/place_details_screen.dart
import 'package:anystay/views/screens/map_screen.dart';
import 'package:anystay/views/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/utilities/SharedPref.dart';
import 'package:anystay/theme/theme.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Place place;

  const PlaceDetailsScreen({super.key, required this.place});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  final SharedPrefs _prefs = SharedPrefs();
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.place.isFavorite;
  }

  void _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await _prefs.addFavoritePlace(widget.place.id);
    } else {
      await _prefs.removeFavoritePlace(widget.place.id);
    }

    // Update the original place object if needed
    widget.place.isFavorite = isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image with gradient overlay
          _buildImageWithGradient(),

          // Back button
          CustomBackButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.white.withOpacity(0.8),
          ),

          // Favorite button at intersection
          _buildFavoriteButton(),

          // Content container
          _buildContentContainer(),
        ],
      ),
    );
  }

  Widget _buildImageWithGradient() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(
            widget.place.coverUrl,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 0.8],
              ),
            ),
          ),
          // Place name at bottom left
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              widget.place.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Positioned(
      right: 20,
      bottom: MediaQuery.of(context).size.height * 0.4 - 30, // At the intersection
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
            size: 30,
          ),
          onPressed: _toggleFavorite,
        ),
      ),
    );
  }

  Widget _buildContentContainer() {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.65,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // Category and rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.place.category,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        widget.place.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Price tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.place.priceTag,
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.place.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // Open hours
              const Text(
                "Open Hours",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.place.openHours,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),

              // Tags
              const Text(
                "Tags",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.place.tags.map((tag) => _buildTag(tag)).toList(),
              ),
              const SizedBox(height: 30),

              // Map button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(place: widget.place),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "View on Map",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTag(String tag) {
    // Different pastel colors for tags
    final tagColors = [
      const Color(0xFFB3E5FC), // Light blue
      const Color(0xFFC8E6C9), // Light green
      const Color(0xFFFFECB3), // Light amber
      const Color(0xFFD7CCC8), // Light brown
      const Color(0xFFF8BBD0), // Light pink
      const Color(0xFFE1BEE7), // Light purple
    ];

    // Icons for different tags
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

    final color = tagColors[tag.hashCode % tagColors.length];
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
}