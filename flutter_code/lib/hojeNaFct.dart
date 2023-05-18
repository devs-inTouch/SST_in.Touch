import 'package:flutter/material.dart';
import 'constants.dart';
import 'dailyInfo.dart';


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
              child: Text('Close'),
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
            padding: EdgeInsets.all(16.0),
              child: Text(
                '-Hoje na FCT-',
                style: textStyleBar,
              ),

          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _showPopup('Provas Académicas', 'Text for Provas Académicas');
              },
              style: buttonStyle,
              child: Text('Provas Académicas'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _showPopup('Avisos', 'Text for Avisos');
              },
              style: buttonStyle,
              child: Text('Avisos'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _showPopup('Exposições', '123');
              },
              style: buttonStyle,
              child: Text('Exposições'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _showPopup('Restauração','123' );
              },
              style: buttonStyle,
              child: Text('Restauração'),
            ),
          ),
        ],
      ),
    );
  }

}
