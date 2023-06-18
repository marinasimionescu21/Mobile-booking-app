import 'package:flutter/material.dart';
import 'package:licenta_app/models/hotels.dart';
import 'package:licenta_app/widgets/hotel_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelItem extends StatelessWidget {
  const HotelItem(
      {Key? key, required this.hotel, required this.onSelectedHotel})
      : super(key: key);
  final Hotels hotel;
  final void Function(Hotels hotel) onSelectedHotel;

  String get affordabilityText {
    return hotel.affordability.name[0].toUpperCase() +
        hotel.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => onSelectedHotel(hotel),
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(hotel.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(children: [
                  Text(
                    hotel.hotelName,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HotelItemTrait(icon: Icons.person, label: hotel.capacity),
                      const SizedBox(width: 45),
                      HotelItemTrait(
                          icon: Icons.attach_money, label: affordabilityText),
                      const SizedBox(width: 45),
                      HotelItemTrait(
                          icon: Icons.attach_money,
                          label: hotel.price.toString()),
                    ],
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
