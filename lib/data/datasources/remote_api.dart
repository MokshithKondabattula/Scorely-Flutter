import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:scorely/data/models/response.dart';
import 'package:scorely/utils/apikey.dart';

class RemoteService {
  static const String _url =
      'https://api.cricapi.com/v1/series?apikey=${Apikey.apikey}&offset=0';

  Future<List<Data>> getData() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final userResponse = UserResponse.fromJson(decoded);
        return userResponse.data ?? [];
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<String?> getStatus() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return UserResponse.fromJson(decoded).status;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting status: $e');
      return null;
    }
  }
}
