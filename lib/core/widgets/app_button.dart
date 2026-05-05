import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum AppButtonType { primary, secondary, danger, ghost }

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text, required this.onPressed, this.type = AppButtonType.primary, this.isLoading = false, this.isFullWidth = false, this.icon});
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final child = isLoading ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white)) : Row(mainAxisSize: MainAxisSize.min, children: [if (icon != null) ...[icon!, const SizedBox(width: 8)], Text(text)]);
    final style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(Size(isFullWidth ? double.infinity : 0, 48)),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    );
    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton(style: style, onPressed: isLoading ? null : onPressed, child: child);
      case AppButtonType.secondary:
        return OutlinedButton(style: style, onPressed: isLoading ? null : onPressed, child: child);
      case AppButtonType.danger:
        return ElevatedButton(style: style.copyWith(backgroundColor: WidgetStateProperty.all(AppColors.loss)), onPressed: isLoading ? null : onPressed, child: child);
      case AppButtonType.ghost:
        return TextButton(style: style, onPressed: isLoading ? null : onPressed, child: child);
    }
  }
}
