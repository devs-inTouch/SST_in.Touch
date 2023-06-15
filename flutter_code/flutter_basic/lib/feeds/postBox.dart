import 'package:flutter/material.dart';

class PostBox extends StatelessWidget{

  final String text;

  const PostBox({super.key, 
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 200,
        width: 650,
        decoration: const BoxDecoration(
          color: Colors.red
        ),
      child: Center(child: Text(text)),
     )
    );
  }

}