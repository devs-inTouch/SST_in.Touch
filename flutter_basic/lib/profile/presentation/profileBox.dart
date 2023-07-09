import 'package:flutter/material.dart';

class ProfileBox extends StatefulWidget {
  final double fem;
  final List map;

  const ProfileBox({
    required this.fem,
    required this.map,
  });

  @override
  _ProfileBoxState createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  bool isEditing = false;
  late TextEditingController _textEditingController;
  late String description;

  @override
  void initState() {
    super.initState();
    description = widget.map[2];
    _textEditingController = TextEditingController(text: description);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void startEditing() {
    setState(() {
      isEditing = true;
      _textEditingController.text = description;
    });
  }

  void confirmEditing() {
    setState(() {
      isEditing = false;
      description = _textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 200,
        width: 650,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    color: Colors.blue[50],
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.map[4],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Nº: ${widget.map[5]} \nEmail: ${widget.map[3]} \nDepartamento: ${widget.map[1]}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: isEditing ? confirmEditing : startEditing,
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(100, 50),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            isEditing ? 'Confirmar' : 'Editar',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: isEditing
                  ? TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              )

                  : Text(description),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
