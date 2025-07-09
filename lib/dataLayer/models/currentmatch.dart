import 'dart:convert';

CurrentMatch currentMatchFromJson(String str) =>
    CurrentMatch.fromJson(json.decode(str));

String currentMatchToJson(CurrentMatch data) => json.encode(data.toJson());

class CurrentMatch {
  String apikey;
  List<Datum> data;
  String status;
  Info info;

  CurrentMatch({
    required this.apikey,
    required this.data,
    required this.status,
    required this.info,
  });

  factory CurrentMatch.fromJson(Map<String, dynamic> json) => CurrentMatch(
    apikey: json["apikey"] ?? "",
    data: json["data"] != null
        ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
        : [],
    status: json["status"] ?? "",
    info: json["info"] != null ? Info.fromJson(json["info"]) : Info.empty(),
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
  String name;
  MatchType matchType;
  String status;
  String venue;
  DateTime date;
  DateTime dateTimeGmt;
  List<String> teams;
  List<TeamInfo> teamInfo;
  List<Score> score;
  String seriesId;
  bool fantasyEnabled;
  bool bbbEnabled;
  bool hasSquad;
  bool matchStarted;
  bool matchEnded;

  Datum({
    required this.id,
    required this.name,
    required this.matchType,
    required this.status,
    required this.venue,
    required this.date,
    required this.dateTimeGmt,
    required this.teams,
    required this.teamInfo,
    required this.score,
    required this.seriesId,
    required this.fantasyEnabled,
    required this.bbbEnabled,
    required this.hasSquad,
    required this.matchStarted,
    required this.matchEnded,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    matchType:
        matchTypeValues.map[json["matchType"]?.toLowerCase()] ?? MatchType.t20,
    status: json["status"] ?? "",
    venue: json["venue"] ?? "",
    date: DateTime.tryParse(json["date"] ?? "") ?? DateTime.now(),
    dateTimeGmt: DateTime.tryParse(json["dateTimeGMT"] ?? "") ?? DateTime.now(),
    teams: json["teams"] != null
        ? List<String>.from(json["teams"].map((x) => x))
        : [],
    teamInfo: json["teamInfo"] != null
        ? List<TeamInfo>.from(json["teamInfo"].map((x) => TeamInfo.fromJson(x)))
        : [],
    score: json["score"] != null
        ? List<Score>.from(json["score"].map((x) => Score.fromJson(x)))
        : [],
    seriesId: json["series_id"] ?? "",
    fantasyEnabled: json["fantasyEnabled"] ?? false,
    bbbEnabled: json["bbbEnabled"] ?? false,
    hasSquad: json["hasSquad"] ?? false,
    matchStarted: json["matchStarted"] ?? false,
    matchEnded: json["matchEnded"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "matchType": matchTypeValues.reverse[matchType] ?? "t20",
    "status": status,
    "venue": venue,
    "date": date.toIso8601String(),
    "dateTimeGMT": dateTimeGmt.toIso8601String(),
    "teams": List<dynamic>.from(teams.map((x) => x)),
    "teamInfo": List<dynamic>.from(teamInfo.map((x) => x.toJson())),
    "score": List<dynamic>.from(score.map((x) => x.toJson())),
    "series_id": seriesId,
    "fantasyEnabled": fantasyEnabled,
    "bbbEnabled": bbbEnabled,
    "hasSquad": hasSquad,
    "matchStarted": matchStarted,
    "matchEnded": matchEnded,
  };
}

enum MatchType { t20, test }

final matchTypeValues = EnumValues({
  "t20": MatchType.t20,
  "test": MatchType.test,
});

class Score {
  int r;
  int w;
  double o;
  String inning;

  Score({
    required this.r,
    required this.w,
    required this.o,
    required this.inning,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
    r: json["r"] ?? 0,
    w: json["w"] ?? 0,
    o: (json["o"] ?? 0).toDouble(),
    inning: json["inning"] ?? "",
  );

  Map<String, dynamic> toJson() => {"r": r, "w": w, "o": o, "inning": inning};
}

class TeamInfo {
  String name;
  String? shortname;
  String img;

  TeamInfo({required this.name, this.shortname, required this.img});

  factory TeamInfo.fromJson(Map<String, dynamic> json) => TeamInfo(
    name: json["name"] ?? "",
    shortname: json["shortname"],
    img: json["img"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "shortname": shortname,
    "img": img,
  };
}

class Info {
  int hitsToday;
  int hitsUsed;
  int hitsLimit;
  int credits;
  int server;
  int offsetRows;
  int totalRows;
  double queryTime;
  int s;
  int cache;

  Info({
    required this.hitsToday,
    required this.hitsUsed,
    required this.hitsLimit,
    required this.credits,
    required this.server,
    required this.offsetRows,
    required this.totalRows,
    required this.queryTime,
    required this.s,
    required this.cache,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    hitsToday: json["hitsToday"] ?? 0,
    hitsUsed: json["hitsUsed"] ?? 0,
    hitsLimit: json["hitsLimit"] ?? 0,
    credits: json["credits"] ?? 0,
    server: json["server"] ?? 0,
    offsetRows: json["offsetRows"] ?? 0,
    totalRows: json["totalRows"] ?? 0,
    queryTime: (json["queryTime"] ?? 0).toDouble(),
    s: json["s"] ?? 0,
    cache: json["cache"] ?? 0,
  );

  factory Info.empty() => Info(
    hitsToday: 0,
    hitsUsed: 0,
    hitsLimit: 0,
    credits: 0,
    server: 0,
    offsetRows: 0,
    totalRows: 0,
    queryTime: 0,
    s: 0,
    cache: 0,
  );

  Map<String, dynamic> toJson() => {
    "hitsToday": hitsToday,
    "hitsUsed": hitsUsed,
    "hitsLimit": hitsLimit,
    "credits": credits,
    "server": server,
    "offsetRows": offsetRows,
    "totalRows": totalRows,
    "queryTime": queryTime,
    "s": s,
    "cache": cache,
  };
}

class EnumValues<T> {
  final Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse => reverseMap = map.map((k, v) => MapEntry(v, k));
}
