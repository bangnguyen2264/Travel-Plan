import 'package:intl/intl.dart';

String formatInt(int value) {
  NumberFormat formatter = NumberFormat('#,###');
  return formatter.format(value);
}

String formatDate(DateTime date) {
  return DateFormat('HH:mm').format(date);
}

String getFirstName(String name) {
  List<String> nameParts = name.split(' ');
  return nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
}

String getLastName(String name) {
  List<String> nameParts = name.split(' ');
  return nameParts.isNotEmpty ? nameParts[0] : '';
}

