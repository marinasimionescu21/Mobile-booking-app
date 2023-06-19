import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startApp, {Key? key}) : super(key: key);

  final void Function() startApp;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_transparent.png',
            width: 450,
          ),
          Row(
            children: [
              const SizedBox(width: 50),
              OutlinedButton(
                  onPressed: startApp,
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 131, 62, 222),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      textStyle: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  child: const Text('Login')),
              const SizedBox(width: 35),
              OutlinedButton(
                  onPressed: startApp,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 131, 62, 222),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    textStyle: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Register')),
            ],
          ),
        ],
      ),
    );
  }
}
