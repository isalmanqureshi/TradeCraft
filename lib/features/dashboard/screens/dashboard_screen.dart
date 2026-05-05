import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_card.dart';
import '../controllers/dashboard_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = _greeting();
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      floatingActionButton: FloatingActionButton(onPressed: () => context.push('/entry'), child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(greeting, style: Theme.of(context).textTheme.headlineSmall),
          const Gap(16),
          Row(children: const [Expanded(child: AppCard(child: Text("Today's P&L\n--"))), Gap(12), Expanded(child: AppCard(child: Text('Win Rate\n--%')))]),
          const Gap(24),
          Text('Recent Activity', style: Theme.of(context).textTheme.titleMedium),
          const Gap(12),
          Expanded(child: ListView.builder(itemCount: 3, itemBuilder: (_, i) => const Padding(padding: EdgeInsets.only(bottom: 12), child: AppCard(child: SizedBox(height: 56))))),
        ]),
      ),
    );
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning, Trader';
    if (h < 17) return 'Good afternoon, Trader';
    return 'Good evening, Trader';
  }
}
