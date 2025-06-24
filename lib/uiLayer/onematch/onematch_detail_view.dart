// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:scorely/dataLayer/services/detail.dart';
import 'package:scorely/dataLayer/services/squad_call.dart';
import 'package:scorely/uiLayer/onematch/info.dart';
import 'package:scorely/uiLayer/onematch/live.dart';
import 'package:scorely/uiLayer/widgets/widget_scorecard.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLoading = true;

  Future<void> getMatchDetails() async {
    await DetailsRes().getDaat(widget.id);
    await Players().getPlayers(widget.id);
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getMatchDetails();
  }

  @override
  Widget build(BuildContext context) {
    final teamInfo = DetailsRes.scorecard1?.teamInfo;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0087FF),
          title: teamInfo != null && teamInfo.length >= 2
              ? Text(
                  '${teamInfo[0].shortname} vs ${teamInfo[1].shortname}',
                  style: const TextStyle(fontSize: 18),
                )
              : const Text('Match Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                DetailsRes.scorecard1 = null;
                Players.dataa = null;
              });
              Navigator.pop(context);
            },
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFFB3E5FC),
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Squads'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Live'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Scorecard'),
              ),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF0087FF)),
              )
            : TabBarView(
                children: [
                  Info(id: widget.id),
                  LiveScore(id: widget.id),
                  MyHomePage(id: widget.id),
                ],
              ),
      ),
    );
  }
}
