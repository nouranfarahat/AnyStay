class Place {
  String id;
  String name;
  String category;
  double rating;
  String priceTag;
  double lat;
  double lng;
  String coverUrl;
  String description;
  String openHours;
  List<String> tags;
  String country;
  bool isFavorite;

  Place({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.priceTag,
    required this.lat,
    required this.lng,
    required this.coverUrl,
    required this.description,
    required this.openHours,
    required this.tags,
    required this.country,
    this.isFavorite=false
  });


  // Convert from JSON
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      priceTag: json['priceTag'] ?? 'Free',
      lat: (json['lat'] ?? 0.0).toDouble(),
      lng: (json['lng'] ?? 0.0).toDouble(),
      coverUrl: json['coverUrl'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      description: json['description'] ?? '',
      openHours: json['openHours'] ?? '',
      country: json['country'] ?? '',
      tags: List<String>.from(json['tags'] as List),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'rating': rating,
      'priceTag': priceTag,
      'lat': lat,
      'lng': lng,
      'coverUrl': coverUrl,
      'description': description,
      'openHours': openHours,
      'country':country,
      'tags': tags,
    };
  }
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

}
