import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/core/json_ui_builder.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/models/widget_config.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/notifiers/app_builder_canvas_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/widgets/category_icon_widget.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderHierarchyTreeView extends ConsumerWidget {
  const AppBuilderHierarchyTreeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builder = JsonUIBuilder();
    final json = ref.watch(appBuilderCanvasNotifierProvider).theJson;

    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingS),
      child: Column(
        children: [
          const SectionHeaderWidget(
            title: 'Widget Hierarchy',
            icon: Icons.view_list,
            subtitle: 'A visual representation of the widget tree',
          ),
          Expanded(
            child: json.isEmpty
                ? const Center(child: Text('No widgets in the canvas'))
                : _WidgetHierarchyTree(rootConfig: builder.jsonToConfig(json)),
          ),
        ],
      ),
    );
  }
}

class _WidgetHierarchyTree extends ConsumerWidget {
  const _WidgetHierarchyTree({required this.rootConfig});

  final WidgetConfig rootConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = <Widget>[];
    // Add single child
    if (rootConfig.child != null) {
      children.add(_WidgetHierarchyTree(rootConfig: rootConfig.child!));
    }

    // Add multiple children
    if (rootConfig.children != null && rootConfig.children!.isNotEmpty) {
      children.addAll(
        rootConfig.children!.map((c) => _WidgetHierarchyTree(rootConfig: c)),
      );
    }

    final hasChildren = children.isNotEmpty;

    return ExpansionTile(
      enabled: hasChildren,
      showTrailingIcon: hasChildren,
      tilePadding: EdgeInsets.zero,
      initiallyExpanded: true,
      leading: CategoryIconWidget(
        type: rootConfig.type,
        iconSize: AppConstants.defaultIconSize,
      ),
      title: Row(
        children: [
          Expanded(child: _buildWidgetTitle(context, rootConfig)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            iconSize: 15,
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              ref
                  .read(appBuilderCanvasNotifierProvider.notifier)
                  .deleteWidget(rootConfig.id);
            },
            icon: const Icon(Icons.delete),
            iconSize: 15,
            color: Colors.red,
          ),
        ],
      ),
      children: children,
    );
  }

  Widget _buildWidgetTitle(BuildContext context, WidgetConfig config) {
    return Text(config.type, style: Theme.of(context).textTheme.labelMedium);
  }
}
