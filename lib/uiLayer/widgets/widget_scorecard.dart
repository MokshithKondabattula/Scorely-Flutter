import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:scorely/dataLayer/services/detail.dart';
import 'package:scorely/dataLayer/services/single_team.dart';
import 'package:scorely/dataLayer/models/scorecard.dart' as scorecard;
import 'package:scorely/uiLayer/onematch/scorecard_batting.dart';

class MyHomePage extends StatefulWidget {
  final String id;
  const MyHomePage({super.key, required this.id});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> ontap = [];
  scorecard.Data? scorecard1;
  scorecard.Batting? notoutBat;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getSD();
  }

  Future<void> getSD() async {
    scorecard1 = (await DetailsRes().getDaat(widget.id)) as scorecard.Data?;
    notoutBat = scorecard1?.scorecard[0].batting[0];
    ontap = List.generate(scorecard1?.scorecard.length ?? 0, (_) => false);

    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded && scorecard1 != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (scorecard1?.status != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    color: Colors.grey[100],
                    child: Text(
                      scorecard1!.status,
                      style: TextStyle(
                        color: scorecard1!.matchWinner.isEmpty
                            ? Colors.blueGrey
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: scorecard1!.scorecard.length,
                    itemBuilder: (context, i) {
                      final isExpanded = ontap[i];
                      final headerColor = isExpanded
                          ? const Color(0xFF0087FF)
                          : Colors.white;
                      final textColor = isExpanded
                          ? Colors.white
                          : Colors.black;

                      return StickyHeader(
                        header: GestureDetector(
                          onTap: () {
                            setState(() => ontap[i] = !ontap[i]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: headerColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: isExpanded
                                      ? Colors.white
                                      : Colors.grey[300]!,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    scorecard1!.matchType != 'test'
                                        ? TeamName().getTeamName(scorecard1!, i)
                                        : scorecard1!.score[i].inning,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${scorecard1!.score[i].r}-${scorecard1!.score[i].w} (${scorecard1!.score[i].o})',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: textColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        content: isExpanded
                            ? Container(
                                color: Colors.grey[50],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: ScorecardBatting(
                                  j: i,
                                  scorecard1: scorecard1!,
                                ),
                              )
                            : const SizedBox(height: 8),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: SizedBox(
                width: 70,
                height: 70,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFF0087FF),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xFF0087FF),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
