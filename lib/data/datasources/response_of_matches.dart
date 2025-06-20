import 'package:scorely/data/datasources/connectivity.dart';
import 'package:scorely/data/models/currentmatch.dart';
import 'package:scorely/utils/apikey.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchRes {
  String apikey = 'ca6d9c60-b411-456d-bced-acc4b8fd3d2a';
  static String abc =
      'https://api.cricapi.com/v1/currentMatches?apikey=${Apikey.apikey}&offset=0';
  static List<Datum>? data1;

  Future<List<Datum>?> getData() async {
    bool inter = false;

    inter = await Internet.checkInternet();

    if (inter == true) {
      var resp = await http.get(Uri.parse(abc));
      var mapd = json.decode(resp.body);

      if (resp.statusCode == 200) {
        data1 = CurrentMatch.fromJson(mapd).data;
        return data1;
      } else {
        return data1;
      }
    } else {
      Fluttertoast.showToast(
        msg: 'You are currently offline ',
        textColor: Colors.blueGrey,
        backgroundColor: Colors.white,
      );
      return [];
    }
  }
}
