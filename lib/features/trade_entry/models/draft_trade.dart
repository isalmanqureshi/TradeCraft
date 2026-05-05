import '../../../data/models/trade_model.dart';

class DraftTrade {
  const DraftTrade({
    this.symbol = '',
    this.direction = TradeDirection.long,
    this.entryPrice,
    this.exitPrice,
    this.quantity,
    this.fees = 0,
    this.tags = const [],
    this.notes = '',
  });

  final String symbol;
  final TradeDirection direction;
  final double? entryPrice;
  final double? exitPrice;
  final double? quantity;
  final double fees;
  final List<String> tags;
  final String notes;

  DraftTrade copyWith({String? symbol, TradeDirection? direction, double? entryPrice, double? exitPrice, double? quantity, double? fees, List<String>? tags, String? notes}) => DraftTrade(
        symbol: symbol ?? this.symbol,
        direction: direction ?? this.direction,
        entryPrice: entryPrice ?? this.entryPrice,
        exitPrice: exitPrice ?? this.exitPrice,
        quantity: quantity ?? this.quantity,
        fees: fees ?? this.fees,
        tags: tags ?? this.tags,
        notes: notes ?? this.notes,
      );
}
