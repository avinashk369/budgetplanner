import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter();
  String getVerboseDateTimeRepresentation(String dateString) {
    DateFormat format = DateFormat("yyyy-MM-dd");
    DateTime dateTime = format.parse(dateString);
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();
    if (!localDateTime.difference(justNow).isNegative) {
      return "Just Now";
    }
    String roughTimeString = DateFormat('jm').format(dateTime);
    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return "Today";
    }
    DateTime yesterday = now.subtract(Duration(days: 1));
    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return "Yesterday";
    }
    if (now.difference(localDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE', 'EN').format(localDateTime);
      return '$weekday';
    }
    return '$dateString';
  }
}
