import 'dart:convert';

PlayerInfo playerInfoFromJson(String str) =>
    PlayerInfo.fromJson(json.decode(str));

String playerInfoToJson(PlayerInfo data) => json.encode(data.toJson());

class PlayerInfo {
  String apikey;
  Data data;
  String status;
  Info info;

  PlayerInfo({
    required this.apikey,
    required this.data,
    required this.status,
    required this.info,
  });

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => PlayerInfo(
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
  DateTime dateOfBirth;
  String role;
  String battingStyle;
  String bowlingStyle;
  String placeOfBirth;
  String country;
  String playerImg;
  List<Stat> stats;

  Data({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.role,
    required this.battingStyle,
    required this.bowlingStyle,
    required this.placeOfBirth,
    required this.country,
    required this.playerImg,
    required this.stats,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    role: json["role"],
    battingStyle: json["battingStyle"],
    bowlingStyle: json["bowlingStyle"],
    placeOfBirth: json["placeOfBirth"],
    country: json["country"],
    playerImg: json["playerImg"],
    stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "dateOfBirth": dateOfBirth.toIso8601String(),
    "role": role,
    "battingStyle": battingStyle,
    "bowlingStyle": bowlingStyle,
    "placeOfBirth": placeOfBirth,
    "country": country,
    "playerImg": playerImg,
    "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
  };
}

class Stat {
  Fn fn;
  Matchtype matchtype;
  String stat;
  Value value;

  Stat({
    required this.fn,
    required this.matchtype,
    required this.stat,
    required this.value,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    fn: fnValues.map[json["fn"]]!,
    matchtype: matchtypeValues.map[json["matchtype"]]!,
    stat: json["stat"],
    value: valueValues.map[json["value"]]!,
  );

  Map<String, dynamic> toJson() => {
    "fn": fnValues.reverse[fn],
    "matchtype": matchtypeValues.reverse[matchtype],
    "stat": stat,
    "value": valueValues.reverse[value],
  };
}

enum Fn { bATTING, bOWLING }

final fnValues = EnumValues({"batting": Fn.bATTING, "bowling": Fn.bOWLING});

enum Matchtype { iPL, oDI, t20, tEST }

final matchtypeValues = EnumValues({
  "ipl": Matchtype.iPL,
  "odi": Matchtype.oDI,
  "t20": Matchtype.t20,
  "test": Matchtype.tEST,
});

enum Value { eMPTY, tHE_0, tHE_00 }

final valueValues = EnumValues({
  " -/- ": Value.eMPTY,
  " 0 ": Value.tHE_0,
  " 0.0 ": Value.tHE_00,
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
