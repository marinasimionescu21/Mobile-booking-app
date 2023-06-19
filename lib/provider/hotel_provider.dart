import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:licenta_app/models/dummy_data.dart';

final hotelProvider = Provider((ref) {
  return dummyHotels;
});
