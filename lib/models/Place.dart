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
  });

}
