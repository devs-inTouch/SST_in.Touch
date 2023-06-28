import 'package:flutter/material.dart';
import '../anomalies/application/anomalyAuth.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                List anomalies = [];

                print("Botão pressionado Anomaly");
                anomalies = await AnomalyAuth.getAnomaliesList();
                print(anomalies);
              },
              child: const Text('Anomalias'),
            ),
          ],
        ),
      ),
    );
  }
}
