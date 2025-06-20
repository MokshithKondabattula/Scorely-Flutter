import 'package:flutter/material.dart';
import 'package:scorely/data/models/currentmatch.dart';

class MatchScore {
  Widget getScore(List<Score>? scores, String teamShortName) {
    if (scores == null || scores.isEmpty) {
      return const Text('');
    }

    final TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: Color(0xFF1C1C1C),
    );

    String formatScore(Score score) => '${score.r}-${score.w} (${score.o})';

    if (scores.length == 4) {
      return scores[0].inning.contains(teamShortName)
          ? Text(
              '${formatScore(scores[0])} & ${formatScore(scores[2])}',
              style: textStyle,
            )
          : Text(
              '${formatScore(scores[1])} & ${formatScore(scores[3])}',
              style: textStyle,
            );
    }

    if (scores.length == 3) {
      return scores[0].inning.contains(teamShortName)
          ? Text(
              '${formatScore(scores[0])} & ${formatScore(scores[2])}',
              style: textStyle,
            )
          : Text(formatScore(scores[1]), style: textStyle);
    }

    if (scores.length == 2) {
      return scores[0].inning.contains(teamShortName)
          ? Text(formatScore(scores[0]), style: textStyle)
          : Text(formatScore(scores[1]), style: textStyle);
    }

    return const Text('');
  }
}
