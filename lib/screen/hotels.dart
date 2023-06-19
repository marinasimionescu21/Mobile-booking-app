import 'package:flutter/material.dart';
import 'package:licenta_app/screen/hotel_details.dart';
import '../widgets/hotel_item.dart';
import '../models/hotels.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen(
      {Key? key,
      this.title,
      required this.hotels,
      })
      : super(key: key);
  final String? title;
  final List<Hotels> hotels;

  void selectHotel(BuildContext context, Hotels hotel) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => HotelDetailsScreen(
              hotel: hotel,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) => HotelItem(
              hotel: hotels[index],
              onSelectedHotel: (hotel) {
                selectHotel(context, hotel);
              },
            ));

    if (hotels.isEmpty) {
      content = Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text(
          'Uh oh, no hotels found here!',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text('Try changing the filters and search again.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
      ]));
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
