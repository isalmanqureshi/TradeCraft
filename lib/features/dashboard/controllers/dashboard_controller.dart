import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/trade_model.dart';

class DashboardState {
  const DashboardState({required this.todayPnl, required this.totalTrades, required this.winRate, required this.recentTrades});
  final double todayPnl;
  final int totalTrades;
  final double winRate;
  final List<Trade> recentTrades;
}

final dashboardControllerProvider = AsyncNotifierProvider<DashboardController, DashboardState>(DashboardController.new);

class DashboardController extends AsyncNotifier<DashboardState> {
  @override
  Future<DashboardState> build() async {
    final now = DateTime.now();
    final trades = [
      Trade(id: '1', accountId: 'acc1', symbol: 'AAPL', direction: TradeDirection.long, status: TradeStatus.closed, openTime: now.subtract(const Duration(hours: 6)), closeTime: now.subtract(const Duration(hours: 5)), realizedPnl: 325.5),
      Trade(id: '2', accountId: 'acc1', symbol: 'TSLA', direction: TradeDirection.short, status: TradeStatus.closed, openTime: now.subtract(const Duration(hours: 4)), closeTime: now.subtract(const Duration(hours: 3)), realizedPnl: -120.2),
      Trade(id: '3', accountId: 'acc1', symbol: 'NVDA', direction: TradeDirection.long, status: TradeStatus.closed, openTime: now.subtract(const Duration(hours: 2)), closeTime: now.subtract(const Duration(hours: 1)), realizedPnl: 210.0),
    ];
    final wins = trades.where((t) => (t.realizedPnl ?? 0) > 0).length;
    return DashboardState(todayPnl: trades.fold(0, (a, b) => a + (b.realizedPnl ?? 0)), totalTrades: trades.length, winRate: wins / trades.length * 100, recentTrades: trades);
  }
}
