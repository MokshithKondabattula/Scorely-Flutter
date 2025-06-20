import 'dart:convert';

Scorecard scorecardFromJson(String str) => Scorecard.fromJson(json.decode(str));

String scorecardToJson(Scorecard data) => json.encode(data.toJson());

class Scorecard {
  String apikey;
  Data data;
  String status;
  Info info;

  Scorecard({
    required this.apikey,
    required this.data,
    required this.status,
    required this.info,
  });

  factory Scorecard.fromJson(Map<String, dynamic> json) => Scorecard(
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
  List<ScorecardElement> scorecard;
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
    required this.scorecard,
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
    scorecard: List<ScorecardElement>.from(
      json["scorecard"].map((x) => ScorecardElement.fromJson(x)),
    ),
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
    "scorecard": List<dynamic>.from(scorecard.map((x) => x.toJson())),
    "matchStarted": matchStarted,
    "matchEnded": matchEnded,
  };
}

class Score {
  int r;
  int w;
  double o;
  String inning;

  var rR;

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

class ScorecardElement {
  List<Batting> batting;
  List<Bowling> bowling;
  List<Catching> catching;
  Extras extras;
  Totals totals;
  String inning;

  ScorecardElement({
    required this.batting,
    required this.bowling,
    required this.catching,
    required this.extras,
    required this.totals,
    required this.inning,
  });

  factory ScorecardElement.fromJson(Map<String, dynamic> json) =>
      ScorecardElement(
        batting: List<Batting>.from(
          json["batting"].map((x) => Batting.fromJson(x)),
        ),
        bowling: List<Bowling>.from(
          json["bowling"].map((x) => Bowling.fromJson(x)),
        ),
        catching: List<Catching>.from(
          json["catching"].map((x) => Catching.fromJson(x)),
        ),
        extras: Extras.fromJson(json["extras"]),
        totals: Totals.fromJson(json["totals"]),
        inning: json["inning"],
      );

  Map<String, dynamic> toJson() => {
    "batting": List<dynamic>.from(batting.map((x) => x.toJson())),
    "bowling": List<dynamic>.from(bowling.map((x) => x.toJson())),
    "catching": List<dynamic>.from(catching.map((x) => x.toJson())),
    "extras": extras.toJson(),
    "totals": totals.toJson(),
    "inning": inning,
  };
}

class Batting {
  Batsman batsman;
  Dismissal? dismissal;
  Batsman? bowler;
  String dismissalText;
  int r;
  int b;
  int the4S;
  int the6S;
  double sr;
  int empty;
  Batsman? catcher;

  Batting({
    required this.batsman,
    this.dismissal,
    this.bowler,
    required this.dismissalText,
    required this.r,
    required this.b,
    required this.the4S,
    required this.the6S,
    required this.sr,
    required this.empty,
    this.catcher,
  });

  factory Batting.fromJson(Map<String, dynamic> json) => Batting(
    batsman: Batsman.fromJson(json["batsman"]),
    dismissal: dismissalValues.map[json["dismissal"]]!,
    bowler: json["bowler"] == null ? null : Batsman.fromJson(json["bowler"]),
    dismissalText: json["dismissal-text"],
    r: json["r"],
    b: json["b"],
    the4S: json["4s"],
    the6S: json["6s"],
    sr: json["sr"]?.toDouble(),
    empty: json[""],
    catcher: json["catcher"] == null ? null : Batsman.fromJson(json["catcher"]),
  );

  Map<String, dynamic> toJson() => {
    "batsman": batsman.toJson(),
    "dismissal": dismissalValues.reverse[dismissal],
    "bowler": bowler?.toJson(),
    "dismissal-text": dismissalText,
    "r": r,
    "b": b,
    "4s": the4S,
    "6s": the6S,
    "sr": sr,
    "": empty,
    "catcher": catcher?.toJson(),
  };
}

class Batsman {
  String id;
  String name;

  Batsman({required this.id, required this.name});

  factory Batsman.fromJson(Map<String, dynamic> json) =>
      Batsman(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

enum Dismissal { BOWLED, CATCH, LBW }

final dismissalValues = EnumValues({
  "bowled": Dismissal.BOWLED,
  "catch": Dismissal.CATCH,
  "lbw": Dismissal.LBW,
});

class Bowling {
  Batsman bowler;
  double o;
  int m;
  int r;
  int w;
  int nb;
  int wd;
  double eco;

  Bowling({
    required this.bowler,
    required this.o,
    required this.m,
    required this.r,
    required this.w,
    required this.nb,
    required this.wd,
    required this.eco,
  });

  factory Bowling.fromJson(Map<String, dynamic> json) => Bowling(
    bowler: Batsman.fromJson(json["bowler"]),
    o: json["o"]?.toDouble(),
    m: json["m"],
    r: json["r"],
    w: json["w"],
    nb: json["nb"],
    wd: json["wd"],
    eco: json["eco"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "bowler": bowler.toJson(),
    "o": o,
    "m": m,
    "r": r,
    "w": w,
    "nb": nb,
    "wd": wd,
    "eco": eco,
  };
}

class Catching {
  Batsman? catcher;
  int stumped;
  int runout;
  int catchingCatch;
  int cb;
  int lbw;
  int bowled;

  Catching({
    this.catcher,
    required this.stumped,
    required this.runout,
    required this.catchingCatch,
    required this.cb,
    required this.lbw,
    required this.bowled,
  });

  factory Catching.fromJson(Map<String, dynamic> json) => Catching(
    catcher: json["catcher"] == null ? null : Batsman.fromJson(json["catcher"]),
    stumped: json["stumped"],
    runout: json["runout"],
    catchingCatch: json["catch"],
    cb: json["cb"],
    lbw: json["lbw"],
    bowled: json["bowled"],
  );

  Map<String, dynamic> toJson() => {
    "catcher": catcher?.toJson(),
    "stumped": stumped,
    "runout": runout,
    "catch": catchingCatch,
    "cb": cb,
    "lbw": lbw,
    "bowled": bowled,
  };
}

class Extras {
  int r;
  int b;

  Extras({required this.r, required this.b});

  factory Extras.fromJson(Map<String, dynamic> json) =>
      Extras(r: json["r"], b: json["b"]);

  get wd => null;

  get nb => null;

  get lb => null;

  get p => null;

  Map<String, dynamic> toJson() => {"r": r, "b": b};
}

class Totals {
  Totals();

  factory Totals.fromJson(Map<String, dynamic> json) => Totals();

  Map<String, dynamic> toJson() => {};
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
