// To parse this JSON data, do
//
//     final seriesInfo = seriesInfoFromJson(jsonString);

import 'dart:convert';

SeriesInfo seriesInfoFromJson(String str) =>
    SeriesInfo.fromJson(json.decode(str));

String seriesInfoToJson(SeriesInfo data) => json.encode(data.toJson());

class SeriesInfo {
  String apikey;
  List<Datum> data;
  String status;
  Info info;

  SeriesInfo({
    required this.apikey,
    required this.data,
    required this.status,
    required this.info,
  });

  factory SeriesInfo.fromJson(Map<String, dynamic> json) => SeriesInfo(
    apikey: json["apikey"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "apikey": apikey,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "info": info.toJson(),
  };
}

class Datum {
  String id;
  DateTime dateTimeGmt;
  MatchType matchType;
  String status;
  Ms ms;
  String t1;
  String t2;
  String t1S;
  String t2S;
  String series;
  String? t1Img;
  String? t2Img;

  Datum({
    required this.id,
    required this.dateTimeGmt,
    required this.matchType,
    required this.status,
    required this.ms,
    required this.t1,
    required this.t2,
    required this.t1S,
    required this.t2S,
    required this.series,
    this.t1Img,
    this.t2Img,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    dateTimeGmt: DateTime.parse(json["dateTimeGMT"]),
    matchType: matchTypeValues.map[json["matchType"]]!,
    status: json["status"],
    ms: msValues.map[json["ms"]]!,
    t1: json["t1"],
    t2: json["t2"],
    t1S: json["t1s"],
    t2S: json["t2s"],
    series: json["series"],
    t1Img: json["t1img"],
    t2Img: json["t2img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dateTimeGMT": dateTimeGmt.toIso8601String(),
    "matchType": matchTypeValues.reverse[matchType],
    "status": status,
    "ms": msValues.reverse[ms],
    "t1": t1,
    "t2": t2,
    "t1s": t1S,
    "t2s": t2S,
    "series": series,
    "t1img": t1Img,
    "t2img": t2Img,
  };
}

enum MatchType { oDI, t20, tEST }

final matchTypeValues = EnumValues({
  "odi": MatchType.oDI,
  "t20": MatchType.t20,
  "test": MatchType.tEST,
});

enum Ms { fixture, lIVE, rESULT }

final msValues = EnumValues({
  "fixture": Ms.fixture,
  "live": Ms.lIVE,
  "result": Ms.rESULT,
});

class Info {
  int hitsToday;
  int hitsUsed;
  int hitsLimit;
  int credits;
  int server;
  double queryTime;
  int s;

  Info({
    required this.hitsToday,
    required this.hitsUsed,
    required this.hitsLimit,
    required this.credits,
    required this.server,
    required this.queryTime,
    required this.s,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    hitsToday: json["hitsToday"],
    hitsUsed: json["hitsUsed"],
    hitsLimit: json["hitsLimit"],
    credits: json["credits"],
    server: json["server"],
    queryTime: json["queryTime"]?.toDouble(),
    s: json["s"],
  );

  Map<String, dynamic> toJson() => {
    "hitsToday": hitsToday,
    "hitsUsed": hitsUsed,
    "hitsLimit": hitsLimit,
    "credits": credits,
    "server": server,
    "queryTime": queryTime,
    "s": s,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
