import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/shadows.dart';
import 'package:anystay/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback onFavoritePressed;
  final VoidCallback onCardPressed;

  const PlaceCard(
      {super.key, required this.place, required this.onFavoritePressed, required this.onCardPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onCardPressed, // Make the entire card tappable
     child:  Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child:SizedBox(
        height: 270,
          width: double.infinity, // Full width

          child:  Column(
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
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
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
                        color: AppTheme.surfaceColor.withOpacity(0.9),
                        shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: onFavoritePressed,
                      icon: Icon(
                        place.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: place.isFavorite ? Colors.red : Colors.black54,
                        size: 30,
                      ),
                    ),
                    // child: Icon(
                    //   place.isFavorite?
                    //   Icons.favorite:Icons.favorite_outline,
                    //   color: place.isFavorite?Colors.red:Colors.black54,
                    //   size: 30,),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //Name and Rating
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      place.name,
                      style: Theme.of(context).textTheme.titleLarge,
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
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                //PriceTag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.secondaryColor),
                  child: Text(
                    place.priceTag,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey[700]),
                  ),
                )
              ],
            ),
          )
        ],
      )
      ),
    ));
    //   Container(
    //   width: 180,
    //   padding: const EdgeInsets.all(1),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(30),
    //     boxShadow: [ MyShadowStyle.verticalShadowStyle],
    //     color: AppTheme.surfaceColor
    //   ),
    //
    // );
  }
}
