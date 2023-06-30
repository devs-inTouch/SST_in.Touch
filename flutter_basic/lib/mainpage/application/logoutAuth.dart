import 'dart:io';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class LogoutAuth {
  static Future<bool> logout() async {
    String tokenAuth = await getTokenAuth();
    final response = await http.post(
      Uri.parse('https://steel-sequencer-385510.oa.r.appspot.com/rest/logout/'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );
    print("ADASDAS");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
