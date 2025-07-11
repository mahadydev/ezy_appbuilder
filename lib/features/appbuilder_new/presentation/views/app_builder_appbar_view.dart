import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBuilderAppbarView extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBuilderAppbarView({
    super.key,
    required this.onPressSaveDesign,
    required this.onPressLoadDesign,
  });

  final void Function()? onPressSaveDesign;
  final void Function()? onPressLoadDesign;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.build_circle_outlined, size: 56),
          const SizedBox(width: AppConstants.spacingS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConstants.appName,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              Text(
                AppConstants.appDescription,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(width: AppConstants.spacingM),
          Chip(
            label: Text(
              AppConstants.version,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
          ),
        ],
      ),
      actions: [
        // Save Design Button
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: onPressSaveDesign,
          tooltip: 'Save Design',
        ),

        // Load Design Button
        IconButton(
          icon: const Icon(Icons.folder_open),
          onPressed: onPressLoadDesign,
          tooltip: 'Load Design',
        ),

        const SizedBox(width: AppConstants.spacingS),

        // Divider
        Container(height: 24, width: 1, color: AppTheme.dividerColor),

        const SizedBox(width: AppConstants.spacingS),

        const SizedBox(width: AppConstants.spacingM),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
