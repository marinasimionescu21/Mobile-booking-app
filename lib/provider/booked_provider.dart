import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/hotels.dart';

class BookedHotelsNotifier extends StateNotifier<List<Hotels>> {
  BookedHotelsNotifier() : super([]);

  bool toggleHotelBookedStatus(Hotels hotel) {
    final hotelIsBooked = state.contains(hotel);

    if (hotelIsBooked) {
      state = state.where((element) => element.id != hotel.id).toList();
      return false;
    } else {
      state = [...state, hotel];
      return true;
    }
  }
}

final bookedsHotelProvider =
    StateNotifierProvider<BookedHotelsNotifier, List<Hotels>>((ref) {
  return BookedHotelsNotifier();
});
