import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../presentation/nucleosBox.dart';

class NucleosAuth {

  static makeNucleoRequest(String title, String description, String faceUrl, String instaUrl, String twitterUrl) async {
    String tokenAuth = await getTokenAuth();


    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/nucleo/create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: tokenAuth
        },
        body: jsonEncode(<String, String>{
          "title": title,
          "description": description,
          "faceUrl":faceUrl,
          "instaUrl":instaUrl,
          "twitterUrl":twitterUrl
        }));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  static Future<List<NucleosBox>> getNucleosList() async {
    List<NucleosBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/nucleo/list'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: tokenAuth},
        );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map = data.map<NucleosBox>((item) => NucleosBox.fromJson(item)).toList();
    }
    return map;
  }

}



