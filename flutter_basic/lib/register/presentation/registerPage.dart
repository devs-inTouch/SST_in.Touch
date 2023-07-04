
import 'package:flutter/material.dart';
import 'package:flutter_basic/login/presentation/loginPage.dart';
import 'package:flutter_basic/register/application/registerAuth.dart';

import '../../backoffice/presentation/backOfficePage.dart';
const List<String> list = <String>['ALUNO', 'PROFESSOR', 'STAFF'];
const List<String> listStaff = <String>[
  'SEGURANÇA',
  'BIBLIOTECA',
  'DIREÇÃO',
  'DIVULGAÇÃO'
];
class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => RegisterHome();


}

class RegisterHome extends State<Register> {

  bool passwordVisible = true;
  bool passwordConfVisible = true;

  late TextEditingController usernameControl;
  late TextEditingController nameControl;
  late TextEditingController emailControl;
  late TextEditingController pwdControl;
  late TextEditingController pwdConfirmControl;
  late TextEditingController roleControl;
  late TextEditingController staffRoleControl;
  late TextEditingController departmentControl, descrpControl,numberControl,
      courseControl;

  @override
  void initState() {
    usernameControl = TextEditingController();
    nameControl = TextEditingController();
    emailControl = TextEditingController();
    pwdControl = TextEditingController();
    pwdConfirmControl = TextEditingController();
    roleControl = TextEditingController();
    staffRoleControl=TextEditingController();
    departmentControl = TextEditingController();
    descrpControl = TextEditingController();
    numberControl= TextEditingController();
    courseControl = TextEditingController();


    super.initState();
  }

  String roleValue = list.first;
  String staffRoleValue=listStaff.first;


  void RegisterButtonPressed(String username, String email, String name, String pwd, String studentNumber, String course,
      String role, String description, String department) {

    if(RegisterAuth.registerUser(username, email, name, pwd, studentNumber, course, role,  description, department) == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
                title: Text('Registado'));});
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/campus-1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Image.asset('assets/logo-1-RBH.png', height: 65),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      width: 450, // Definindo a largura como 450 pixels
                      decoration: BoxDecoration(
                        color: const Color(0xd8ffffff),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Registo',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: usernameControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: nameControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nome',
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                obscureText: passwordVisible,
                                controller: pwdControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                obscureText: passwordConfVisible,
                                controller: pwdConfirmControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Confirma Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordConfVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordConfVisible = !passwordConfVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: emailControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child:
                                  Container(
                                    width: 113,
                                    child: DropdownButton(
                                      value: roleValue,
                                      onChanged: (String? selected) {
                                        if (selected is String) {
                                          setState(() {
                                            roleValue = selected;
                                          });
                                        }
                                      },
                                      items: list
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Visibility(
                                  visible: roleValue == 'STAFF',
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      width: 121,
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
                                  child: SizedBox(width: 10),
                                ),
                                SizedBox(width: 10),
                                Visibility(
                                  visible: roleValue == 'ALUNO',
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Container(
                                      width: 110,
                                      child: TextField(
                                        controller: numberControl,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Número de Aluno',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 13),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                controller: departmentControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Departamento',
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: courseControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Curso',
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: descrpControl,
                                keyboardType: TextInputType.multiline,
                                maxLines: 10,
                                maxLength: 400,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Descrição',
                                ),
                              ),
                            ),
                            SizedBox(height: 13),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(200, 50),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                if (RegisterAuth.emptyFields(
                                    usernameControl.text,
                                    emailControl.text,
                                    nameControl.text,
                                    pwdControl.text,
                                    pwdConfirmControl.text)) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Preenchas pelo menos os campos: '
                                            'Username, nome, password e email'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (RegisterAuth.hasSpecialChars(
                                    pwdControl.text)) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Password contém caracteres inválidos'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (pwdConfirmControl.text !=
                                    pwdControl.text) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Passwords são diferentes!'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (!RegisterAuth.isPasswordCompliant(
                                    pwdControl.text)) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Password tem de ter no mínimo 5 caracteres,'
                                            'letra maiúscula e um número'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  RegisterButtonPressed(
                                    usernameControl.text,
                                    emailControl.text,
                                    nameControl.text,
                                    pwdControl.text,
                                    numberControl.text,
                                    courseControl.text,
                                    roleControl.text,
                                    descrpControl.text,
                                    departmentControl.text,
                                  );
                                  debugPrint('Received click');
                                }
                              },
                              child: Text(
                                'Registar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                              child: const Text('Voltar'),
                            ),
                            SizedBox(height: 13),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),


            ),
          ),
        ),
      ),
    );

  }

}