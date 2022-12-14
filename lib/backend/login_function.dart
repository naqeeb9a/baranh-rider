import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class UserAuthentication {
  loginUser(String email, String password) async {
    try {
      var res = await http
          .post(Uri.parse("https://riders.baranh.pk/api/signin"), body: {
        "email": email,
        "password": password,
        "token": fireBaseToken,
      });
      var jsonData = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return jsonData;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
