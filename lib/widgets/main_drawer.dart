import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key, required this.onSelectedScreen})
      : super(key: key);

  final void Function(String identifier) onSelectedScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      DrawerHeader(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Row(children: [
          Icon(Icons.apartment,
              size: 35, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 18),
          Text(
            'LodgingEase',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          )
        ]),
      ),
      ListTile(
        leading: Icon(
          Icons.person,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        onTap: () {
          onSelectedScreen('profile');
        },
      ),
      ListTile(
        leading: Icon(
          Icons.map,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Map',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        onTap: () {
          onSelectedScreen('map');
        },
      ),
      ListTile(
        leading: Icon(
          Icons.add_home_outlined,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Add Place',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        onTap: () {
          onSelectedScreen('addPlace');
        },
      ),
      ListTile(
        leading: Icon(
          Icons.quick_contacts_mail_sharp,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Chat',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        onTap: () {
          onSelectedScreen('chat');
        },
      ),
      ListTile(
        leading: Icon(
          Icons.live_tv_sharp,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Livetour',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        onTap: () {
          onSelectedScreen('livetour');
        },
      ),
      ListTile(
        leading: Icon(
          Icons.settings,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Filters',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        onTap: () {
          onSelectedScreen('filters');
        },
      ),
      ListTile(
        leading: Icon(
          Icons.exit_to_app,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Logout',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        onTap: () {
          FirebaseAuth.instance.signOut();
        },
      ),
    ]));
  }
}
