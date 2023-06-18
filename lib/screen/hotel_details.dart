import 'package:flutter/material.dart';

import '../models/hotels.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({Key? key, required this.hotel, required this.onToggleFavorite}) : super(key: key);

  final Hotels hotel;
  final void Function(Hotels hotel) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotelName),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavorite(hotel);
            },
            icon: const Icon(Icons.star),
          )
        ],
      ),
      body: Column(
        children: [
          Image.network(
            hotel.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 14),
          Text('Details',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          Text(hotel.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground))
        ],
      ),
    );
  }
}
