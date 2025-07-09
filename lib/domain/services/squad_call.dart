import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scorely/dataLayer/models/squad_info.dart';
import 'package:scorely/utils/apikey.dart';

class Players {
  static List<Datum>? dataa;

  Future<List<Datum>?> getPlayers(String id) async {
    final String url =
        'https://api.cricapi.com/v1/match_squad?apikey=${Apikey.apikey}&id=$id';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<Datum> fetchedData = Squadinfo.fromJson(jsonData).data;

        if (fetchedData.isNotEmpty) {
          dataa = fetchedData;
          return dataa;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
