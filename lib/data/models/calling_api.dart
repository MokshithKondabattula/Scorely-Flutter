import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCall {
  static apicall(String url, Map<String, dynamic> request) async {
    var response = await http.get(Uri.parse(url));
    return await jsonDecode(response.body);
  }
}
