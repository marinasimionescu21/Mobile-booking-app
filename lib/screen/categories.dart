import 'package:flutter/material.dart';
import 'package:licenta_app/models/dummy_data.dart';
import 'package:licenta_app/screen/hotels.dart';
import 'package:licenta_app/widgets/category_grid_item.dart';
import '../models/category.dart';
import '../models/hotels.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key, required this.onToggleFavorite, required this.availableHotels}) : super(key: key);
  
  final void Function(Hotels hotel) onToggleFavorite;
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
                  onToggleFavorite: onToggleFavorite,
                )));
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
          CategoryGridItem(
              category: category,
              onSelectedCategory: () => _selectCategory(context, category)),
      ],
    );
  }
}
