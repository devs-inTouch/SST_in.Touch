import 'package:flutter/material.dart';
import 'package:flutter_basic/login/presentation/loginPage.dart';
import 'package:flutter_basic/register/application/registerAuth.dart';

const List<String> list = <String>['STUDENT', 'TEACHER', 'STAFF'];


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
    departmentControl = TextEditingController();
    descrpControl = TextEditingController();
    numberControl= TextEditingController();
    courseControl = TextEditingController();


    super.initState();
  }

  String roleValue = list.first;

  void RegisterButtonPressed(String username, String email, String name, String pwd, String studentNumber, String course,
       String description, String department) {

    if(RegisterAuth.registerUser(username, email, name, pwd, studentNumber, course,  description, department) == true) {
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
                    alignment: const Alignment(-0.9,-0.9),
                    child:

                    Image.asset('assets/logo-1-RBH.png', height: 75,)
                ),
                Align(
                    alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height/1.3,
                        width: MediaQuery.of(context).size.width/2.5,
                        decoration: BoxDecoration(
                            color: const Color(0xd8ffffff),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                          child: Scrollbar(
                            child:SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const SizedBox(height: 20,),

                            const Text('Registo',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold
                                )),
                            const SizedBox(height: 20 ,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width/3.8,
                                child: TextField(
                                  controller: usernameControl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Username',

                                  ),

                                )
                            ),
                            const SizedBox(height: 13 ,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width/3.8,
                                child: TextField(
                                  controller: nameControl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nome',

                                  ),

                                )
                            ),
                            const SizedBox(height: 13 ,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width/3.8,
                                child: TextField(
                                  obscureText: passwordVisible,
                                  controller: pwdControl,
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          passwordVisible ? Icons.visibility : Icons.visibility_off,

                                        ),
                                        onPressed: () {
                                          setState( () {
                                            passwordVisible = !passwordVisible;
                                          });

                                        },

                                      )
                                  ),

                                )
                            ),
                            const SizedBox(height: 13 ,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width/3.8,
                                child: TextField(
                                  obscureText: passwordConfVisible,
                                  controller: pwdConfirmControl,
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: 'Confirma Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          passwordConfVisible ? Icons.visibility : Icons.visibility_off,

                                        ),
                                        onPressed: () {
                                          setState( () {
                                            passwordConfVisible = !passwordConfVisible;
                                          });

                                        },

                                      )
                                  ),


                                )
                            ),
                            const SizedBox(height: 13 ,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width/3.8,
                                child: TextField(
                                  controller: emailControl,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Email'
                                  ),

                                )
                            ),
                            const SizedBox(height: 13,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center ,
                              children: [
                                SizedBox(

                                width: MediaQuery.of(context).size.width/7.75,
                                child: TextField(
                                  controller: numberControl,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Número de Aluno'
                                  ),

                                )
                            ),
                            const SizedBox(width: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/7.75,
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



                            const SizedBox(height: 13 ,),


                            SizedBox(
                                width: MediaQuery.of(context).size.width/3.8,
                                child: TextField(
                                  controller: departmentControl,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Departamento'
                                  ),

                                )
                            ),
                            const SizedBox(height: 13 ,),

                            SizedBox(
                                width: MediaQuery.of(context).size.width/3.8,
                                child: TextField(
                                  controller: courseControl,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Curso'
                                  ),

                                )
                            ),const SizedBox(height: 13,),
                            SizedBox(
                                width: MediaQuery.of(context).size.width/3.8,

                                child: TextField(
                                  controller: descrpControl,

                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                  maxLength: 400,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Descrição'
                                  ),

                                )
                            ),const SizedBox(height: 13,),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    fixedSize: const Size(200,50),
                                    backgroundColor: Colors.blue

                                ),

                                onPressed: () {
                                  if(RegisterAuth.emptyFields(usernameControl.text, emailControl.text,
                                      nameControl.text, pwdControl.text, pwdConfirmControl.text)) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Preenchas pelo menos os campos: '
                                              'Username, nome, password e email'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Ok'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  else if(RegisterAuth.hasSpecialChars(pwdControl.text)) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Password contém caracteres inválidos'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Ok'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }else if(pwdConfirmControl.text != pwdControl.text) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Passwords são diferentes!'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Ok'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  else if(!RegisterAuth.isPasswordCompliant(pwdControl.text)) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Password tem de ter no mínimo 5 caracteres,'
                                              'letra maiuscula e um número'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Ok'),
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
                                        pwdControl.text
                                        ,
                                        numberControl.text,
                                        courseControl.text,
                                        descrpControl.text,
                                        departmentControl.text);
                                    debugPrint('Received click');
                                  }
                                },
                                child: const Text('Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    )
                                )


                            )
                              ,const SizedBox(height: 13,),




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