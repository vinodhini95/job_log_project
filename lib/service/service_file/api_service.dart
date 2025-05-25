import 'dart:convert';
import 'package:gnb_project/service/service_file/config.dart';
import 'package:http/http.dart' as http;

class ApiService {

  //fet data from server side method
  Future<Map<String, dynamic>> fetchJobLogs(int page, int limit) async {
    final url = Uri.parse('$baseUrl$jobLogUrl');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'page': page,
        'limit': limit,
      }),
    );

    if (response.statusCode == 200) {
      //json Decode Method
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load job logs: ${response.statusCode}');
    }
  }
}
