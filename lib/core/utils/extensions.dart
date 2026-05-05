import 'package:flutter/material.dart';

import 'formatters.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
}

extension DoubleX on double {
  String toCurrency({String symbol = '\$'}) => Formatters.currency(this, symbol: symbol);
  String toPercentage({int decimals = 2}) => Formatters.percentage(this, decimals: decimals);
  String toCompact() => Formatters.compactNumber(this);
}

extension DateTimeX on DateTime {
  String toDisplayDate() => Formatters.dateOnly(this);
  String toDisplayTime() => Formatters.timeOnly(this);
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final y = DateTime.now().subtract(const Duration(days: 1));
    return year == y.year && month == y.month && day == y.day;
  }
}

extension StringX on String {
  String toTicker() => trim().toUpperCase();
}

extension ListX<T> on List<T> {
  T? get safeFirst => isEmpty ? null : first;
  T? get safeLast => isEmpty ? null : last;
}
