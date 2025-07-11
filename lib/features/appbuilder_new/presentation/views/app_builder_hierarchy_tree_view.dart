import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/core/json_ui_builder.dart';
import 'package:ezy_appbuilder/core/packages/json_ui_builder/src/models/widget_config.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/notifiers/app_builder_canvas_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/widgets/category_icon_widget.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget hierarchy tree view that displays the widget tree structure
/// with selection capabilities and widget management options.
class AppBuilderHierarchyTreeView extends ConsumerWidget {
  const AppBuilderHierarchyTreeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(appBuilderCanvasNotifierProvider);
    final builder = JsonUIBuilder();

    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingS),
      child: Column(
        children: [
          const SectionHeaderWidget(
            title: 'Widget Hierarchy',
            icon: Icons.view_list,
            subtitle: 'A visual representation of the widget tree',
          ),
          const SizedBox(height: AppConstants.spacingM),
          Expanded(
            child: canvasState.theJson.isEmpty
                ? _buildEmptyState()
                : _WidgetHierarchyTree(
                    rootConfig: builder.jsonToConfig(canvasState.theJson),
                    selectedWidgetId: canvasState.selectedWidgetId,
                  ),
          ),
        ],
      ),
    );
  }

  /// Builds the empty state when no widgets are in the canvas
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.widgets_outlined, size: 64, color: Colors.grey),
          SizedBox(height: AppConstants.spacingM),
          Text(
            'No widgets in the canvas',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: AppConstants.spacingS),
          Text(
            'Drag widgets from the palette to get started',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// A hierarchical tree widget that shows the structure of widgets
/// with selection highlighting and management capabilities.
class _WidgetHierarchyTree extends ConsumerWidget {
  const _WidgetHierarchyTree({
    required this.rootConfig,
    this.selectedWidgetId,
    this.level = 0,
  });

  final WidgetConfig rootConfig;
  final String? selectedWidgetId;
  final int level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = <Widget>[];
    final isSelected = selectedWidgetId == rootConfig.id;

    // Add single child
    if (rootConfig.child != null) {
      children.add(
        _WidgetHierarchyTree(
          rootConfig: rootConfig.child!,
          selectedWidgetId: selectedWidgetId,
          level: level + 1,
        ),
      );
    }

    // Add multiple children
    if (rootConfig.children != null && rootConfig.children!.isNotEmpty) {
      children.addAll(
        rootConfig.children!.map(
          (child) => _WidgetHierarchyTree(
            rootConfig: child,
            selectedWidgetId: selectedWidgetId,
            level: level + 1,
          ),
        ),
      );
    }

    final hasChildren = children.isNotEmpty;

    return Container(
      margin: EdgeInsets.only(left: level * 16.0),
      child: Card(
        elevation: isSelected ? 4 : 1,
        color: isSelected
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : null,
        child: InkWell(
          onTap: () {
            ref
                .read(appBuilderCanvasNotifierProvider.notifier)
                .selectWidget(rootConfig.id);
          },
          child: ExpansionTile(
            enabled: hasChildren,
            showTrailingIcon: hasChildren,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingS,
            ),
            initiallyExpanded: level < 2, // Auto-expand first two levels
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected)
                  Icon(
                    Icons.radio_button_checked,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  )
                else
                  Icon(
                    Icons.radio_button_unchecked,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                const SizedBox(width: AppConstants.spacingXS),
                CategoryIconWidget(type: rootConfig.type, iconSize: 20),
              ],
            ),
            title: _buildWidgetTitle(context, rootConfig, isSelected),
            subtitle: _buildWidgetSubtitle(context, rootConfig),
            trailing: hasChildren
                ? null
                : _buildActionButtons(context, ref, rootConfig),
            children: hasChildren
                ? [...children, _buildAddChildButton(context, ref, rootConfig)]
                : [],
          ),
        ),
      ),
    );
  }

  /// Builds the widget title with type and selection indicator
  Widget _buildWidgetTitle(
    BuildContext context,
    WidgetConfig config,
    bool isSelected,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            config.type,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Theme.of(context).primaryColor : null,
            ),
          ),
        ),
        if (isSelected)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingXS,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'SELECTED',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the widget subtitle with additional information
  Widget _buildWidgetSubtitle(BuildContext context, WidgetConfig config) {
    final List<String> info = [];

    // Add ID
    info.add('ID: ${config.id}');

    // Add child count info
    if (config.childCount > 0) {
      info.add(
        '${config.childCount} child${config.childCount == 1 ? '' : 'ren'}',
      );
    }

    // Add acceptance info
    if (config.canAcceptChildren) {
      info.add(
        config.canAcceptSingleChild ? 'Single child' : 'Multiple children',
      );
    }

    return Text(
      info.join(' • '),
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
    );
  }

  /// Builds action buttons for widget management
  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    WidgetConfig config,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (config.canAcceptChildren)
          IconButton(
            onPressed: () => _showAddChildDialog(context, ref, config),
            icon: const Icon(Icons.add_circle_outline),
            iconSize: 20,
            color: Colors.green[600],
            tooltip: 'Add child widget',
          ),
        IconButton(
          onPressed: () {
            ref
                .read(appBuilderCanvasNotifierProvider.notifier)
                .deleteWidget(config.id);
          },
          icon: const Icon(Icons.delete_outline),
          iconSize: 20,
          color: Colors.red[600],
          tooltip: 'Delete widget',
        ),
      ],
    );
  }

  /// Builds the add child button that appears at the bottom of expanded widgets
  Widget _buildAddChildButton(
    BuildContext context,
    WidgetRef ref,
    WidgetConfig config,
  ) {
    if (!config.canAcceptChildren) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(AppConstants.spacingS),
      child: OutlinedButton.icon(
        onPressed: () => _showAddChildDialog(context, ref, config),
        icon: const Icon(Icons.add),
        label: Text(
          'Add ${config.canAcceptSingleChild ? 'Child' : 'Children'}',
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green[600],
          side: BorderSide(color: Colors.green[600]!),
        ),
      ),
    );
  }

  /// Shows a dialog to add a child widget to the selected parent
  void _showAddChildDialog(
    BuildContext context,
    WidgetRef ref,
    WidgetConfig parent,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Child to ${parent.type}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select a widget type to add as a child:'),
            const SizedBox(height: AppConstants.spacingM),
            // This is a simplified version - in a real implementation,
            // you'd want to show a grid of available widgets
            Wrap(
              spacing: AppConstants.spacingS,
              runSpacing: AppConstants.spacingS,
              children: _getCompatibleWidgets(parent.type)
                  .map(
                    (widgetType) => ActionChip(
                      label: Text(widgetType),
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref
                            .read(appBuilderCanvasNotifierProvider.notifier)
                            .addWidgetToParent(widgetType, parent.id);
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Gets a list of widget types that are compatible with the given parent type
  List<String> _getCompatibleWidgets(String parentType) {
    // Return commonly used widgets that can be children
    const commonWidgets = [
      'Text',
      'Container',
      'Column',
      'Row',
      'ElevatedButton',
      'Card',
      'Padding',
      'SizedBox',
    ];

    return commonWidgets;
  }
}
