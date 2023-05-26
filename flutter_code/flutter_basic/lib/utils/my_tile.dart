  import 'package:flutter/material.dart';
  import 'package:flutter_basic/constants.dart';

  class MyTile extends StatelessWidget {
    final String? title;
    final String? content;

    const MyTile({
      Key? key,
       this.title,
       this.content,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: boxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                content!,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
