import 'dart:convert';
import 'package:emailjs/emailjs.dart';
import 'package:flutter_basic/constants.dart';
import 'package:http/http.dart' as http;

class RecoverPassWordAuth {
  static const String emailJsTemplateID = 'template_04wly35';

  static bool emptyFields(String email) {
    return email.isEmpty;
  }

  static bool hasEmail(String email) {
    String code = createId();
    Map<String, dynamic> obj = {"email": email, "code": code};
    fetchAuthenticate(email).then((response) {
      if (response) {
        sendEmail(obj);
        return true;
      }
    });
    return false;
  }

  static void sendEmail(Map<String, dynamic> obj) async {
    try {
      await EmailJS.send(
        emailJsServiceID,
        emailJsTemplateID,
        obj,
        const Options(
          publicKey: emailJsPublicKey,
          privateKey: emailJsPrivateKey,
        ),
      );
      print('RECOVER SUCCESS!');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
  }
}

Future<bool> fetchAuthenticate(String email) async {
  final response = await http.post(
    Uri.parse('$appUrl/modify/recoverPassword'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"email": email}),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
