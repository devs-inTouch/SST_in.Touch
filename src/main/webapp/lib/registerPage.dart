import 'package:flutter/material.dart';
import 'package:flutter_basic/loginPage.dart';
import 'package:flutter_basic/register/application/registerRequest.dart';

const List<String> list = <String>['STUDENT', 'TEACHER', 'STAFF'];



class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => RegisterHome();


}

class RegisterHome extends State<Register> {
  late TextEditingController usernameControl;
  late TextEditingController nameControl;
  late TextEditingController emailControl;
  late TextEditingController pwdControl;
  late TextEditingController pwdConfirmControl;
  late TextEditingController roleControl;
  late TextEditingController departmentControl;

  @override
  void initState() {
    usernameControl = TextEditingController();
    nameControl = TextEditingController();
    emailControl = TextEditingController();
    pwdControl = TextEditingController();
    pwdConfirmControl = TextEditingController();
    roleControl = TextEditingController();
    departmentControl = TextEditingController();


    super.initState();
  }

  String roleValue = list.first;

  void RegisterButtonPressed(String username, String email, String name, String pwd, String pwdConfirmation,
      String role, String department) {

    if(RegisterAuth.registerUser(username, email, name, pwd, pwdConfirmation, role, department)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1440;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(

        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/campus-1.png'),
                    fit: BoxFit.cover
                ),

            ),

            child: Stack(

              children: [
                Align(
                    alignment: Alignment(-0.9,-0.9),
                    child:

                    Image.asset('assets/logo-1-RBH.png', height: 75,)
                ),


                Align(
                    alignment: Alignment.center,




                      child: Container(
                        height: 650,
                        width: 450,
                        decoration: BoxDecoration(
                            color: Color(0xd8ffffff),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                          child: Scrollbar(
                            child:SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            SizedBox(height: 20,),

                            Text('Registo',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold
                                )),
                            SizedBox(height: 18 ,),
                            Container(
                                width: 300,
                                child: TextField(
                                  controller: usernameControl,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Username',

                                  ),

                                )
                            ),
                            SizedBox(height: 10 ,),
                            Container(
                                width: 300,
                                child: TextField(
                                  controller: nameControl,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nome',

                                  ),

                                )
                            ),
                            SizedBox(height: 10 ,),
                            Container(
                                width: 300,
                                child: TextField(
                                  controller: pwdControl,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password'
                                  ),

                                )
                            ),
                            SizedBox(height: 10 ,),
                            Container(
                                width: 300,
                                child: TextField(
                                  controller: pwdConfirmControl,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Confirma Password'
                                  ),

                                )
                            ),
                            SizedBox(height: 10 ,),
                            Container(
                                width: 300,
                                child: TextField(
                                  controller: emailControl,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Email'
                                  ),

                                )
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center ,
                              children: [
                                Container(

                                width: 150,
                                child: TextField(

                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Número de Aluno'
                                  ),

                                )
                            ),
                            SizedBox(width: 40,),
                            Container(
                              width: 110,
                            child: DropdownButton(


                              value:  roleValue,

                              onChanged: (String? selected) {
                                if(selected is String) {
                                  setState(() {
                                    roleValue = selected;
                                  }

                                  );
                                }

                              },
                              items: list.map<DropdownMenuItem<String>>((String value){
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value)
                                );
                              }).toList()),

                            )
                              ]),



                            SizedBox(height: 10 ,),


                            Container(
                                width: 300,
                                child: TextField(
                                  controller: departmentControl,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Departamento'
                                  ),

                                )
                            ),
                            SizedBox(height: 10 ,),

                            Container(
                                width: 300,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Curso'
                                  ),

                                )
                            ),SizedBox(height: 10,),
                            Container(
                                width: 300,

                                child: TextField(
                                  controller: TextEditingController(),

                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                  maxLength: 400,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Descrição'
                                  ),

                                )
                            ),SizedBox(height: 10,),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    fixedSize: Size(200,50),
                                    backgroundColor: Colors.blue

                                ),

                                onPressed: () {
                                  RegisterButtonPressed(usernameControl.text, emailControl.text, nameControl.text, pwdControl.text
                                      , pwdConfirmControl.text, roleValue, departmentControl.text);
                                  debugPrint('Received click');
                                },
                                child: Text('Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    )
                                )


                            )
                              ,SizedBox(height: 10,),




                          ],
                        )
                    )
                    )
                    )
                )
              ],
            )

        )





    );



  }



}