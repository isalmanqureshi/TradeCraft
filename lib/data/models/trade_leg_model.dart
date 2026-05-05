import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_leg_model.freezed.dart';
part 'trade_leg_model.g.dart';

enum TradeLegType { entry, exit, partialEntry, partialExit }

@freezed
class TradeLeg with _$TradeLeg {
  const factory TradeLeg({
    required String id,
    required String tradeId,
    required TradeLegType type,
    required double price,
    required double quantity,
    required DateTime timestamp,
    double? fees,
  }) = _TradeLeg;

  factory TradeLeg.fromJson(Map<String, dynamic> json) => _$TradeLegFromJson(json);
}
