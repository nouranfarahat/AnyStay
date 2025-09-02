import 'package:anystay/models/Place.dart';

class CustomSearchController {
  String _searchQuery = '';
  String? _selectedCategory;
  List<Place> _allPlaces = [];
  List<Place> _filteredPlaces = [];

  String get searchQuery => _searchQuery;

  String? get selectedCategory => _selectedCategory;

  List<Place> get filteredPlaces => _filteredPlaces;

  void initialize(List<Place> places)
  {
    _allPlaces=places;
    _filteredPlaces=_allPlaces;
  }

  void _applyFilter() {
    _filteredPlaces = _allPlaces.where((place) {
      //Search filter
      final matchFilter = _searchQuery.isEmpty ||
          place.name.toLowerCase().contains(_searchQuery) ||
          place.description.toLowerCase().contains(_searchQuery);
          //place.category.toLowerCase().contains(_searchQuery);

      //Category filter
      final matchedCategory = _selectedCategory == null ||
          place.priceTag == _selectedCategory;


      return matchedCategory && matchFilter;
    }).toList();

  }
  void search(String query)
  {
    _searchQuery=query.toLowerCase().trim();
    _applyFilter();
  }

  void filterByCategory(String? category)
  {
    _selectedCategory=category;
    _applyFilter();
  }

  void clearSearch()
  {
    _searchQuery='';
    _selectedCategory=null;
    _filteredPlaces=_allPlaces;
  }
  List<String> getAvailableCategories()
  {
    final categories=_allPlaces.map((place)=>place.priceTag).toSet();
    return categories.toList()..sort();
  }

  bool get isFiltered=>_searchQuery.isNotEmpty||_selectedCategory!=null;
}


