import 'dart:convert';

Squadinfo squadinfoFromJson(String str) => Squadinfo.fromJson(json.decode(str));

String squadinfoToJson(Squadinfo data) => json.encode(data.toJson());

class Squadinfo {
  String apikey;
  List<Datum> data;
  String status;
  Info info;

  Squadinfo({
    required this.apikey,
    required this.data,
    required this.status,
    required this.info,
  });

  factory Squadinfo.fromJson(Map<String, dynamic> json) => Squadinfo(
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
  String teamName;
  String shortname;
  String img;
  List<Player> players;

  Datum({
    required this.teamName,
    required this.shortname,
    required this.img,
    required this.players,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    teamName: json["teamName"],
    shortname: json["shortname"],
    img: json["img"],
    players: List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "teamName": teamName,
    "shortname": shortname,
    "img": img,
    "players": List<dynamic>.from(players.map((x) => x.toJson())),
  };
}

class Player {
  String id;
  String name;
  String role;
  BattingStyle battingStyle;
  String? bowlingStyle;
  Country country;
  String playerImg;

  Player({
    required this.id,
    required this.name,
    required this.role,
    required this.battingStyle,
    this.bowlingStyle,
    required this.country,
    required this.playerImg,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    battingStyle: battingStyleValues.map[json["battingStyle"]]!,
    bowlingStyle: json["bowlingStyle"],
    country: countryValues.map[json["country"]]!,
    playerImg: json["playerImg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "battingStyle": battingStyleValues.reverse[battingStyle],
    "bowlingStyle": bowlingStyle,
    "country": countryValues.reverse[country],
    "playerImg": playerImg,
  };
}

enum BattingStyle { LEFT_HANDED_BAT, RIGHT_HANDED_BAT }

final battingStyleValues = EnumValues({
  "Left Handed Bat": BattingStyle.LEFT_HANDED_BAT,
  "Right Handed Bat": BattingStyle.RIGHT_HANDED_BAT,
});

enum Country { ENGLAND, NETHERLANDS, NEW_ZEALAND, SOUTH_AFRICA }

final countryValues = EnumValues({
  "England": Country.ENGLAND,
  "Netherlands": Country.NETHERLANDS,
  "New Zealand": Country.NEW_ZEALAND,
  "South Africa": Country.SOUTH_AFRICA,
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
