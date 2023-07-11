import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../boxes/bookingBox.dart';
import '../../boxes/userActivateBox.dart';

class ActivateUsersAuth {
  static Future<List<UserRoleBox>> getUsersToActivate() async {
    List<UserRoleBox> map = [];
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/list/unactivated'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      map =
          data.map<UserRoleBox>((item) => UserRoleBox.fromJson(item)).toList();
    }
    return map;
  }

  static Future<void> activateUser(String targetName) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/userActivation/activate'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
      body: jsonEncode(<String, String>{
        'targetName': targetName,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("User activated");
    } else {
      print("User not activated");
    }
  }

  static Future<void> negateActivationUser(String targetName) async {
    String tokenAuth = await getTokenAuth();

    final response = await http.post(
      Uri.parse('$appUrl/userActivation/deactivate'),
      headers: <String, String>{HttpHeaders.authorizationHeader: tokenAuth},
      body: jsonEncode(<String, String>{
        'targetName': targetName,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("User activated");
    } else {
      print("User not activated");
    }
  }
}
