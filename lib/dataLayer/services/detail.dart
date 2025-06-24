import 'dart:convert';
import 'package:scorely/dataLayer/models/matchview.dart';
import 'package:scorely/utils/apikey.dart';
import 'package:http/http.dart' as http;

class DetailsRes {
  static Data? scorecard1;

  Future<Data?> getDaat(String uid) async {
    String uri =
        'https://api.cricapi.com/v1/match_scorecard?apikey=${Apikey.apikey}&id=$uid';

    var response = await http.get(Uri.parse(uri));
    var maped = await json.decode(response.body);

    if (response.statusCode == 200) {
      scorecard1 = Matchview.fromJson(maped).data;
      return scorecard1;
    } else {
      return scorecard1;
    }
  }
}
