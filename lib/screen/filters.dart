import 'package:flutter/material.dart';
import '../provider/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
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
            value: activeFilters[Filter.afordable]!,
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilters({
                Filter.afordable: isChecked,
                Filter.pricy: activeFilters[Filter.pricy]!,
                Filter.luxurious: activeFilters[Filter.luxurious]!,
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
            value: activeFilters[Filter.pricy]!,
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilters({
                Filter.afordable: activeFilters[Filter.afordable]!,
                Filter.pricy: isChecked,
                Filter.luxurious: activeFilters[Filter.luxurious]!,
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
            value: activeFilters[Filter.luxurious]!,
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilters({
                Filter.afordable: activeFilters[Filter.afordable]!,
                Filter.pricy: activeFilters[Filter.pricy]!,
                Filter.luxurious: isChecked,
              });
            },
          ),
        ],
      ),
    );
  }
}
