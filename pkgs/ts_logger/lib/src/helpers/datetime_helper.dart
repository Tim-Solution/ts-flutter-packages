abstract class DateTimeHelper {
  DateTimeHelper._();

  /// Returns the duration between the request start time and the response
  /// end time.
  ///
  /// Example: `250 ms`, `2500 ms (2.5 s)`, `46 s`, `5 m`, `5 h`, `5 d`
  static String durationBetweenRequestAndResponse({
    required DateTime requestStartTime,
    required DateTime responseEndTime,
  }) {
    final duration = responseEndTime.difference(requestStartTime);
    final milliseconds = duration.inMilliseconds;
    final seconds = duration.inSeconds;
    final minutes = duration.inMinutes;

    if (milliseconds < 1000) {
      return '$milliseconds ms';
    } else if (milliseconds < 60000) {
      return '${(milliseconds / 1000).toStringAsFixed(2)} s';
    } else if (seconds < 3600) {
      return '$seconds s';
    } else {
      if (minutes < 60) {
        return '$minutes m';
      } else {
        final hours = duration.inHours;
        if (hours < 24) {
          return '$hours h';
        } else {
          final days = duration.inDays;
          return '$days d';
        }
      }
    }
  }

  /// Readable date and time with two-digit format
  ///
  /// Example: 01.01.2024 12:00:00
  static String getReadableDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}.'
        '${dateTime.month.toString().padLeft(2, '0')}.'
        '${dateTime.year}'
        ' '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:'
        '${dateTime.second.toString().padLeft(2, '0')}';
  }
}
