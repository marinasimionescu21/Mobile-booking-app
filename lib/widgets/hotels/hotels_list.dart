import 'package:flutter/material.dart';
import 'package:licenta_app/models/hotels.dart';
import 'package:licenta_app/widgets/hotels/hotel_item.dart';

class HotelsList extends StatelessWidget {
  const HotelsList(
      {Key? key, required this.hotels, required this.onRemoveHotel})
      : super(key: key);

  final List<Hotels> hotels;
  final void Function(Hotels hotel) onRemoveHotel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hotels.length,
      itemBuilder: (context, index) => Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.8),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 40.0,
            ),
          ),
          key: ValueKey(hotels[index].id),
          onDismissed: (direction) {
            onRemoveHotel(hotels[index]);
          },
          child: HotelItem(hotel: hotels[index])),
    );
  }
}
