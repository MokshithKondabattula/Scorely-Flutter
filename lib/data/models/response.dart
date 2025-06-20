class UserResponse {
  String? apikey;
  List<Data>? data;
  String? status;
  Info? info;

  UserResponse({this.apikey, this.data, this.status, this.info});

  UserResponse.fromJson(Map<String, dynamic> json) {
    apikey = json['apikey'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json['status'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apikey'] = apikey;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    if (info != null) {
      data['info'] = info!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  int? odi;
  int? t20;
  int? test;
  int? squads;
  int? matches;

  Data({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.odi,
    this.t20,
    this.test,
    this.squads,
    this.matches,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    odi = json['odi'];
    t20 = json['t20'];
    test = json['test'];
    squads = json['squads'];
    matches = json['matches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['odi'] = odi;
    data['t20'] = t20;
    data['test'] = test;
    data['squads'] = squads;
    data['matches'] = matches;
    return data;
  }
}

class Info {
  int? hitsToday;
  int? hitsUsed;
  int? hitsLimit;
  int? credits;
  int? server;
  int? offsetRows;
  int? cache;
  int? totalRows;
  double? queryTime;
  int? s;

  Info({
    this.hitsToday,
    this.hitsUsed,
    this.hitsLimit,
    this.credits,
    this.server,
    this.offsetRows,
    this.cache,
    this.totalRows,
    this.queryTime,
    this.s,
  });

  Info.fromJson(Map<String, dynamic> json) {
    hitsToday = json['hitsToday'];
    hitsUsed = json['hitsUsed'];
    hitsLimit = json['hitsLimit'];
    credits = json['credits'];
    server = json['server'];
    offsetRows = json['offsetRows'];
    cache = json['cache'];
    totalRows = json['totalRows'];
    queryTime = json['queryTime'];
    s = json['s'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hitsToday'] = hitsToday;
    data['hitsUsed'] = hitsUsed;
    data['hitsLimit'] = hitsLimit;
    data['credits'] = credits;
    data['server'] = server;
    data['offsetRows'] = offsetRows;
    data['cache'] = cache;
    data['totalRows'] = totalRows;
    data['queryTime'] = queryTime;
    data['s'] = s;
    return data;
  }
}
