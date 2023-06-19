import 'package:flutter/material.dart';
import 'package:licenta_app/models/dummy_data.dart';
import 'package:licenta_app/models/hotels.dart';
import 'package:licenta_app/screen/categories.dart';
import 'package:licenta_app/screen/filters.dart';
import 'package:licenta_app/screen/hotel_screen.dart';
import 'package:licenta_app/screen/hotels.dart';
import 'package:licenta_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.afordable: false,
  Filter.pricy: false,
  Filter.luxurious: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Hotels> _favoriteHotels = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _toggleHotelFavoriteStatus(Hotels hotels) {
    final isExisting = _favoriteHotels.contains(hotels);

    if (isExisting) {
      setState(() {
        _favoriteHotels.remove(hotels);
        _showInfoMessage('Removed from favorites');
      });
    } else {
      setState(() {
        _favoriteHotels.add(hotels);
        _showInfoMessage('Added to favorites');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (ctx) => FilterScreen(
          currentFilters: _selectedFilters,
        ),
      ));

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableHottels = dummyHotels.where((element) {
      if (_selectedFilters[Filter.afordable]! && !element.isAffordable) {
        return false;
      }
      if (_selectedFilters[Filter.pricy]! && !element.isPricy) {
        return false;
      }
      if (_selectedFilters[Filter.luxurious]! && !element.isLuxurious) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleHotelFavoriteStatus,
      availableHotels: availableHottels,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = HotelsScreen(
        hotels: _favoriteHotels,
        onToggleFavorite: _toggleHotelFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }

    if (_selectedPageIndex == 2) {
      activePage = const HomeScreen();
      activePageTitle = 'Profile';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.house_siding), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
