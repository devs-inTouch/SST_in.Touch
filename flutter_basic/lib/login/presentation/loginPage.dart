import 'package:flutter/material.dart';
import 'package:flutter_basic/login/presentation/recoverPasswordPage.dart';
import 'package:flutter_basic/register/presentation/registerPage.dart';
import 'package:flutter_basic/login/application/loginAuth.dart';
import 'package:flutter_basic/mainpage/presentation/responsive_main_page.dart';
import 'package:flutter_basic/mainpage/presentation/tablet_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/desktop_main_scaffold.dart';
import 'package:flutter_basic/mainpage/presentation/mobile_main_scaffold.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        home: Login());
  }
}

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => LoginHomePage();
}

class LoginHomePage extends State<Login> {
  late TextEditingController usernameControl;
  late TextEditingController pwdControl;

  late String role;

  @override
  void initState() {
    usernameControl = TextEditingController();
    pwdControl = TextEditingController();
    super.initState();
    print("Check PARAM");
    print(Uri.base.queryParameters.containsKey('activated'));
    if (Uri.base.queryParameters.containsKey('activated')) {
      displayActivationMessage();
    }
  }

  bool passwordVisible = true;

  void loginButtonPressed(String username, String pwd) {
    LoginAuth.userLogin(username, pwd).then((AuthResult authResult) {
      if (authResult.getSuccess) {
        role = authResult.getRole;
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
                  SizedBox(height: 40),
                  Image.asset('assets/logo-1-RBH.png', height: 65),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(
                        20.0),
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
                              child: const Text('Esqueceste a tua password?'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RecoverPassword(),
                                  ),
                                );
                              },
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

  void displayActivationMessage() {
    Fluttertoast.showToast(
      msg: 'Your account has been activated!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: primarySwatch,
    );
  }
}
