import 'package:flutter/material.dart';
import 'package:flutter_basic/login/presentation/emailCodePage.dart';
import 'package:flutter_basic/login/presentation/loginPage.dart';

import '../application/recoverPassWordAuth.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({Key? key});

  @override
  State<RecoverPassword> createState() => RegisterHome();
}

class RegisterHome extends State<RecoverPassword> {
  late TextEditingController emailControl;
  bool passwordVisible = false;
  bool passwordConfVisible = false;

  @override
  void initState() {
    emailControl = TextEditingController();
    super.initState();
  }

  Future<void> recoverPasswordButtonPressed(String email) async {
    if (emailControl.text.isNotEmpty) {
      bool res = await RecoverPassWordAuth.hasEmail(emailControl.text);
      print(res);
      if (res) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmailCodePage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Email not found.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Tem de preencher com um email válido.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
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
                  const SizedBox(height: 40),
                  Image.asset('assets/logo-1-RBH.png', height: 65),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 300,
                      width: 450,
                      decoration: BoxDecoration(
                        color: const Color(0xd8ffffff),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Recuperação da password',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: 250,
                                child: TextField(
                                  controller: emailControl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size(200, 50),
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Recuperar password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                recoverPasswordButtonPressed(emailControl.text);
                              },
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              child: const Text('Voltar'),
                              onPressed: () {
                                RecoverPassWordAuth.hasEmail(emailControl.text);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
