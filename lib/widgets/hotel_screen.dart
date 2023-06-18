import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:licenta_app/models/hotels.dart';
import 'package:licenta_app/widgets/chart/chart.dart';
import 'package:licenta_app/widgets/hotels/hotels_list.dart';
import 'package:licenta_app/widgets/new_hotel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Hotels> _registeredHotels = [
    Hotels(
        hotelName: 'Hotel 1',
        description: 'Hotel 1 description',
        price: 100.0,
        //imageUrl: 'assets/images/hotel1.jpg',
        createdAt: DateTime.now(),
        category: Category.hotel),
    Hotels(
        hotelName: 'Hotel 2',
        description: 'Hotel 2 description',
        price: 200.0,
        //imageUrl: 'assets/images/hotel2.jpg',
        createdAt: DateTime.now(),
        category: Category.apartment),
    Hotels(
        hotelName: 'Hotel 3',
        description: 'Hotel 3 description',
        price: 300.0,
        //imageUrl: 'assets/images/hotel3.jpg',
        createdAt: DateTime.now(),
        category: Category.guestHouse),
  ];

  _openAddHotelScreen() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewHotel(onAddHotel: _addHotel));
  }

  void _addHotel(Hotels hotels) {
    setState(() {
      _registeredHotels.add(hotels);
    });
  }

  void _removeHotel(Hotels hotel) {
    final hotelIndex = _registeredHotels.indexOf(hotel);
    setState(() {
      _registeredHotels.remove(hotel);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('${hotel.hotelName} removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredHotels.insert(hotelIndex, hotel);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text('Nothing found. Start adding '),
    );

    if (_registeredHotels.isNotEmpty) {
      mainContent = HotelsList(
        hotels: _registeredHotels,
        onRemoveHotel: _removeHotel,
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddHotelScreen,
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text('LodgingEase'),
      ),
      body: Column(
        children: [
          Chart(hotels: _registeredHotels),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
