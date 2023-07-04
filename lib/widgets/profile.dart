import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: ListView(children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            buildCoverImage(),
            Positioned(
              top: 225,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey.shade100,
                child: ClipOval(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.blueGrey.shade800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        Text(
          currentUser.email!,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.blueGrey.shade400,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
      ]),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.blueGrey,
        child: Image.asset('assets/images/logo_transparent.png',
            width: double.infinity, height: 280, fit: BoxFit.cover),
      );
}
