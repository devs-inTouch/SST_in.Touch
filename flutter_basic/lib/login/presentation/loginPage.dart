import 'package:flutter/material.dart';
import 'package:flutter_basic/register/presentation/registerPage.dart';
import 'package:flutter_basic/login/application/loginAuth.dart';
import 'package:flutter_basic/mainpage/presentation/responsive_main_page.dart';
import 'package:flutter_basic/mainpage/presentation/tablet_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/desktop_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/mobile_main_scaffold.dart';

import '../../constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primarySwatch,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const Login());
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginHomePage();
}

class LoginHomePage extends State<Login> {
  late TextEditingController usernameControl;
  late TextEditingController pwdControl;

  @override
  void initState() {
    usernameControl = TextEditingController();
    pwdControl = TextEditingController();
    super.initState();
  }

  bool passwordVisible = true;

  void loginButtonPressed(String username, String pwd) {
    LoginAuth.userLogin(username, pwd).then((isLogged) {
      if (isLogged) {
        //AnomalyAuth.listAnomaly();
        //NotificationAuth.notificationList();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ResponsiveLayout(
                    desktopScaffold: DesktopScaffold(),
                    mobileScaffold: MobileScaffold(),
                    tabletScaffold: TabletScaffold())));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Username e password incorretos'),
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
    });
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/logo-1-RBH.png',
                      height: 65,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        20.0), // Add 20 pixels padding to all sides
                    child: Container(
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
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                controller: usernameControl,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                controller: pwdControl,
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
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
                            const SizedBox(
                              height: 25,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size(200, 50),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                loginButtonPressed(
                                    usernameControl.text, pwdControl.text);
                                debugPrint('Received click');
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                debugPrint('Received click');
                              },
                              child: const Text('Esqueceste a senha?'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Não tens conta?',
                              style: TextStyle(fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ),
                                );
                              },
                              child: const Text('Regista-te'),
                            ),
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
