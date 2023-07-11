
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/backoffice/application/salasRequestAuth.dart';

class UsersToAtivateBox  extends StatelessWidget {
  final String targetUsername;

  UsersToAtivateBox({
    required this.targetUsername,
  });

  factory UsersToAtivateBox.fromJson(Map<String, dynamic> json) {
    return UsersToAtivateBox(
      targetUsername: json['targetUsername'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('targetUsername: $targetUsername'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        /**    Text('Room: $room'),
            Text('Department: $department'),
            Text('Number of Students: $numberStudents'),
            Text('Date: $date'),
            Text('Hour: $hour'),
            **/
            ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                SalasRequestAuth.approveReservation();
                print("aproved");

              },
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                SalasRequestAuth.denyReservation();
                print("denied");

              },
            ),
          ],
        ),
      ),
    );
  }
}