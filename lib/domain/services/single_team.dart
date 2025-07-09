import 'package:scorely/dataLayer/models/scorecard.dart' as scorecard;

class TeamName {
  String getTeamName(scorecard.Data? scorecard, int i) {
    if (scorecard == null) {
      return '';
    }

    final scores = scorecard.score;
    final teams = scorecard.teamInfo;

    if (i < scores.length && teams.length == 2) {
      final inningName = scores[i].inning;

      if (inningName.contains(teams[0].name)) {
        return teams[0].shortname;
      } else if (inningName.contains(teams[1].name)) {
        return teams[1].shortname;
      }
    }

    return '';
  }

  String getTestInn(String inningName) {
    return inningName
        .replaceAll('Inning 1', '1st Inn')
        .replaceAll('Inning 2', '2nd Inn');
  }
}
