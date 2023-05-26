import 'package:flutter/material.dart';

import '../constants.dart';

class RestauracaoPage extends StatelessWidget {
  const RestauracaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: 500,
        decoration: boxDecoration,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Menu for Cantina X',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text(
                  'Menu content for Cantina X',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Menu for Restaurante X',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text(
                  'Menu content for Restaurante X',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Menu for Restaurante Y',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text(
                  'Menu content for Restaurante Y',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Menu for Restaurante Z',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text(
                  'Menu content for Restaurante Z',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
