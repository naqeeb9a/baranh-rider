import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RiderFunctionality {
  getRiderPickUpCenters(query) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.get(
          Uri.parse("http://mtrack.mtechtesting.com/api/$query"),
          headers: {"Authorization": "Bearer ${riderData["token"]}"});
      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return jsonData["data"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  setOrderStatus(saleNo, reason, String delStatus,query) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.post(
        Uri.parse("https://riders.baranh.pk/api/$query"),
        body: {
          "sale_no": saleNo,
          "reason": "not at home",
          "delstatus": delStatus,
          "outlet_id": riderData["data"]["outlet_id"]
        },
      );
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

  getRiderInfo() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.get(Uri.parse(
          "https://riders.baranh.pk/api/getorders/${riderData["data"]["id"]}"));
      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return jsonData["data"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  riderOnline({required String query, required bool isActive}) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());
    try {
      var res = await http.post(
          Uri.parse("http://mtrack.mtechtesting.com/api/$query"),
          headers: {
            "Authorization": "Bearer ${riderData["token"]}",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"is_active": isActive}));
      var jsonData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return jsonData["message"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
