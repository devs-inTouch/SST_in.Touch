import 'package:flutter/material.dart';
import 'constants.dart';


class HojeNaFctBox extends StatefulWidget {

  const HojeNaFctBox({Key? key,}) : super(key: key);

  @override
  _HojeNaFctBox createState() => _HojeNaFctBox();
}class _HojeNaFctBox extends State<HojeNaFctBox> {
  void _showPopup(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxMainMenuDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            decoration: topBarDecoration,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '-Hoje na FCT-',
              style: textStyleBar,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showPopup(
                            'Provas Académicas', 'Text for Provas Académicas');
                      },
                      style: buttonStyle,
                      child: const Text('Provas Académicas'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showPopup('Avisos', 'Text for Avisos');
                      },
                      style: buttonStyle,
                      child: const Text('Avisos'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showPopup('Exposições', '123');
                      },
                      style: buttonStyle,
                      child: const Text('Exposições'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showPopup('Restauração', '123');
                      },
                      style: buttonStyle,
                      child: const Text('Restauração'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
