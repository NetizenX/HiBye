import 'package:intl/intl.dart';

String currencyString(double number) {
  return NumberFormat.currency(symbol: '\$').format(number);
}
