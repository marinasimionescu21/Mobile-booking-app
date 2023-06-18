import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:licenta_app/models/users_hotel.dart';

final formatter = DateFormat.yMd();

class NewHotel extends StatefulWidget {
  const NewHotel({Key? key, required this.onAddHotel}) : super(key: key);

  final void Function(Hotels hotels) onAddHotel;

  @override
  State<NewHotel> createState() {
    return _NewHotelState();
  }
}

class _NewHotelState extends State<NewHotel> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.hotel;

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

  void _submitData() {
    final enteredTitle = _titleController.text.trim();
    final enteredDescription = _descriptionController.text.trim();
    final enteredPrice = double.tryParse(_priceController.text);
    final priceIsInvalid = enteredPrice == null || enteredPrice <= 0;

    if (enteredTitle.isEmpty ||
        enteredDescription.isEmpty ||
        priceIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text('Please enter valid data'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('OK'),
                  )
                ],
              ));
      return;
    }

    widget.onAddHotel(
      Hotels(
        hotelName: enteredTitle,
        description: enteredDescription,
        price: enteredPrice,
        createdAt: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Hotel name'),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLength: 100,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _priceController,
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: 'RON ',
                    label: Text('Price'),
                  ),
                )),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_selectedDate == null
                          ? 'No date chosen'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == null) {
                          return;
                        }
                        _selectedCategory = value;
                      });
                    }),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: _submitData, child: const Text('Save hotel')),
              ],
            )
          ],
        ));
  }
}
