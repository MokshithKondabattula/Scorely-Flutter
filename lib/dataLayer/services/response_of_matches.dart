import 'package:scorely/dataLayer/services/connectivity.dart';
import 'package:scorely/dataLayer/models/currentmatch.dart';
import 'package:scorely/utils/apikey.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchRes {
  static final String _endpoint =
      'https://api.cricapi.com/v1/currentMatches?apikey=${Apikey.apikey}&offset=0';
  static List<Datum>? data1;

  Future<List<Datum>?> getData() async {
    bool isConnected = await Internet.checkInternet();

    if (!isConnected) {
      Fluttertoast.showToast(
        msg: 'You are currently offline',
        textColor: Colors.white,
        backgroundColor: Colors.redAccent,
      );
      return [];
    }

    try {
      final response = await http.get(Uri.parse(_endpoint));

      if (response.statusCode == 200) {
        final mapd = json.decode(response.body);

        if (mapd['status'] == 'success') {
          data1 = CurrentMatch.fromJson(mapd).data;
          return data1;
        } else {
          Fluttertoast.showToast(
            msg: 'API Error: ${mapd['message'] ?? 'Invalid response'}',
            textColor: Colors.white,
            backgroundColor: Colors.red,
          );
          return [];
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Server Error: ${response.statusCode}',
          textColor: Colors.white,
          backgroundColor: Colors.red,
        );
        return [];
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong: $e',
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
      return [];
    }
  }
}
