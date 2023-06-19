import 'package:flutter/material.dart';

enum Filter {
  afordable,
  pricy,
  luxurious,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _afordableFilterSet = false;
  var _pricyFilterSet = false;
  var _luxFilterSet = false;

  @override
  void initState() {
    super.initState();
    _afordableFilterSet = widget.currentFilters[Filter.afordable]!;
    _pricyFilterSet = widget.currentFilters[Filter.pricy]!;
    _luxFilterSet = widget.currentFilters[Filter.luxurious]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        // drawer: MainDrawer(onSelectedScreen: (identifier) {
        //   Navigator.of(context).pop();
        //   if (identifier == 'hotels') {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(builder: (ctx) => const TabsScreen()),
        //     );
        //   }
        // }),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop({
              Filter.afordable: _afordableFilterSet,
              Filter.pricy: _pricyFilterSet,
              Filter.luxurious: _luxFilterSet,
            });
            return false;
          },
          child: Column(
            children: [
              SwitchListTile(
                title: Text('Afordable',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                subtitle: Text('Only include afordable places',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                value: _afordableFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _afordableFilterSet = isChecked;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Pricy',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                subtitle: Text('Only include pricy places',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                value: _pricyFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _pricyFilterSet = isChecked;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Luxurious',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                subtitle: Text('Only include luxurious places',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                value: _luxFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _luxFilterSet = isChecked;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
