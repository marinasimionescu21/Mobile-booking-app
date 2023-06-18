import 'package:flutter/material.dart';
import 'package:licenta_app/models/category.dart';
import 'package:licenta_app/models/hotels.dart';

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

List<Hotels> dummyHotels = [
  Hotels(
      hotelName: 'Leonardo Hotel',
      description:
          'Located directly in the heart of Bucharest, the hotel is the perfect place to start exploring the beautiful and historical city. With the main attractions just around the corner and only a few minutes walking distance away, you have everything you need for a relaxed stay. Whether you decide to spend the day sightseeing, trying out one of the plenty cafés or restaurants, or simply enjoying the hotel itself, you are always in for a treat.',
      price: 200.0,
      affordability: Affordability.affordable,
      imageUrl:
          'https://static.leonardo-hotels.com/image/leonardohotelbucharestcitycenter_room_comfortdouble2_2022_4000x2600_7e18f254bc75491965d36cc312e8111f_1200x780_mobile_3.jpeg',
      category: ['c1'],
      createdAt: DateTime.now(),
      capacity: '2'),
  Hotels(
    hotelName: 'Cali Mykonos',
    description:
        'Why book a room when you could have an entire villa? That is the thinking behind uber-luxury new boutique resort Cali Mykonos. Comprised of 40 contemporary white-washed villas standing on their own private beach on Greece’s most famous island, each has gorgeous sea views, a private pool and al fresco dining space primed for private dinners.',
    price: 350.0,
    imageUrl:
        'https://luxurylondon.co.uk/wp-content/uploads/2022/08/cali-mykonos-3.jpg',
    category: ['c4'],
    createdAt: DateTime.now(),
    affordability: Affordability.luxurious,
    capacity: '10',
  ),
  Hotels(
    hotelName: 'Raffles Hotel',
    description:
        'Think there isn’t room for another grand dame five-star hotel in London? Think again. In 2022, the city will welcome a new branch of Raffles, which will open in The OWO as part of the major redevelopment of the Grade II-listed Old War Office in Whitehall.',
    price: 400.0,
    imageUrl:
        'https://www.raffles.com/assets/0/72/651/652/1706/86a76937-c8af-4c79-a945-700636eb2412.jpg',
    category: ['c1'],
    createdAt: DateTime.now(),
    affordability: Affordability.luxurious,
    capacity: '4',
  ),
  Hotels(
    hotelName: 'Guest House Forno',
    description:
        'Providing garden views, free bikes and free WiFi, Guest House Forno provides accommodation conveniently set in Búzios, within a short distance of Forno Beach, Canto Beach and Foca Beach. All units feature air conditioning and a satellite flat-screen TV. There is a fully equipped private bathroom with shower and free toiletries.',
    price: 329,
    imageUrl:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/216780855.jpg?k=ad5beda8281640ed462f455c69c6c1afbbc570a826c48113217901f281b25bd6&o=&hp=1',
    category: ['c2'],
    createdAt: DateTime.now(),
    affordability: Affordability.pricey,
    capacity: '8',
  ),
  Hotels(
    hotelName: 'Clifton House',
    description:
        'Sleeps Up To: Up to 4. Apartment Size: Single, Double, King, Twin & Super King Studio’s & One Beds. From price: £58 per night. Nearby: Whiteladies Road & The Clifton Triangle which has heaps of restaurants, bars & shops',
    price: 337,
    imageUrl: 'https://www.yourapartment.com/wp-content/uploads/2021/09/64.jpg',
    category: ['c3'],
    createdAt: DateTime.now(),
    affordability: Affordability.pricey,
    capacity: '4',
  )
];
