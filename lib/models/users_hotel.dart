import 'package:licenta_app/models/category.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

const categoryIcons = {
  Category.hotel: Icons.hotel,
  Category.guestHouse: Icons.house,
  Category.apartment: Icons.apartment,
  Category.villa: Icons.villa,
};

class Hotels {
  Hotels({
    required this.id,
    required this.hotelName,
    required this.description,
    required this.price,
    required this.category,
    required this.createdAt,
  });

  final String id;
  final String hotelName;
  final String description;
  final double price;
  final CategoryOfHotels category;
  final DateTime createdAt;

  String get formattedDate {
    return formatter.format(createdAt);
  }
}

class HotelsBucket {
  const HotelsBucket({
    required this.category,
    required this.hotels,
  });

  HotelsBucket.forCategory(List<Hotels> hotels, this.category)
      : hotels =
            // ignore: unrelated_type_equality_checks
            hotels.where((element) => element.category == category).toList();

  final Category category;
  final List<Hotels> hotels;

  double get totalPrice {
    double sum = 0;
    for (final hotel in hotels) {
      sum += hotel.price;
    }
    return sum;
  }
}
