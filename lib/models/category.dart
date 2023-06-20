import 'package:flutter/material.dart';

enum Category { hotel, guestHouse, apartment, villa }

const availableCategoriesMap = {
  Category.hotel: CategoryOfHotels(
    id: 'c1',
    title: 'Hotels',
    color: Colors.purple,
  ),
  Category.guestHouse: CategoryOfHotels(
    id: 'c2',
    title: 'Guesthouses',
    color: Colors.teal,
  ),
  Category.apartment: CategoryOfHotels(
    id: 'c3',
    title: 'Apartments',
    color: Colors.lime,
  ),
  Category.villa: CategoryOfHotels(
    id: 'c4',
    title: 'Villas',
    color: Colors.lightBlueAccent,
  ),
};

const availableCategories = [
  CategoryOfHotels(
    id: 'c1',
    title: 'Hotels',
    color: Colors.purple,
  ),
  CategoryOfHotels(
    id: 'c2',
    title: 'Guesthouses',
    color: Colors.teal,
  ),
  CategoryOfHotels(
    id: 'c3',
    title: 'Apartments',
    color: Colors.lime,
  ),
  CategoryOfHotels(
    id: 'c4',
    title: 'Villas',
    color: Colors.lightBlueAccent,
  ),
];

class CategoryOfHotels {
  const CategoryOfHotels(
      {required this.id, required this.title, this.color = Colors.amber});

  final String id;
  final String title;
  final Color color;
}
