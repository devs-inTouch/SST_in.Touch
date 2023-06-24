import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../myAppBar.dart';

class ReservaSalasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Colors.grey[300],
      body: Center( // Center widget added here
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'RESERVAR SALA',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: FractionallySizedBox(
                    widthFactor: screenWidth < 700 ? 1.0 : 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.zero,
                                          child: Text(
                                            'DEPARTAMENTO',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.zero,
                                          child: Text(
                                            'SALA',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      // Add your desired action when the button is pressed
                                    },
                                    child: Text(
                                      'VERIFICAR DISPONIBILIDADE',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.zero,
                                    child: Text(
                                      'NÚMERO DE ALUNOS',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.zero,
                                    child: Text(
                                      'DATA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.zero,
                                    child: Text(
                                      'HORA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                // Add your desired action when the button is pressed
                              },
                              child: Text(
                                'CONFIRMAR RESERVA',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
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
            ],
          ),
        ),
      ),
    );
  }
}
