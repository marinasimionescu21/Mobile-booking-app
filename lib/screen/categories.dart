import 'package:flutter/material.dart';
import 'package:licenta_app/models/dummy_data.dart';
import 'package:licenta_app/screen/hotels.dart';
import 'package:licenta_app/widgets/category_grid_item.dart';
import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  void _selectCategory(BuildContext context, CategoryOfHotels category) {
    final filteredHotels = dummyHotels
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: GridView(
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
        ));
  }
}
