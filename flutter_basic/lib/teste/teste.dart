import 'package:flutter/material.dart';

import '../anomalies/application/anomalyAuth.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final client = AnomalyAuth();
            const username = 'example_username';
            const title = 'Example Title';
            const description = 'Example Description';

            print("Botão pressionado");
            client.createAnomaly(username, title, description).then((response) {
              print('Response: $response');
            }).catchError((error) {
              print('Error: $error');
            });
          },
          child: const Text('Botão'),
        ),
      ),
    );
  }
}
