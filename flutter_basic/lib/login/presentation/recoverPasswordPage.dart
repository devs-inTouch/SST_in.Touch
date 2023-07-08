import 'package:flutter/material.dart';
import 'package:flutter_basic/login/presentation/loginPage.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({Key? key});

  @override
  State<RecoverPassword> createState() => RegisterHome();
}

class RegisterHome extends State<RecoverPassword> {
  late TextEditingController emailControl;
  late TextEditingController pwdControl;
  late TextEditingController pwdConfirmControl;
  bool passwordVisible = false;
  bool passwordConfVisible = false;

  @override
  void initState() {
    emailControl = TextEditingController();
    pwdControl = TextEditingController();
    pwdConfirmControl = TextEditingController();
    super.initState();
  }

  void recoverPasswordButtonPressed(
      String email, String pwd, String pwdConfirm) {
    if (email.isNotEmpty && pwd.isNotEmpty && pwd == pwdConfirm) {
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
                              'Recuperação da password',
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
                                controller: emailControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                obscureText: !passwordVisible,
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
                            SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                obscureText: !passwordConfVisible,
                                controller: pwdConfirmControl,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Confirmar password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordConfVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordConfVisible =
                                            !passwordConfVisible;
                                      });
                                    },
                                  ),
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
                                recoverPasswordButtonPressed(
                                  emailControl.text,
                                  pwdControl.text,
                                  pwdConfirmControl.text,
                                );
                              },
                              child: Text(
                                'Recuperar password',
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
                                    builder: (context) => Login(),
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
}
