import 'package:freezed_annotation/freezed_annotation.dart';

import 'trade_leg_model.dart';

part 'trade_model.freezed.dart';
part 'trade_model.g.dart';

enum TradeDirection { long, short }
enum TradeStatus { open, closed, partial }

@freezed
class Trade with _$Trade {
  const factory Trade({
    required String id,
    required String accountId,
    required String symbol,
    required TradeDirection direction,
    required TradeStatus status,
    required DateTime openTime,
    DateTime? closeTime,
    double? totalQuantity,
    double? realizedPnl,
    double? fees,
    String? notes,
    int? executionRating,
    int? preConfidence,
    int? postFomo,
    @Default([]) List<String> tags,
    @Default([]) List<String> screenshotPaths,
    @Default([]) List<TradeLeg> legs,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Trade;

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
}

extension TradeComputedX on Trade {
  double get totalEntryQuantity => legs.where((l) => l.type == TradeLegType.entry || l.type == TradeLegType.partialEntry).fold(0, (a, b) => a + b.quantity);
  double get totalExitQuantity => legs.where((l) => l.type == TradeLegType.exit || l.type == TradeLegType.partialExit).fold(0, (a, b) => a + b.quantity);
  double get averageEntryPrice {
    final entries = legs.where((l) => l.type == TradeLegType.entry || l.type == TradeLegType.partialEntry).toList();
    final qty = entries.fold<double>(0, (a, b) => a + b.quantity);
    if (qty == 0) return 0;
    return entries.fold<double>(0, (a, b) => a + (b.price * b.quantity)) / qty;
  }
  double get averageExitPrice {
    final exits = legs.where((l) => l.type == TradeLegType.exit || l.type == TradeLegType.partialExit).toList();
    final qty = exits.fold<double>(0, (a, b) => a + b.quantity);
    if (qty == 0) return 0;
    return exits.fold<double>(0, (a, b) => a + (b.price * b.quantity)) / qty;
  }
  bool get isWin => realizedPnl != null && realizedPnl! > 0;
  bool get isLoss => realizedPnl != null && realizedPnl! < 0;
  Duration? get duration => closeTime != null ? closeTime!.difference(openTime) : null;
}
