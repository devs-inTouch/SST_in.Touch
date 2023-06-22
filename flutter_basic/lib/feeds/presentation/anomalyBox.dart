import 'package:flutter/material.dart';
class AnomalyBox extends StatelessWidget {
  final String text;

  const AnomalyBox({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Container(
                  color: Colors.grey[400], // Set the background color of the container to red
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Username"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Date"),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Title",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10), // Add spacing of 10 pixels

              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("Description"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
