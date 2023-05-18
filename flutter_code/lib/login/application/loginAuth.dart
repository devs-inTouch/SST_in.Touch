import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html';

class LoginAuth {



  static Future<bool> userLogin(String username,String pwd) async {
    print("aqui");
    bool res = await fetchAuthenticate(username, pwd);

    return res;

  }

  static Future<bool> fetchAuthenticate(String username, String pwd) async {

    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username":username,
        "password":pwd,

      }),
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
        print("RESPOSTA: $jsonResponse");
        window.sessionStorage["Token"] = json.encode(json.decode(response.body));
        return true;
    } else {
      return false;
    }
  }
}