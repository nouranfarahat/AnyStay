import 'package:anystay/controllers/place_controller.dart';
import 'package:anystay/controllers/search_controller.dart';
import 'package:anystay/models/Place.dart';
import 'package:anystay/theme/theme.dart';
import 'package:anystay/views/screens/details_screen.dart';
import 'package:anystay/views/widgets/category_filter_widget.dart';
import 'package:anystay/views/widgets/custom_search_bar.dart';
import 'package:anystay/views/widgets/place_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Place> places;
  final PlaceController placeController;
  final Function(String) onFavoriteToggle;

  const SearchScreen({
    super.key,
    required this.places,
    required this.placeController,
    required this.onFavoriteToggle,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final CustomSearchController _searchController = CustomSearchController();
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.initialize(widget.places);
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _searchFocusNode.dispose();
    super.dispose();

  }

  void _handleCategoryChange(String? category) {
    _searchController.filterByCategory(category);
    setState(() {});
  }

  void _clearSearch() {
    _searchController.clearSearch();
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    final filteredPlaces = _searchController.filteredPlaces;

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Places"),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          //Search and filter section
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CustomSearchBar(
                  controller: _textEditingController,
                  focusNode: _searchFocusNode,
                  onChanged: (value) {
                    setState(() {
                      _searchController.search(value);
                      setState(() {});
                    });
                  },
                  onClear: _clearSearch,
                ),
                const SizedBox(
                  height: 12,
                ),

                Row(
                  children: [
                    FilterChipWidget(
                      label: "All",
                      selected: _searchController.selectedCategory == null,
                      onSelected: (selected) => _handleCategoryChange(null),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FilterChipWidget(
                      label: "Paid",
                      selected: _searchController.selectedCategory == 'Paid',
                      onSelected: (selected) =>
                          _handleCategoryChange(selected ? 'Paid' : null),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FilterChipWidget(
                      label: "Free",
                      selected: _searchController.selectedCategory == 'Free',
                      onSelected: (selected) =>
                          _handleCategoryChange(selected ? 'Free' : null),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                )

                //Category Filter
              ],
            ),
          ),

          //filtered places count
          if (_searchController.isFiltered)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Text(
                    '${filteredPlaces.length} place${filteredPlaces.length != 1 ? 's' : ''} found',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _clearSearch,
                    child: const Text('Clear filters'),
                  ),
                ],
              ),
            ),

          Expanded(child: filteredPlaces.isEmpty
              ?_buildEmptyState()
              :ListView.builder(
            itemCount: filteredPlaces.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context,index){
                final place=filteredPlaces[index];
                return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                  child: PlaceCard(
                    place: place,
                    onFavoritePressed:()=>widget.onFavoriteToggle(place.id),
                    onCardPressed: ()=>_navigateToDetails(context, place),
                  ),
                );
              }
          )
          )
        ],
      ),
    );
  }
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            _searchController.searchQuery.isEmpty
                ? 'No places found'
                : 'No results for "${_searchController.searchQuery}"',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchController.searchQuery.isEmpty
                ? 'Try selecting a different category'
                : 'Try a different search term or category',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _clearSearch,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
            ),
            child: const Text(
              'Clear Search',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
