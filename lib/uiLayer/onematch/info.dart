import 'package:flutter/material.dart';
import 'package:scorely/dataLayer/services/squad_call.dart';
import 'package:scorely/dataLayer/services/detail.dart';

class Info extends StatefulWidget {
  final String id;

  const Info({super.key, required this.id});

  @override
  State<Info> createState() => _InfoViewState();
}

class _InfoViewState extends State<Info> {
  bool isSelected = true;

  Future<void> getSD() async {
    await Players().getPlayers(widget.id);
    await DetailsRes().getDaat(widget.id);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSD();
  }

  String getTeamShortName(String teamName) {
    final teamInfo = DetailsRes.scorecard1?.teamInfo;
    if (teamInfo == null || teamInfo.length < 2) return '';

    return teamName.contains(teamInfo[0].name)
        ? teamInfo[0].shortname
        : teamInfo[1].shortname;
  }

  @override
  Widget build(BuildContext context) {
    final players = Players.dataa;
    final teamInfo = DetailsRes.scorecard1?.teamInfo;

    if (players == null || teamInfo == null) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF0087FF)),
      );
    }

    final selectedTeam = isSelected ? 0 : 1;
    getTeamShortName(players[selectedTeam].teamName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: List.generate(2, (index) {
              final teamName = getTeamShortName(players[index].teamName);
              final selected = isSelected == (index == 0);

              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isSelected = index == 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF0087FF) : Colors.white,
                      border: Border.all(color: const Color(0xFF0087FF)),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(index == 0 ? 20 : 0),
                        right: Radius.circular(index == 1 ? 20 : 0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        teamName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: selected
                              ? Colors.white
                              : const Color(0xFF0087FF),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        Container(
          color: Colors.grey[300],
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: const Text(
            'SQUADS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        Expanded(
          child: (players[selectedTeam].players.isNotEmpty)
              ? ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: players[selectedTeam].players.length,
                  itemBuilder: (context, index) {
                    final player = players[selectedTeam].players[index];
                    return PlayerTile(player: player);
                  },
                )
              : const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
        ),
      ],
    );
  }
}

class PlayerTile extends StatelessWidget {
  final dynamic player;

  const PlayerTile({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                player.playerImg != null &&
                    player.playerImg.toString().trim().isNotEmpty
                ? NetworkImage(player.playerImg)
                : const AssetImage('assets/default.png') as ImageProvider,
          ),
          title: Text(
            player.name ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(player.role ?? ''),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        Divider(color: Colors.grey[600]),
      ],
    );
  }
}
