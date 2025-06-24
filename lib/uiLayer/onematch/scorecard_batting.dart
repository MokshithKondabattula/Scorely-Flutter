import 'package:flutter/material.dart';
import 'package:scorely/dataLayer/models/scorecard.dart' as scorecard;
import 'package:scorely/uiLayer/onematch/live.dart';

class ScorecardBatting extends StatefulWidget {
  final scorecard.Data scorecard1;
  final int j;

  const ScorecardBatting({
    super.key,
    required this.scorecard1,
    required this.j,
  });

  @override
  State<ScorecardBatting> createState() => _ScorecardBatting();
}

class _ScorecardBatting extends State<ScorecardBatting> {
  late scorecard.Data scorecard1;
  late int i;

  @override
  void initState() {
    super.initState();
    scorecard1 = widget.scorecard1;
    i = widget.j;
  }

  @override
  Widget build(BuildContext context) {
    final battingList = scorecard1.scorecard[i].batting;
    final bowlingList = scorecard1.scorecard[i].bowling;
    final extras = scorecard1.scorecard[i].extras;
    final totals = scorecard1.scorecard[i].totals;

    return SingleChildScrollView(
      child: Column(
        children: [
          _sectionTitle('Batter', ['R', 'B', '4s', '6s', 'SR']),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: battingList.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListViewScore(score: scorecard1, i: i, inde: index),
                  Divider(color: Colors.grey[300]),
                ],
              );
            },
          ),
          ...[
            _sectionSpacer(),
            _extrasRow(extras),
            Divider(color: Colors.grey[300]),
          ],
          ...[
            _totalsRow(totals as scorecard.Score),
            Divider(color: Colors.grey[300]),
          ],
          _sectionTitle('Bowler', ['O', 'M', 'R', 'W', 'ER']),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bowlingList.length,
            itemBuilder: (context, index2) {
              return BowlerItem(a: i, scorecrd: scorecard1, b: index2);
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, List<String> headers) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      color: const Color(0xFFE0F2F1),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: headers
                  .map((e) => SizedBox(width: 40, child: Text(e)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionSpacer() => const Padding(padding: EdgeInsets.all(5));

  Widget _extrasRow(scorecard.Extras extras) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
          child: Text(
            'Extras',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Wd: ${extras.wd ?? 0}', style: _extraStyle()),
              Text('Nb: ${extras.nb ?? 0}', style: _extraStyle()),
              Text('B: ${extras.b}', style: _extraStyle()),
              Text('Lb: ${extras.lb ?? 0}', style: _extraStyle()),
              Text('P: ${extras.p ?? 0}', style: _extraStyle()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _totalsRow(scorecard.Score totals) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(
            child: Text(
              'Totals',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Row(
            children: [
              Text(
                totals.r.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                ' (${totals.o} Overs,',
                style: const TextStyle(fontSize: 17),
              ),
              Text(' RR: ${totals.rR} )', style: const TextStyle(fontSize: 17)),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _extraStyle() => TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[600],
    fontSize: 16,
  );
}

class BowlerItem extends StatelessWidget {
  final scorecard.Data scorecrd;
  final int a;
  final int b;

  const BowlerItem({
    super.key,
    required this.scorecrd,
    required this.a,
    required this.b,
  });

  @override
  Widget build(BuildContext context) {
    final bowler = scorecrd.scorecard[a].bowling[b];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              bowler.bowler.name,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statBox(bowler.o),
              _statBox(bowler.m),
              _statBox(bowler.r),
              _statBox(bowler.w),
              SizedBox(
                width: 50,
                child: Text(
                  bowler.eco.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statBox(dynamic value) {
    return SizedBox(
      width: 30,
      child: Text(
        value?.toString() ?? '-',
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
