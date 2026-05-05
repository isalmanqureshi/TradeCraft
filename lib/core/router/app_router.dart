import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/trade_entry/screens/quick_entry_screen.dart';
import '../../features/trade_list/screens/trade_list_screen.dart';
import '../theme/app_colors.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) => _ShellScaffold(child: child),
        routes: [
          GoRoute(path: '/', name: 'dashboard', pageBuilder: (c, s) => _fadeSlide(const DashboardScreen())),
          GoRoute(path: '/entry', name: 'entry', pageBuilder: (c, s) => _fadeSlide(const QuickEntryScreen())),
          GoRoute(path: '/trades', name: 'trades', pageBuilder: (c, s) => _fadeSlide(const TradeListScreen())),
        ],
      ),
    ],
  );
}

CustomTransitionPage<void> _fadeSlide(Widget child) => CustomTransitionPage<void>(child: child, transitionsBuilder: (context, animation, sec, child) => FadeTransition(opacity: animation, child: SlideTransition(position: Tween(begin: const Offset(0.03, 0), end: Offset.zero).animate(animation), child: child)));

class _ShellScaffold extends StatelessWidget {
  const _ShellScaffold({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    int idx = loc == '/entry' ? 1 : (loc == '/trades' ? 2 : 0);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (i) => context.go(i == 0 ? '/' : i == 1 ? '/entry' : '/trades'),
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Entry'),
          BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted), label: 'Trades'),
        ],
      ),
    );
  }
}
