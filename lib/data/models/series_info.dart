import 'dart:convert';

SeriesInfo seriesInfoFromJson(String str) =>
    SeriesInfo.fromJson(json.decode(str));

String seriesInfoToJson(SeriesInfo data) => json.encode(data.toJson());

class SeriesInfo {
  String apikey;
  Data data;
  String status;
  SeriesInfoInfo info;

  SeriesInfo({
    required this.apikey,
    required this.data,
    required this.status,
    required this.info,
  });

  factory SeriesInfo.fromJson(Map<String, dynamic> json) => SeriesInfo(
    apikey: json["apikey"],
    data: Data.fromJson(json["data"]),
    status: json["status"],
    info: SeriesInfoInfo.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "apikey": apikey,
    "data": data.toJson(),
    "status": status,
    "info": info.toJson(),
  };
}

class Data {
  DataInfo info;
  List<MatchList> matchList;

  Data({required this.info, required this.matchList});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    info: DataInfo.fromJson(json["info"]),
    matchList: List<MatchList>.from(
      json["matchList"].map((x) => MatchList.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "info": info.toJson(),
    "matchList": List<dynamic>.from(matchList.map((x) => x.toJson())),
  };
}

class DataInfo {
  String id;
  String name;
  DateTime startdate;
  String enddate;
  int odi;
  int t20;
  int test;
  int squads;
  int matches;

  DataInfo({
    required this.id,
    required this.name,
    required this.startdate,
    required this.enddate,
    required this.odi,
    required this.t20,
    required this.test,
    required this.squads,
    required this.matches,
  });

  factory DataInfo.fromJson(Map<String, dynamic> json) => DataInfo(
    id: json["id"],
    name: json["name"],
    startdate: DateTime.parse(json["startdate"]),
    enddate: json["enddate"],
    odi: json["odi"],
    t20: json["t20"],
    test: json["test"],
    squads: json["squads"],
    matches: json["matches"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "startdate":
        "${startdate.year.toString().padLeft(4, '0')}-${startdate.month.toString().padLeft(2, '0')}-${startdate.day.toString().padLeft(2, '0')}",
    "enddate": enddate,
    "odi": odi,
    "t20": t20,
    "test": test,
    "squads": squads,
    "matches": matches,
  };
}

class MatchList {
  String id;
  String name;
  String matchType;
  String status;
  String venue;
  DateTime date;
  DateTime dateTimeGmt;
  List<Team> teams;
  List<TeamInfo> teamInfo;
  bool fantasyEnabled;
  bool bbbEnabled;
  bool hasSquad;
  bool matchStarted;
  bool matchEnded;

  MatchList({
    required this.id,
    required this.name,
    required this.matchType,
    required this.status,
    required this.venue,
    required this.date,
    required this.dateTimeGmt,
    required this.teams,
    required this.teamInfo,
    required this.fantasyEnabled,
    required this.bbbEnabled,
    required this.hasSquad,
    required this.matchStarted,
    required this.matchEnded,
  });

  factory MatchList.fromJson(Map<String, dynamic> json) => MatchList(
    id: json["id"],
    name: json["name"],
    matchType: json["matchType"],
    status: json["status"],
    venue: json["venue"],
    date: DateTime.parse(json["date"]),
    dateTimeGmt: DateTime.parse(json["dateTimeGMT"]),
    teams: List<Team>.from(json["teams"].map((x) => teamValues.map[x]!)),
    teamInfo: List<TeamInfo>.from(
      json["teamInfo"].map((x) => TeamInfo.fromJson(x)),
    ),
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
    "teams": List<dynamic>.from(teams.map((x) => teamValues.reverse[x])),
    "teamInfo": List<dynamic>.from(teamInfo.map((x) => x.toJson())),
    "fantasyEnabled": fantasyEnabled,
    "bbbEnabled": bbbEnabled,
    "hasSquad": hasSquad,
    "matchStarted": matchStarted,
    "matchEnded": matchEnded,
  };
}

class TeamInfo {
  Team name;
  Shortname shortname;
  String img;

  TeamInfo({required this.name, required this.shortname, required this.img});

  factory TeamInfo.fromJson(Map<String, dynamic> json) => TeamInfo(
    name: teamValues.map[json["name"]]!,
    shortname: shortnameValues.map[json["shortname"]]!,
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "name": teamValues.reverse[name],
    "shortname": shortnameValues.reverse[shortname],
    "img": img,
  };
}

enum Team { BANGLADESH, SRI_LANKA }

final teamValues = EnumValues({
  "Bangladesh": Team.BANGLADESH,
  "Sri Lanka": Team.SRI_LANKA,
});

enum Shortname { BAN, SL }

final shortnameValues = EnumValues({"BAN": Shortname.BAN, "SL": Shortname.SL});

class SeriesInfoInfo {
  int hitsToday;
  int hitsUsed;
  int hitsLimit;
  int credits;
  int server;
  double queryTime;
  int s;
  int cache;

  SeriesInfoInfo({
    required this.hitsToday,
    required this.hitsUsed,
    required this.hitsLimit,
    required this.credits,
    required this.server,
    required this.queryTime,
    required this.s,
    required this.cache,
  });

  factory SeriesInfoInfo.fromJson(Map<String, dynamic> json) => SeriesInfoInfo(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
