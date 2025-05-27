import 'dart:convert';
import 'package:gnb_project/service/service_file/config.dart';
import 'package:http/http.dart' as http;

class DynamicApiService {
  //Post api call dynamic method
  Future<dynamic> postMethod(String url, dynamic data) async {
    var headers = {
      "Content-Type": "application/json",
    };

    try {
      var response = await http.post(
        Uri.parse("$baseUrl1$url"),
        headers: headers,
        body: jsonEncode(data),
      );
      print(response);
      if (response.statusCode == 200) {
        //json Decode Method
        return jsonDecode(response.body);
      } else {
        return {"response": null};
      }
    } catch (error) {
      return {"response": null};
    }
  }

//get api call dynamic method
  get(String url) async {
    var header = {"content-type": "application/json"};
    final response = await http.get(Uri.parse("$baseUrl$url"), headers: header);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result == null) {
        return [];
      }
      return result;
    }
    return [];
  }
}
