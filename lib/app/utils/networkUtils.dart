import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkUtils {
  static final String host = productionHost;
  static final String productionHost = 'https://naya-oraan.herokuapp.com/';

  dynamic loginAccount(String phone, String passcode) async {
    var uri = host + 'users/login';
    var requestPayload = {};
    requestPayload["userPassword"] = passcode;
    requestPayload["userPhone"] = phone;
    Map headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await http.post(uri,
          headers: headers, body: json.encode(requestPayload));
      final responseJson = json.decode(utf8.decode(response.bodyBytes));
      print(responseJson);
      return responseJson;
    } catch (exception) {
      Fluttertoast.showToast(
          msg: exception.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
    }
  }

 static dynamic lifetimeSaving(id) async {
   
    try {
      var response = await
     
       http.get(host + 'installment/get-by-userid?user_id=' + id.toString());
        print(host + 'installment/get-by-userid?user_id=' + id.toString());
       return json.decode(response.body);
    } catch (error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1);
      if (error.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }
}
