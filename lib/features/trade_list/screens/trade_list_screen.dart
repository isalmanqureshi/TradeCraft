import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_card.dart';
import '../controllers/trade_list_controller.dart';

class TradeListScreen extends ConsumerWidget {
  const TradeListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTrades = ref.watch(tradeListControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Trade Journal'), actions: const [Icon(Icons.search)]),
      body: asyncTrades.when(
        data: (trades) => trades.isEmpty ? const Center(child: Text('No trades yet')) : RefreshIndicator(
          onRefresh: () => ref.read(tradeListControllerProvider.notifier).refresh(),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: trades.length,
            separatorBuilder: (_, __) => const Gap(12),
            itemBuilder: (_, i) {
              final t = trades[i];
              final pnl = t.realizedPnl ?? 0;
              return AppCard(child: Column(children: [Row(children: [Text(t.symbol, style: Theme.of(context).textTheme.titleLarge), const Spacer(), Text(pnl.toCurrency(), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: pnl >= 0 ? AppColors.profit : AppColors.loss))]), const Gap(8), Row(children: [Chip(label: Text(t.direction.name.toUpperCase())), const Gap(8), Text(t.openTime.toDisplayDate()), const Gap(8), Expanded(child: Text(t.tags.join(', '), overflow: TextOverflow.ellipsis))]) ]));
            },
          ),
        ),
        error: (_, __) => const Center(child: Text('Error loading trades')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
