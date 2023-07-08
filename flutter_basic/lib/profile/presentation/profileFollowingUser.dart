import 'package:flutter/material.dart';

class ProfileThirdParty extends StatefulWidget {
  final double fem;
  final List map;

  const ProfileThirdParty({
    required this.fem,
    required this.map,
  });

  @override
  _ProfileBoxState createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileThirdParty> {
  bool isFollowing = false;


  @override
  void initState() {
    super.initState();
  }
  void startFollowing() {
    setState(() {
      isFollowing = true;
    });
  }
  void stopFollowing() {
    setState(() {
      isFollowing = false;
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
                    padding: EdgeInsets.symmetric(vertical: 10), // Add vertical padding between the buttons
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 20), // Add horizontal spacing between the buttons
                        OutlinedButton(
                          onPressed: isFollowing ? stopFollowing : startFollowing, // Replace the onPressed function with the appropriate action for the button
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(100, 50),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            isFollowing ? 'Seguir' : 'A seguir',
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
          ],
        ),
      ),
    );
  }
}
