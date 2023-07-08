import 'package:flutter/material.dart';
import 'package:flutter_basic/login/presentation/recoverPasswordPage.dart';

import 'newPasswordPage.dart';

class EmailCodePage extends StatefulWidget {
  const EmailCodePage({Key? key});

  @override
  State<EmailCodePage> createState() => EmailCode();
}

class EmailCode extends State<EmailCodePage> {
  late TextEditingController codeControl;

  @override
  void initState() {
    codeControl = TextEditingController();
    super.initState();
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
                  SizedBox(height: 40),
                  Image.asset('assets/logo-1-RBH.png', height: 65),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 475,
                      width: 450,
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
                              'Verificação por Email',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: codeControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Código recebido no email',
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(200, 50),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                // sendEmailCodeRequest(
                                // codeControl.text
                                //);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewPasswordPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Enviar código de verificação',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecoverPassword(),
                                  ),
                                );
                              },
                              child: const Text('Voltar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
/**
  void sendEmailCodeRequest(String controlCode) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(title: Text('Done'));
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
  }**/
}
