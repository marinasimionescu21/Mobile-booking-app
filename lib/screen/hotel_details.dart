import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hotels.dart';
import '../provider/favorites_provider.dart';

class HotelDetailsScreen extends ConsumerWidget {
  const HotelDetailsScreen({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotels hotel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteHotels = ref.watch(favoritesHotelProvider);
    final isFavorite = favoriteHotels.contains(hotel);

    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotelName),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoritesHotelProvider.notifier)
                  .toggleHotelFavoriteStatus(hotel);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Hotel added as a favorite' : 'Hotel removed'),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
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
