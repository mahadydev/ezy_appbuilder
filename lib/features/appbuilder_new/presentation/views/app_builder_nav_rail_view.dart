import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/notifiers/app_builder_nav_rail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderNavRailView extends ConsumerWidget {
  const AppBuilderNavRailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(appBuilderNavRailNotifierProvider);
    return SizedBox(
      width: AppConstants.navRailSize,
      child: NavigationRail(
        labelType: NavigationRailLabelType.none,
        backgroundColor: AppTheme.primaryColor.withAlpha(50),
        onDestinationSelected: (index) {
          ref
              .read(appBuilderNavRailNotifierProvider.notifier)
              .selectIndex(index);
        },
        selectedIndex: provider.selectedIndex,
        selectedIconTheme: const IconThemeData(color: AppTheme.surfaceColor),
        unselectedIconTheme: const IconThemeData(
          color: AppTheme.textSecondaryColor,
        ),
        useIndicator: true,
        indicatorColor: AppTheme.primaryColor,
        destinations: [
          const NavigationRailDestination(
            icon: Icon(Icons.widgets),
            label: Text('Widget Palette'),
          ),
          const NavigationRailDestination(
            icon: Icon(Icons.view_list),
            label: Text('Hierarchy'),
          ),
          const NavigationRailDestination(
            icon: Icon(Icons.settings),
            label: Text('Add Widget'),
          ),
        ],
      ),
    );
  }
}
