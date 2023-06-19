import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/hotels.dart';

class FavoriteHotelsNotifier extends StateNotifier<List<Hotels>> {
  FavoriteHotelsNotifier() : super([]);

  bool toggleHotelFavoriteStatus(Hotels hotel) {
    final hotelIsFavorite = state.contains(hotel);

    if (hotelIsFavorite) {
      state = state.where((element) => element.id != hotel.id).toList();
      return false;
    } else {
      state = [...state, hotel];
      return true;
    }
  }
}

final favoritesHotelProvider =
    StateNotifierProvider<FavoriteHotelsNotifier, List<Hotels>>((ref) {
  return FavoriteHotelsNotifier();
});
