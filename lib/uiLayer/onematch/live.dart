import 'package:flutter/material.dart';
import 'package:scorely/domain/services/detail.dart';
import 'package:scorely/dataLayer/models/scorecard.dart' as scorecard;
import 'package:scorely/uiLayer/onematch/scorecard_batting.dart';

class LiveScore extends StatefulWidget {
  final String id;
  const LiveScore({super.key, required this.id});

  @override
  State<LiveScore> createState() => _LiveScoreState();
}

class _LiveScoreState extends State<LiveScore> {
  scorecard.Data? scorecard1;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getSD();
  }

  Future<void> getSD() async {
    scorecard1 = await DetailsRes().getDaat(widget.id) as scorecard.Data?;
    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  String getTeamName(scorecard.Data scorecard1) {
    final innings = scorecard1.score;
    final teams = scorecard1.teamInfo;
    if (innings.length == 2) {
      return innings[0].inning.contains(teams[0].name) == true
          ? (teams[1].shortname)
          : (teams[0].shortname);
    } else if (innings.length == 1) {
      return innings[0].inning.contains(teams[0].name) == true
          ? (teams[0].shortname)
          : (teams[1].shortname);
    }
    return '';
  }

  String getPartnership(scorecard.Data scorecard1) {
    int runs = 0;
    int balls = 0;
    final batters = scorecard1.scorecard.last.batting;
    for (var batter in batters) {
      if (batter.dismissalText == 'not out' ||
          batter.dismissalText == 'batting') {
        runs += batter.r;
        balls += batter.b;
      }
    }
    return '$runs ($balls)';
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded || scorecard1 == null) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF0087FF)),
      );
    }

    final currentScore = scorecard1!.score.last;
    final scorecard = scorecard1!.scorecard.last;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            scorecard1!.status,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                scorecard1!.matchType == 'test'
                    ? currentScore.inning
                    : getTeamName(scorecard1!),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${currentScore.r}-${currentScore.w}',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${currentScore.o} ov',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("P'SHIP: ${getPartnership(scorecard1!)}")],
          ),
          const Divider(),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: const Color.fromARGB(255, 190, 194, 185),
            child: Row(
              children: const [
                Expanded(child: Text('  Batter')),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 40, child: Text('R')),
                      SizedBox(width: 40, child: Text('B')),
                      SizedBox(width: 30, child: Text('4s')),
                      SizedBox(width: 30, child: Text('6s')),
                      SizedBox(width: 55, child: Text('SR')),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: scorecard.batting.length,
            itemBuilder: (context, index) {
              final batter = scorecard.batting[index];
              if (batter.dismissalText == 'not out' ||
                  batter.dismissalText == 'batting') {
                return ListViewScore(
                  score: scorecard1!,
                  i: scorecard1!.score.length - 1,
                  inde: index,
                );
              }
              return const SizedBox();
            },
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: const Color.fromARGB(255, 190, 194, 185),
            child: Row(
              children: const [
                Expanded(child: Text('  Bowler')),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 40, child: Text('O')),
                      SizedBox(width: 30, child: Text('M')),
                      SizedBox(width: 25, child: Text('R')),
                      SizedBox(width: 20, child: Text('W')),
                      SizedBox(width: 60, child: Text('ER')),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: scorecard.bowling.length,
            itemBuilder: (context, index) {
              return BowlerItem(
                scorecrd: scorecard1!,
                a: scorecard1!.score.length - 1,
                b: index,
              );
            },
          ),
        ],
      ),
    );
  }
}

class ListViewScore extends StatefulWidget {
  final scorecard.Data score;
  final int i;
  final int inde;
  const ListViewScore({
    super.key,
    required this.score,
    required this.i,
    required this.inde,
  });

  @override
  State<ListViewScore> createState() => _ListViewScoreState();
}

class _ListViewScoreState extends State<ListViewScore> {
  @override
  void initState() {
    getDD(widget.score, widget.i, widget.inde);
    super.initState();
  }

  scorecard.Data? scorecard1;
  late int i;
  late int inde;
  getDD(scorecard.Data score, int ind, int j) {
    scorecard1 = score;
    i = ind;
    inde = j;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8),
                child: Text(
                  scorecard1!.scorecard[i].batting[inde].batsman.name
                      .toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      scorecard1!.scorecard[i].batting[inde].r.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      scorecard1!.scorecard[i].batting[inde].b.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: Text(
                      scorecard1!.scorecard[i].batting[inde].the4S.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: Text(
                      scorecard1!.scorecard[i].batting[inde].the6S.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      scorecard1!.scorecard[i].batting[inde].sr.toStringAsFixed(
                        2,
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 5),
          child: Text(
            scorecard1!.scorecard[i].batting[inde].dismissalText.toString(),
          ),
        ),
      ],
    );
  }
}
