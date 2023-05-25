import 'package:flutter/material.dart';
import 'package:flutter_basic/register/application/registerAuth.dart';
import 'package:flutter_basic/register/presentation/registerPage.dart';
import 'package:flutter_basic/login/application/loginAuth.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/responsive_page.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/tablet_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/desktop_scaffold.dart';
import 'package:flutter_basic/responsive_mainpage/presentation/mobile_scaffold.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:ThemeData(
            primaryColor: Colors.blue
        ),
        home: Login()
    );
  }
}

 class Login extends StatefulWidget {

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
      if(isLogged) {
        print(LoginAuth.userLogin(username, pwd));
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResponsiveLayout(desktopScaffold: const DesktopScaffold(), mobileScaffold: const MobileScaffold(), tabletScaffold: const TabletScaffold())
            ));
      }else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
        return AlertDialog(
        title: Text('Username e password incorretos'),
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
        }
    });


  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1440;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(

      body: Container(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/campus-1.png'),
                  fit: BoxFit.cover
              )
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Align(
                alignment: Alignment.topCenter,
                child:
                Image.asset('assets/logo-1-RBH.png', height: 100,)
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: Container(
              height: 475,
              width: 450,
              decoration: BoxDecoration(
                color: Color(0xd8ffffff),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  SizedBox(height: 30,),

                  Text('Login',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  )),
                  SizedBox(height: 40,),
                  Container(
                    width: 250,
                    child: TextField(
                      controller: usernameControl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',

                      ),

                    )
                  ),
                  SizedBox(height: 25,),
                  Container(
                      width: 250,
                      child: TextField(
                        controller: pwdControl,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
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
                  SizedBox(height: 25,),



                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(200,50),
                      backgroundColor: Colors.blue

                    ),
                    
                      onPressed: () {
                        loginButtonPressed(usernameControl.text, pwdControl.text);

                        debugPrint('Received click');

                      },
                      child: Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )
                      )

                    ),
                  SizedBox(height: 5,),
                  TextButton(
                      onPressed: () {
                        debugPrint('Received click');
                      },
                      child: Text('Esqueceste a senha?')
                  ),
                  SizedBox(height: 20,),
                  Text('Não tens conta?',
                    style: TextStyle(
                      fontSize: 15
                    ) ,
                  ),
                  TextButton(
                      onPressed: () {


                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));

                      },
                      child: Text('Regista-te')
                  )
                  

                ],
              )
            )
            )
          ],
        )

            )





      );



  }












}