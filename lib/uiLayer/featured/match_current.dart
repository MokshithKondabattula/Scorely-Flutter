import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scorely/core/loading_indicator.dart';
import 'package:scorely/dataLayer/models/currentmatch.dart';
import 'package:scorely/dataLayer/services/connectivity.dart';
import 'package:scorely/dataLayer/services/score.dart';
import 'package:scorely/dataLayer/services/response_of_matches.dart';
import 'package:scorely/uiLayer/onematch/onematch_detail_view.dart';
import 'package:scorely/utils/date_time_utils.dart' as custom_utils;

const kPrimaryColor = Color(0xFF0087FF);
const kErrorRed = Color.fromARGB(255, 239, 25, 21);

class Match extends StatefulWidget {
  const Match({super.key});

  @override
  State<Match> createState() => _MatchState();
}

class _MatchState extends State<Match> {
  bool isLoad = true;
  final GlobalKey<RefreshIndicatorState> _ref =
      GlobalKey<RefreshIndicatorState>();

  Future<void> getD() async {
    await MatchRes().getData();
    if (mounted) {
      setState(() {
        isLoad = false;
      });
    }
  }

  Future<void> refresh() async {
    if (await Internet.checkInternet()) {
      await MatchRes().getData();
      if (mounted) {
        setState(() {});
      }
    } else {
      Fluttertoast.showToast(
        msg: 'You are currently offline',
        textColor: Colors.blueGrey,
        backgroundColor: Colors.white,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getD();
    Timer.periodic(const Duration(minutes: 2), (_) => refresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F0FF),
      body: RefreshIndicator(
        key: _ref,
        onRefresh: refresh,
        child: Container(
          child: MatchRes.data1 != null
              ? ListView.builder(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  itemCount: MatchRes.data1!.length,
                  itemBuilder: (context, index) {
                    final match = MatchRes.data1![index];
                    return ListItem(match: match);
                  },
                )
              : const Center(
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: LoadingIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Datum match;

  const ListItem({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final teamInfo = match.teamInfo;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              match.name.split(',').first,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              match.name.split(',').length == 2 ? match.name.split(',')[1] : '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Date: ${custom_utils.DateU.getEndDate(match.matchType.toString(), match.date.toString())}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            const SizedBox(height: 5),
            Text(
              'Time: ${custom_utils.DateU.getTime(match.dateTimeGmt.toString())} GMT',
            ),

            const SizedBox(height: 5),
            Text(
              'Venue: ${match.venue}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(id: match.id.toString()),
                  ),
                );
              },
              child: Card(
                color: const Color(0xFFE9F3FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 8,
                  ),
                  child: Column(
                    children: [
                      ...List.generate(
                        teamInfo.length > 2 ? 2 : teamInfo.length,
                        (i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: kPrimaryColor,
                                foregroundImage: NetworkImage(teamInfo[i].img),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  teamInfo[i].shortname?.isNotEmpty == true
                                      ? teamInfo[i].shortname!
                                      : teamInfo[i].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1C1C1C),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: MatchScore().getScore(
                                  match.score,
                                  teamInfo[i].name,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            match.status,
                            style: const TextStyle(color: Color(0xFFD32F2F)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
