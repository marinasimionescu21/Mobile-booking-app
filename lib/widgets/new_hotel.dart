// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:licenta_app/models/category.dart';
import 'package:http/http.dart' as http;
import '../models/users_hotel.dart';
import 'dart:convert';

class NewHotel extends StatefulWidget {
  const NewHotel({Key? key}) : super(key: key);

  @override
  State<NewHotel> createState() => _NewHotelState();
}

class _NewHotelState extends State<NewHotel> {
  final _formKey = GlobalKey<FormState>();
  var _hotelName = '';
  var _hotelDescription = '';
  var _hotelPrice = '';
  DateTime? _selectedDate;
  var _selectedCategory = availableCategoriesMap[Category.hotel]!;
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https(
          'hotelbookingapp-marina-default-rtdb.firebaseio.com', 'hotels.json');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'hotelName': _hotelName,
            'description': _hotelDescription,
            'price': _hotelPrice,
            'createdAt': _selectedDate!.toIso8601String(),
            'category': _selectedCategory.title,
          }));

      final Map<String, dynamic> resData = json.decode(response.body);
      if (!context.mounted) return;

      Navigator.of(context).pop();

      Navigator.of(context).pop(Hotels(
          id: resData['id'],
          hotelName: _hotelName,
          description: _hotelDescription,
          price: double.parse(_hotelPrice),
          category: _selectedCategory,
          createdAt: _selectedDate!));
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime.now().subtract(const Duration(days: 365));
    final lastDate = DateTime.now().add(const Duration(days: 365));
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new hotel'),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                maxLength: 50,
                cursorColor: Colors.white,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white, fontSize: 17),
                decoration: const InputDecoration(
                  labelText: 'Hotel name',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Please enter a valid hotel name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _hotelName = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLength: 100,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white, fontSize: 17),
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Please enter a valid description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _hotelDescription = value!;
                },
              ),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white, fontSize: 17),
                    maxLength: 50,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: 'RON ',
                      labelText: 'Price',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _hotelPrice = value!;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      _selectedDate == null
                          ? 'No date chosen'
                          : formatter.format(_selectedDate!),
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                  ]),
                )
              ]),
              const SizedBox(width: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final category in availableCategoriesMap.entries)
                          DropdownMenuItem(
                              value: category.value,
                              child: Row(children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.value.title.toUpperCase(),
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ]))
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: _isSending
                          ? null
                          : () {
                              Navigator.pop(context);
                              _formKey.currentState!.reset();
                            },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: _isSending ? null : _saveItem,
                      child: _isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator())
                          : const Text('Save hotel')),
                ],
              )
            ]),
          )),
    );
  }
}
