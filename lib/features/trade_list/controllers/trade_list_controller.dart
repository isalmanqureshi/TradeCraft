import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/trade_model.dart';

final tradeListControllerProvider = AsyncNotifierProvider<TradeListController, List<Trade>>(TradeListController.new);

class TradeListController extends AsyncNotifier<List<Trade>> {
  @override
  Future<List<Trade>> build() async => _mock();

  Future<void> refresh() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    state = AsyncData(_mock());
  }

  void deleteTrade(String id) {
    state = AsyncData((state.value ?? []).where((t) => t.id != id).toList());
  }

  List<Trade> filterByTag(String tag) {
    return (state.value ?? []).where((t) => t.tags.contains(tag)).toList();
  }

  List<Trade> _mock() {
    final now = DateTime.now();
    return [
      Trade(id: '1', accountId: 'acc1', symbol: 'AAPL', direction: TradeDirection.long, status: TradeStatus.closed, openTime: now, closeTime: now, realizedPnl: 325.5, tags: const ['Breakout']),
      Trade(id: '2', accountId: 'acc1', symbol: 'TSLA', direction: TradeDirection.short, status: TradeStatus.closed, openTime: now, closeTime: now, realizedPnl: -120.2, tags: const ['Reversal']),
      Trade(id: '3', accountId: 'acc1', symbol: 'NVDA', direction: TradeDirection.long, status: TradeStatus.closed, openTime: now, closeTime: now, realizedPnl: 210.0, tags: const ['Trend']),
    ];
  }
}
