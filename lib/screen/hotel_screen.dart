import 'package:flutter/material.dart';
import 'package:licenta_app/models/category.dart';
import 'package:licenta_app/models/users_hotel.dart';
import 'package:licenta_app/widgets/chart/chart.dart';
import 'package:licenta_app/widgets/new_hotel.dart';

final List<Hotels> _registeredHotels = [
  Hotels(
      hotelName: 'Apartment 12',
      description: 'Apartament description',
      price: 200.0,
      createdAt: DateTime.now(),
      category: availableCategoriesMap[Category.hotel]!),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  void _addItem() async {
    final newItem = await Navigator.of(context).push<Hotels>(
      MaterialPageRoute(
        builder: (ctx) => const NewHotel(),
      ),
    );

    if (newItem == null) {
      return;
    }
    setState(() {
      _registeredHotels.add(newItem);
    });
  }

  void _removeItem(Hotels item) {
    final hotelIndex = _registeredHotels.indexOf(item);
    setState(() {
      _registeredHotels.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('${item.hotelName} removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredHotels.insert(hotelIndex, item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        'Nothing found. Start adding ',
        style: TextStyle(color: Colors.white, fontSize: 20),
        selectionColor: Colors.white,
      ),
    );

    if (_registeredHotels.isNotEmpty) {
      content = ListView.builder(
        itemCount: _registeredHotels.length,
        itemBuilder: ((context, index) => Dismissible(
              onDismissed: (direction) {
                _removeItem(_registeredHotels[index]);
              },
              key: ValueKey(_registeredHotels[index].id),
              child: ListTile(
                title: Text(_registeredHotels[index].hotelName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white, fontSize: 20)),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: _registeredHotels[index].category.color,
                ),
                trailing: Text(
                  _registeredHotels[index].price.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
            )),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Properties'),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            Chart(
              hotels: _registeredHotels,
            ),
            Expanded(child: content),
          ],
        ));
  }
}
