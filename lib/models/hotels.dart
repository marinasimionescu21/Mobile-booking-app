import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Affordability { affordable, pricey, luxurious }

class Hotels {
  Hotels({
    required this.hotelName,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.createdAt,
    required this.affordability,
    required this.capacity,
    required this.isAffordable,
    required this.isPricy,
    required this.isLuxurious,
  }) : id = uuid.v4();

  final String id;
  final String hotelName;
  final String description;
  final double price;
  final String imageUrl;
  final Affordability affordability;
  final List<String> category;
  final DateTime createdAt;
  final String capacity;
  final bool isAffordable;
  final bool isPricy;
  final bool isLuxurious;

  String get formattedDate {
    return formatter.format(createdAt);
  }

}
