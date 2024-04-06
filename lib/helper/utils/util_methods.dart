import 'package:intl/intl.dart';

class Utils {
  static parseDate(String dateString, String format) {
    DateFormat formatter = DateFormat(format);
    return formatter.parse(dateString);
  }

  static dateTimeToString(DateTime dateTime, String format) {
    DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }

  static String getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
