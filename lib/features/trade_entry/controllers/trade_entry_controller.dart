import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/trade_model.dart';
import '../models/draft_trade.dart';

class TradeEntryState {
  const TradeEntryState({required this.draft, required this.isValid, this.calculatedPnl, this.savedTrade});
  final DraftTrade draft;
  final bool isValid;
  final double? calculatedPnl;
  final Trade? savedTrade;

  TradeEntryState copyWith({DraftTrade? draft, bool? isValid, double? calculatedPnl, Trade? savedTrade}) => TradeEntryState(draft: draft ?? this.draft, isValid: isValid ?? this.isValid, calculatedPnl: calculatedPnl ?? this.calculatedPnl, savedTrade: savedTrade ?? this.savedTrade);
}

final tradeEntryControllerProvider = AsyncNotifierProvider<TradeEntryController, TradeEntryState>(TradeEntryController.new);

class TradeEntryController extends AsyncNotifier<TradeEntryState> {
  @override
  Future<TradeEntryState> build() async => const TradeEntryState(draft: DraftTrade(), isValid: false);
  void updateSymbol(String v) => _update(state.requireValue.draft.copyWith(symbol: v.trim().toUpperCase()));
  void updateDirection(TradeDirection v) => _update(state.requireValue.draft.copyWith(direction: v));
  void updateEntryPrice(double v) => _update(state.requireValue.draft.copyWith(entryPrice: v));
  void updateExitPrice(double v) => _update(state.requireValue.draft.copyWith(exitPrice: v));
  void updateQuantity(double v) => _update(state.requireValue.draft.copyWith(quantity: v));
  void updateFees(double v) => _update(state.requireValue.draft.copyWith(fees: v));
  void updateNotes(String v) => _update(state.requireValue.draft.copyWith(notes: v));
  void toggleTag(String tag) {
    final tags = [...state.requireValue.draft.tags];
    tags.contains(tag) ? tags.remove(tag) : (tags.length < 3 ? tags.add(tag) : null);
    _update(state.requireValue.draft.copyWith(tags: tags));
  }
  Future<void> saveTrade() async {
    final s = state.requireValue;
    final d = s.draft;
    final now = DateTime.now();
    final trade = Trade(id: now.microsecondsSinceEpoch.toString(), accountId: 'acc1', symbol: d.symbol, direction: d.direction, status: TradeStatus.closed, openTime: now, closeTime: now, totalQuantity: d.quantity, realizedPnl: s.calculatedPnl, fees: d.fees, notes: d.notes, tags: d.tags);
    state = AsyncData(s.copyWith(savedTrade: trade));
  }
  void _update(DraftTrade d) {
    final gross = (d.entryPrice != null && d.exitPrice != null && d.quantity != null) ? (d.exitPrice! - d.entryPrice!) * d.quantity! * (d.direction == TradeDirection.long ? 1 : -1) : null;
    final net = gross != null ? gross - d.fees : null;
    final valid = d.symbol.isNotEmpty && (d.entryPrice ?? 0) > 0 && (d.exitPrice ?? 0) > 0 && (d.quantity ?? 0) > 0;
    state = AsyncData(TradeEntryState(draft: d, isValid: valid, calculatedPnl: net, savedTrade: state.requireValue.savedTrade));
  }
}
