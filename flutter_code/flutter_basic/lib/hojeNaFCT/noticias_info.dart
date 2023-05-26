import 'package:flutter/material.dart';

import '../constants.dart';

class NoticiasPage extends StatelessWidget {
  const NoticiasPage({super.key});

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
                'Notícias',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text(
                  'Sem notícias',
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
