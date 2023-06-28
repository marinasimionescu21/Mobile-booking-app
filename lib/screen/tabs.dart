import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:licenta_app/chattapp/screens/logout.dart';
import 'package:licenta_app/newPlaces/screens/places.dart';
import 'package:licenta_app/screen/categories.dart';
import 'package:licenta_app/screen/filters.dart';
import 'package:licenta_app/screen/hotels.dart';
import 'package:licenta_app/screen/map.dart';
import 'package:licenta_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:licenta_app/provider/favorites_provider.dart';

import '../chattapp/screens/chat.dart';
import '../provider/filters_provider.dart';

const kInitialFilters = {
  Filter.afordable: false,
  Filter.pricy: false,
  Filter.luxurious: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (ctx) => const FilterScreen(),
      ));
    }
    if (identifier == 'addPlace' && context.mounted) {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const PlacesScreen()));
    }
    if (identifier == 'chat') {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const ChatScreen()));
    }

    if (identifier == 'livetour') {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const ChatScreen()));
    }

    if (identifier == 'livetour') {
      await IconButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        icon: Icon(
          Icons.exit_to_app,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableHottels = ref.watch(filteredHotelsProvider);
    Widget activePage = CategoriesScreen(
      availableHotels: availableHottels,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = const MapPage();
      activePageTitle = 'Map';
    }

    if (_selectedPageIndex == 2) {
      final favoriteHotels = ref.watch(favoritesHotelProvider);
      activePage = HotelsScreen(
        hotels: favoriteHotels,
      );
      activePageTitle = 'Favorites';
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
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
