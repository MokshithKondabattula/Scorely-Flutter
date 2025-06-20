class DateU {
  static const Map<String, String> _monthMap = {
    '01': 'Jan',
    '02': 'Feb',
    '03': 'Mar',
    '04': 'Apr',
    '05': 'May',
    '06': 'Jun',
    '07': 'Jul',
    '08': 'Aug',
    '09': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec',
  };

  static String getDate(String dateString) {
    try {
      if (dateString.length >= 10) {
        final month = dateString.substring(5, 7);
        final day = dateString.substring(8, 10);
        final monthName = _monthMap[month];
        if (monthName != null) {
          return '$monthName $day';
        }
      }
      return dateString;
    } catch (e) {
      return dateString;
    }
  }

  static String getEndDate(String matchType, String dateString) {
    final formatted = getDate(dateString);
    if (matchType.toLowerCase() == 'test' && formatted.length >= 6) {
      try {
        final originalDay = int.tryParse(formatted.substring(4, 6)) ?? 0;
        final incrementedDay = originalDay + 4;
        final year = dateString.substring(0, 4);
        return '$formatted - $year$incrementedDay';
      } catch (_) {
        return formatted;
      }
    }
    return formatted;
  }

  static String getTime(String? dateTimeGMT) {
    return dateTimeGMT != null && dateTimeGMT.length >= 19
        ? dateTimeGMT.substring(11, 19)
        : '';
  }
}
