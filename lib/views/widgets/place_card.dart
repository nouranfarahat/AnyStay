import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/theme.dart';
import 'package:flutter/material.dart';

import 'diagonal_notch.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback onFavoritePressed;
  final VoidCallback onCardPressed;

  const PlaceCard(
      {super.key,
      required this.place,
      required this.onFavoritePressed,
      required this.onCardPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onCardPressed, // Make the entire card tappable
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                  height: 260,
                  width: double.infinity, // Full width

                  child: Stack(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              child: Image.network(
                                place.coverUrl,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 150,
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150,
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: AppTheme.surfaceColor
                                          .withOpacity(0.9),
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: onFavoritePressed,
                                    icon: Icon(
                                      place.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color: place.isFavorite
                                          ? Colors.red
                                          : Colors.black54,
                                      size: 30,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        //Pricetag notch

                        Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //Name and Rating
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      place.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    //Rating
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amberAccent,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          place.rating.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        )
                                      ],
                                    )
                                  ],
                                ),

                                // openHours
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 25,
                                      color: AppTheme.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      // Add Expanded here to allow text to take available space
                                      child: Text(
                                        place.country,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: DiagonalNotch(
                            width: 80,
                            height: 40,
                            text: place.priceTag,
                            color: place.priceTag == "Paid"
                                ? AppTheme.primaryColor
                                : AppTheme.secondaryColor)),
                  ]))),
        ));
  }
}
