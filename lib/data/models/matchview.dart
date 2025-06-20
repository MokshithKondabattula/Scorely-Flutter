import 'dart:convert';

Matchview matchviewFromJson(String str) => Matchview.fromJson(json.decode(str));

String matchviewToJson(Matchview data) => json.encode(data.toJson());

class Matchview {
  String apikey;
  Data data;
  String status;
  Info info;

  Matchview({
    required this.apikey,
    required this.data,
    required this.status,
    required this.info,
  });

  factory Matchview.fromJson(Map<String, dynamic> json) => Matchview(
    apikey: json["apikey"],
    data: Data.fromJson(json["data"]),
    status: json["status"],
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "apikey": apikey,
    "data": data.toJson(),
    "status": status,
    "info": info.toJson(),
  };
}

class Data {
  String id;
  String name;
  String matchType;
  String status;
  String venue;
  DateTime date;
  DateTime dateTimeGmt;
  List<String> teams;
  List<TeamInfo> teamInfo;
  List<Score> score;
  String tossWinner;
  String tossChoice;
  String matchWinner;
  String seriesId;
  bool fantasyEnabled;
  bool bbbEnabled;
  bool hasSquad;
  bool matchStarted;
  bool matchEnded;

  Data({
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
    required this.tossWinner,
    required this.tossChoice,
    required this.matchWinner,
    required this.seriesId,
    required this.fantasyEnabled,
    required this.bbbEnabled,
    required this.hasSquad,
    required this.matchStarted,
    required this.matchEnded,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    matchType: json["matchType"],
    status: json["status"],
    venue: json["venue"],
    date: DateTime.parse(json["date"]),
    dateTimeGmt: DateTime.parse(json["dateTimeGMT"]),
    teams: List<String>.from(json["teams"].map((x) => x)),
    teamInfo: List<TeamInfo>.from(
      json["teamInfo"].map((x) => TeamInfo.fromJson(x)),
    ),
    score: List<Score>.from(json["score"].map((x) => Score.fromJson(x))),
    tossWinner: json["tossWinner"],
    tossChoice: json["tossChoice"],
    matchWinner: json["matchWinner"],
    seriesId: json["series_id"],
    fantasyEnabled: json["fantasyEnabled"],
    bbbEnabled: json["bbbEnabled"],
    hasSquad: json["hasSquad"],
    matchStarted: json["matchStarted"],
    matchEnded: json["matchEnded"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "matchType": matchType,
    "status": status,
    "venue": venue,
    "date":
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "dateTimeGMT": dateTimeGmt.toIso8601String(),
    "teams": List<dynamic>.from(teams.map((x) => x)),
    "teamInfo": List<dynamic>.from(teamInfo.map((x) => x.toJson())),
    "score": List<dynamic>.from(score.map((x) => x.toJson())),
    "tossWinner": tossWinner,
    "tossChoice": tossChoice,
    "matchWinner": matchWinner,
    "series_id": seriesId,
    "fantasyEnabled": fantasyEnabled,
    "bbbEnabled": bbbEnabled,
    "hasSquad": hasSquad,
    "matchStarted": matchStarted,
    "matchEnded": matchEnded,
  };
}

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
    r: json["r"],
    w: json["w"],
    o: json["o"]?.toDouble(),
    inning: json["inning"],
  );

  Map<String, dynamic> toJson() => {"r": r, "w": w, "o": o, "inning": inning};
}

class TeamInfo {
  String name;
  String shortname;
  String img;

  TeamInfo({required this.name, required this.shortname, required this.img});

  factory TeamInfo.fromJson(Map<String, dynamic> json) => TeamInfo(
    name: json["name"],
    shortname: json["shortname"],
    img: json["img"],
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
  double queryTime;
  int s;
  int cache;

  Info({
    required this.hitsToday,
    required this.hitsUsed,
    required this.hitsLimit,
    required this.credits,
    required this.server,
    required this.queryTime,
    required this.s,
    required this.cache,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    hitsToday: json["hitsToday"],
    hitsUsed: json["hitsUsed"],
    hitsLimit: json["hitsLimit"],
    credits: json["credits"],
    server: json["server"],
    queryTime: json["queryTime"]?.toDouble(),
    s: json["s"],
    cache: json["cache"],
  );

  Map<String, dynamic> toJson() => {
    "hitsToday": hitsToday,
    "hitsUsed": hitsUsed,
    "hitsLimit": hitsLimit,
    "credits": credits,
    "server": server,
    "queryTime": queryTime,
    "s": s,
    "cache": cache,
  };
}
