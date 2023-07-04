import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../presentation/newsBox.dart';

class NoticiasAuth {
  static Future<List<NewsBox>>getNews()async {
    List<NewsBox> map = [];

    final response = await http.post(
        Uri.parse(
            'https://steel-sequencer-385510.oa.r.appspot.com/rest/news/list'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      map = data.map<NewsBox>((item) => NewsBox.fromJson(item)).toList();
    }

    return map;
  }
}
