import 'package:flutter/material.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/theme.dart';
import 'package:anystay/views/widgets/diagonal_notch.dart';

class CarouselPlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  const CarouselPlaceCard(
      {super.key,
      required this.place,
      required this.onTap,
      required this.onFavoritePressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: AppTheme.cardShadowColor,
                    blurRadius: 15,
                    offset: Offset(0, 6))
              ]),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  //Place Image
                  Image.network(
                    place.coverUrl,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.4,
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
                          stops: [
                            0.0,
                            0.3,
                            0.6,
                            0.8
                          ]),
                    ),
                  ),
                  // Place name

                  Positioned(
                      bottom: 30,
                      left: 10,
                      right: 120, //space for price tag notch
                      child: Text(
                        place.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: AppTheme.surfaceColor),
                      )),
                  //Favorite icon
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: AppTheme.surfaceColor.withOpacity(0.9),
                            shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: onFavoritePressed,
                          icon: Icon(
                            place.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color:
                                place.isFavorite ? Colors.red : Colors.black54,
                            size: 30,
                          ),
                        ),
                      )),
                  //Pricetag notch
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: DiagonalNotch(
                          text: place.priceTag,
                          color: place.priceTag == "Paid"
                              ? AppTheme.primaryColor
                              : AppTheme.secondaryColor))
                ],
              )),
        ));
  }
}
