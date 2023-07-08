import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class NucleosAuth {
  /**

  static Future<bool> postNucleosRequest(String title, String mediaURL,
      String description, String socials) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/post/nucleos/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "title": title,
          "mediaUrl": mediaURL,
          "description": description,
          "socials": socials,
        }));

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

   **/



}



