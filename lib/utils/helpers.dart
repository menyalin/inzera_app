import 'package:intl/intl.dart';

String formattedPrice(double price) {
  var _oCcy = new NumberFormat("#,##0.00", "en_US");
  return _oCcy.format(price);
}

String currentDateString() {
  DateTime now = DateTime.now();
  return DateFormat('y-MM-dd').format(now);
}
