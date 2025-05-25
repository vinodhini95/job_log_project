import 'package:intl/intl.dart';

// date format for server side API CALL
DateFormat startDateFormate = DateFormat("yyyy-MM-ddT00:00:00.000+00:00");
DateFormat endDateFormate = DateFormat("yyyy-MM-ddT23:59:59.000+00:00");

//date fromat for all
DateFormat allDynamicDateFormat = DateFormat('dd-MM-yyyy');
DateFormat allDynamicDateTimeFormat = DateFormat('dd-MM-yyyy h:mm a');

// Date format method
String formatDate(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) return '';
  try {
    final date = DateTime.parse(rawDate);
    return allDynamicDateFormat.format(date);
  } catch (e) {
    return '';
  }
}
