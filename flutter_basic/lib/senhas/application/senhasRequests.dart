import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../constants.dart';

class SenhasRequests {

  static Future<bool> createQRCode(String code, String number) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
        Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/senhas/create/'),
        headers: <String,String> {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "code": code,
          "numero": number
        })
    );

    if(response.statusCode == 200) {
      return true;
    }
    return false;

  }

  static Future<bool> checkSenha(String code, String number) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
        Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/senhas/check/'),
        headers: <String,String> {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "code": code,
          "numero": number
        })
    );

    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<String> getPersonalCode() async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
        Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/senhas/getCode/'),
        headers: <String,String> {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        }
    );

    String code = '';

    if(response.statusCode == 200) {
      code = jsonDecode(response.body);
    }
    return code;

  }


  static Future<String> getLido() async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
        Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/senhas/getLido/'),
        headers: <String,String> {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },

    );
    String res = '';
    if(response.statusCode == 200) {
      res = response.body;
    }
    return res;
  }

  static Future<String> getResto() async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/senhas/getResto/'),
      headers: <String,String> {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: tokenAuth
      },

    );
    String res = '';
    if(response.statusCode == 200) {
      res = response.body;
    }
    return res;
  }

}