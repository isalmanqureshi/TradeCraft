import 'package:intl/intl.dart';

class Formatters {
  static String currency(double value, {String symbol = '\$'}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return formatter.format(value);
  }

  static String percentage(double value, {int decimals = 2}) {
    return '${value.toStringAsFixed(decimals)}%';
  }

  static String compactNumber(double value) {
    return NumberFormat.compact().format(value);
  }

  static String dateTime(DateTime dt) => DateFormat('MMM d, yyyy h:mm a').format(dt);
  static String dateOnly(DateTime dt) => DateFormat('MMM d, yyyy').format(dt);
  static String timeOnly(DateTime dt) => DateFormat('h:mm a').format(dt);
}
