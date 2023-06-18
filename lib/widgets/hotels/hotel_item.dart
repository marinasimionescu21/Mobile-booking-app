import 'package:flutter/material.dart';
import 'package:licenta_app/models/users_hotel.dart';

class HotelItem extends StatelessWidget {
  const HotelItem({Key? key, required this.hotel}) : super(key: key);

  final Hotels hotel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotel.hotelName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Text('${hotel.price.toStringAsFixed(2)}RON'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[hotel.category]),
                      const SizedBox(width: 4.0),
                      Text(hotel.formattedDate),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
