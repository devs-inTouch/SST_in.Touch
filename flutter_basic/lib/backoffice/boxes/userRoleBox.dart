import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basic/backoffice/activateUser/application/activateUsersAuth.dart';

import '../../register/presentation/registerPage.dart';

class UserRoleBox extends StatefulWidget {
  final String username;
  final String name;
  final String email;
  late final String role;

  UserRoleBox({
    required this.username,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserRoleBox.fromJson(Map<String, dynamic> json) {
    return UserRoleBox(
      username: json['username'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  @override
  _UserRoleBoxState createState() => _UserRoleBoxState();
}

class _UserRoleBoxState extends State<UserRoleBox> {
  TextEditingController roleController = TextEditingController();
  String selectedRoleValue = '';
  String selectedStaffRoleValue = '';
  String selectedNumber = '';
  List<String> list = ['admin', 'superUser', 'ALUNO'];
  List<String> listStaff = ['role1', 'role2', 'role3'];
  TextEditingController roleControl = TextEditingController();
  TextEditingController numberControl = TextEditingController();
  String roleValue = 'admin';
  String staffRoleValue = 'role1';

  @override
  Widget build(BuildContext context) {
    final borderColor =
        Colors.blueAccent[200]; // Fallback color if blueAccent[200] is null

    return Container(
      decoration: BoxDecoration(
        color: borderColor, // Setting background color to borderColor
        border: Border.all(color: Colors.blueGrey), // Adding border
        borderRadius: BorderRadius.circular(8.0), // Adding border radius
      ),
      padding: EdgeInsets.all(8.0), // Adding padding
      child: ListTile(
        title: Text(
          'Username: ${widget.username}',
          style: TextStyle(
            color: Colors.white, // Setting text color to white
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.0), // Adding padding between texts
            Text(
              'Name: ${widget.name}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Email: ${widget.email}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Role:${widget.role}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        trailing: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Editar Role'),
                      content: Container(
                        width: double.maxFinite,
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 130,
                            child: DropdownButton(
                              value: roleValue,
                              onChanged: (String? selected) {
                                if (selected is String) {
                                  setState(() {
                                    roleValue = selected;
                                  });
                                }
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Visibility(
                          visible: roleValue == 'STAFF',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: 135,
                              child: DropdownButton(
                                value: staffRoleValue,
                                onChanged: (String? selected) {
                                  if (selected is String) {
                                    setState(() {
                                      staffRoleValue = selected;
                                      if (roleValue == 'STAFF') {
                                        roleControl.text = selected;
                                      }
                                    });
                                  }
                                },
                                items: listStaff.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: roleValue == 'ALUNO',
                          child: const SizedBox(width: 10),
                        ),
                        const SizedBox(width: 10),
                        Visibility(
                          visible: roleValue == 'ALUNO',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SizedBox(
                              width: 110,
                              child: TextField(
                                controller: numberControl,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Número de Aluno',
                                ),
                              ),
                            ),
                          ),
                        ),


                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.role = selectedRoleValue;
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Guardar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Text('Editar Role'),
              ),

            );
          },
        ),
      ),
    );
  }
}
