import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppBuilderAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.build),
          const SizedBox(width: AppConstants.spacingS),
          Text(AppConstants.appName),
        ],
      ),
      actions: [
        // Save Design Button
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {},
          tooltip: 'Save Design',
        ),

        const SizedBox(width: AppConstants.spacingS),

        // Reset all changes button
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            ref.read(appBuilderStateNotifierProvider.notifier).resetJson();
          },
          tooltip: 'Reset All Changes',
        ),

        const SizedBox(width: AppConstants.spacingS),

        // Divider
        Container(height: 24, width: 1, color: AppTheme.dividerColor),

        const SizedBox(width: AppConstants.spacingS),

        // Preview Toggle
        _ToggleButton(
          showPreview: ref.watch(appBuilderStateNotifierProvider).showPreview,
          onTogglePreview: (_) {
            ref.read(appBuilderStateNotifierProvider.notifier).togglePreview();
          },
        ),

        const SizedBox(width: AppConstants.spacingM),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.showPreview,
    required this.onTogglePreview,
  });

  final bool showPreview;
  final void Function(bool) onTogglePreview;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: showPreview ? AppTheme.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        border: Border.all(
          color: showPreview ? AppTheme.primaryColor : Colors.white70,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTogglePreview(!showPreview),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingM,
              vertical: AppConstants.spacingS,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  showPreview ? Icons.edit : Icons.preview,
                  size: 18,
                  color: showPreview ? Colors.white : Colors.white,
                ),
                const SizedBox(width: AppConstants.spacingXS),
                Text(
                  showPreview ? 'Edit' : 'Preview',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: showPreview ? Colors.white : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
