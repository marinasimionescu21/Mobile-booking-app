import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:licenta_app/screen/hotels.dart';
import 'package:licenta_app/widgets/category_grid_item.dart';
import '../models/category.dart';
import '../models/hotels.dart';
import '../newPlaces/providers/user_places.dart';
import '../newPlaces/widgets/places_list.dart';

class PlacesUserScreen extends ConsumerStatefulWidget {
  const PlacesUserScreen({super.key});

  @override
  ConsumerState<PlacesUserScreen> createState() {
    return _PlacesUserScreenState();
  }
}

class _PlacesUserScreenState extends ConsumerState<PlacesUserScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Places added by users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : PlacesList(
                      places: userPlaces,
                    ),
        ),
      ),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key, required this.availableHotels})
      : super(key: key);

  final List<Hotels> availableHotels;

  void _selectCategory(BuildContext context, CategoryOfHotels category) {
    final filteredHotels = availableHotels
        .where((hotel) => hotel.category.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => HotelsScreen(
                  title: category.title,
                  hotels: filteredHotels,
                )));
  }

  void _selectUser(BuildContext context, CategoryOfHotels category) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const PlacesUserScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          if (category.id == 'c5')
            CategoryGridItem(
                category: category,
                onSelectedCategory: () => _selectUser(context, category))
          else
            CategoryGridItem(
                category: category,
                onSelectedCategory: () => _selectCategory(context, category)),
      ],
    );
  }
}
