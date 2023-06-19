import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:licenta_app/provider/hotel_provider.dart';

enum Filter {
  afordable,
  pricy,
  luxurious,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.afordable: false,
          Filter.pricy: false,
          Filter.luxurious: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool value) {
    state = {
      ...state,
      filter: value,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredHotelsProvider = Provider((ref) {
  final hotels = ref.watch(hotelProvider);
  final activeFilters = ref.watch(filtersProvider);

  return hotels.where((element) {
    if (activeFilters[Filter.afordable]! && !element.isAffordable) {
      return false;
    }
    if (activeFilters[Filter.pricy]! && !element.isPricy) {
      return false;
    }
    if (activeFilters[Filter.luxurious]! && !element.isLuxurious) {
      return false;
    }
    return true;
  }).toList();
});
