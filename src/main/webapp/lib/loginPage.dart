import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


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

class Login extends StatelessWidget {

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
              )
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child:
                Image.asset('assets/logo-1-RBH.png', height: 150,)
            ),

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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',

                      ),

                    )
                  ),
                  SizedBox(height: 25,),
                  Container(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password'
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
                        debugPrint('Received click');
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