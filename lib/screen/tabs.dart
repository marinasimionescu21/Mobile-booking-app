// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:licenta_app/newPlaces/screens/places.dart';
import 'package:licenta_app/provider/booked_provider.dart';
import 'package:licenta_app/screen/categories.dart';
import 'package:licenta_app/screen/filters.dart';
import 'package:licenta_app/screen/hotels.dart';
import 'package:licenta_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:licenta_app/provider/favorites_provider.dart';

import '../chattapp/screens/chat.dart';
import '../map/screens/current_location_screen.dart';
import '../models/hotels.dart';
import '../provider/filters_provider.dart';
import '../videocall/pages/index.dart';
import '../widgets/profile.dart';

const kInitialFilters = {
  Filter.afordable: false,
  Filter.pricy: false,
  Filter.luxurious: false,
};

List<Hotels> hotelsBooked = [];
double total = 0;

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 1)),
      end: DateTime.now());

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateTimeRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return;

    setState(() => dateTimeRange = newDateRange);
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
          .push(MaterialPageRoute(builder: (ctx) => const IndexPage()));
    }
    if (identifier == 'profile') {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
    }
    if (identifier == 'map') {
      await Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const CurrentLocationScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    double totalPrice = 0;

    final availableHottels = ref.watch(filteredHotelsProvider);
    Widget activePage = CategoriesScreen(
      availableHotels: availableHottels,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteHotels = ref.watch(favoritesHotelProvider);
      activePage = HotelsScreen(
        hotels: favoriteHotels,
      );
      activePageTitle = 'Favorites';
    }

    if (_selectedPageIndex == 2) {
      final bookedHotels = ref.watch(bookedsHotelProvider);
      activePage = HotelsScreen(
        hotels: bookedHotels,
      );
      activePageTitle = 'Bookings';

      double returnTotalPrice() {
        var element = bookedHotels.first;
        totalPrice = (element.price * dateTimeRange.duration.inDays);
        total = totalPrice;
        setState(() {});

        return total;
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(activePageTitle),
          actions: [
            IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {
                  hotelsBooked.add(bookedHotels.first);
                  bookedHotels.clear();
                  setState(() {});
                  total = 0;
                }),
            IconButton(
                icon: const Icon(Icons.account_balance_wallet_outlined),
                onPressed: returnTotalPrice),
          ],
        ),
        drawer: MainDrawer(onSelectedScreen: _setScreen),
        body: Stack(children: [
          activePage,
          Positioned(
            bottom: 75,
            left: 0,
            right: 0,
            child: Text('Total price $total',
                style: const TextStyle(fontSize: 20, color: Colors.blueGrey)),
          ),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: pickDateRange,
                        child:
                            Text('${start.day}/${start.month}/${start.year}')),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: pickDateRange,
                        child: Text('${end.day}/${end.month}/${end.year}')),
                  ),
                ],
              ))
        ]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.house_siding), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_online), label: 'Bookings'),
          ],
        ),
      );
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
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: 'Bookings'),
        ],
      ),
    );
  }
}
