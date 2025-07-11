import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder/data/models/widget_info.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/property_form.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_ui_builder/json_ui_builder.dart';

class PropertyEditorView extends ConsumerWidget {
  const PropertyEditorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: AppConstants.paletteWidthWide,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(
          right: BorderSide(color: AppTheme.dividerColor, width: 1),
        ),
      ),
      child: Column(children: [_buildProperty(ref), _buildHierarchy(ref)]),
    );
  }

  Widget _buildProperty(WidgetRef ref) {
    final appState = ref.watch(appBuilderStateNotifierProvider);

    return Expanded(
      child: Column(
        children: [
          SectionHeaderWidget(
            title: 'Properties',
            subtitle: appState.selectedWidgetId != null
                ? 'Configure properties of the selected widget'
                : 'Select a widget to edit properties',
            icon: Icons.tune,
            action: appState.selectedWidgetId != null
                ? IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      // Reset properties to default
                      final widgetType = _getWidgetTypeFromId(
                        appState.selectedWidgetId!,
                        ref,
                      );
                      final defaultProperties = _getDefaultProperties(
                        widgetType,
                      );
                      ref
                          .read(appBuilderStateNotifierProvider.notifier)
                          .updateWidgetProperties(defaultProperties);
                    },
                    tooltip: 'Reset to Default Properties',
                  )
                : null,
          ),
          Expanded(
            child: appState.selectedWidgetId != null
                ? PropertyForm(
                    properties: appState.selectedWidgetProperties,
                    widgetType: _getWidgetTypeFromId(
                      appState.selectedWidgetId!,
                      ref,
                    ),
                    onPropertiesChanged: (properties) {
                      ref
                          .read(appBuilderStateNotifierProvider.notifier)
                          .updateWidgetProperties(properties);
                    },
                  )
                : const Center(
                    child: Text(
                      'Select a widget from the hierarchy to edit its properties',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _getWidgetTypeFromId(String widgetId, WidgetRef ref) {
    // Extract widget type from the ID (format: WidgetType_hashCode)
    final parts = widgetId.split('_');
    return parts.isNotEmpty ? parts.first : 'Unknown';
  }

  Map<String, dynamic> _getDefaultProperties(String widgetType) {
    switch (widgetType) {
      case 'Text':
        return {'data': 'Hello World', 'fontSize': 16.0, 'color': 'black'};
      case 'Container':
        return {
          'width': 100.0,
          'height': 100.0,
          'color': 'blue',
          'padding': 8.0,
          'margin': 8.0,
        };
      case 'ElevatedButton':
      case 'TextButton':
      case 'OutlinedButton':
        return {'text': 'Button', 'color': 'primary'};
      case 'TextField':
      case 'TextFormField':
        return {'hintText': 'Enter text', 'labelText': 'Label'};
      case 'Icon':
        return {'icon': 'star', 'size': 24.0, 'color': 'black'};
      case 'Image':
        return {
          'src': 'https://via.placeholder.com/150',
          'width': 150.0,
          'height': 150.0,
          'fit': 'cover',
        };
      case 'Card':
        return {'elevation': 4.0, 'margin': 8.0};
      case 'ListTile':
        return {'title': 'List Item', 'subtitle': 'Subtitle'};
      case 'AppBar':
        return {'title': 'App Bar', 'backgroundColor': 'primary'};
      case 'Column':
      case 'Row':
        return {'mainAxisAlignment': 'start', 'crossAxisAlignment': 'center'};
      case 'Checkbox':
        return {'value': false};
      case 'Switch':
        return {'value': false};
      case 'Radio':
        return {'value': 'option1', 'groupValue': 'option1'};
      case 'Slider':
        return {'value': 0.5, 'min': 0.0, 'max': 1.0};
      case 'FloatingActionButton':
        return {'backgroundColor': 'primary', 'foregroundColor': 'white'};
      default:
        return {};
    }
  }

  Widget _buildHierarchy(WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
          SectionHeaderWidget(
            title: 'Widget Hierarchy',
            subtitle: 'Navigate and manage your widget tree',
            icon: Icons.account_tree,
            action: IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                ref
                    .read(appBuilderStateNotifierProvider.notifier)
                    .clearSelection();
              },
              tooltip: 'Clear Selection',
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final json = ref.watch(appBuilderStateNotifierProvider).theJson;
                final selectedWidgetId = ref
                    .watch(appBuilderStateNotifierProvider)
                    .selectedWidgetId;

                if (json.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppConstants.spacingL),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.widgets_outlined,
                            size: 48,
                            color: AppTheme.textHintColor,
                          ),
                          SizedBox(height: AppConstants.spacingM),
                          Text(
                            'No widgets on canvas.',
                            style: TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: AppConstants.spacingS),
                          Text(
                            'Drag widgets from the palette to get started.',
                            style: TextStyle(
                              color: AppTheme.textHintColor,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final builder = JsonUIBuilder();
                final rootConfig = builder.jsonToConfig(json);
                return ListView(
                  children: [
                    _HierarchyTree(
                      onWidgetDropped: (parentId, widgetInfo) {
                        ref
                            .read(appBuilderStateNotifierProvider.notifier)
                            .addWidgetToParent(
                              parentId,
                              widgetInfo.name,
                            ); // Pass the widget type string & parent id
                      },
                      config: rootConfig,
                      selectedWidgetId: selectedWidgetId,
                      onWidgetSelected: (id, config) {
                        ref
                            .read(appBuilderStateNotifierProvider.notifier)
                            .selectWidget(id, config.properties);
                      },
                      onWidgetDeleted: (id) {
                        ref
                            .read(appBuilderStateNotifierProvider.notifier)
                            .deleteWidget(id);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HierarchyTree extends StatelessWidget {
  final WidgetConfig config;
  final String? selectedWidgetId;
  final Function(String id, WidgetConfig config) onWidgetSelected;
  final Function(String id) onWidgetDeleted;
  final Function(String parentId, WidgetInfo widgetInfo)?
  onWidgetDropped; // <-- Add this

  const _HierarchyTree({
    required this.config,
    this.selectedWidgetId,
    required this.onWidgetSelected,
    required this.onWidgetDeleted,
    required this.onWidgetDropped, // <-- Add this
  });

  String get _widgetId => config.id;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    if (config.child != null) {
      children.add(
        _HierarchyTree(
          config: config.child!,
          selectedWidgetId: selectedWidgetId,
          onWidgetSelected: onWidgetSelected,
          onWidgetDeleted: onWidgetDeleted,
          onWidgetDropped: onWidgetDropped, // Pass down
        ),
      );
    }
    if (config.children != null && config.children!.isNotEmpty) {
      for (final c in config.children!) {
        children.add(
          _HierarchyTree(
            config: c,
            selectedWidgetId: selectedWidgetId,
            onWidgetSelected: onWidgetSelected,
            onWidgetDeleted: onWidgetDeleted,
            onWidgetDropped: onWidgetDropped, // Pass down
          ),
        );
      }
    }

    final isSelected = _widgetId == selectedWidgetId;
    final hasChildren = children.isNotEmpty;

    // Wrap the Card in a DragTarget to allow dropping widgets from the palette
    return DragTarget<WidgetInfo>(
      onWillAcceptWithDetails: (details) {
        if (onWidgetDropped == null) return false;
        final draggedType = details.data.name;
        // Widget types list need to be refactored later
        // List of widgets that can have children
        const multiChildTypes = [
          'Column',
          'Row',
          'Wrap',
          'ListView',
          'GridView',
          'Stack',
        ];
        // List of widgets that can have a single child
        const singleChildTypes = [
          'Container',
          'Center',
          'Align',
          'Card',
          'Padding',
          'SizedBox',
          'Expanded',
          'Flexible',
          'SingleChildScrollView',
          'PageView',
          'Positioned',
          'Scaffold',
        ];
        // List of widgets that cannot have children or child
        const leafTypes = [
          'Text',
          'Icon',
          'Checkbox',
          'Switch',
          'Radio',
          'Slider',
          'Image',
          'ListTile',
          'ElevatedButton',
          'TextButton',
          'OutlinedButton',
          'TextField',
          'TextFormField',
        ];
        // Prevent dropping into widgets that can't have children/child
        if (multiChildTypes.contains(config.type)) {
          if (config.type == draggedType) return false;
          if (leafTypes.contains(config.type)) return false;
          return true;
        } else if (singleChildTypes.contains(config.type) &&
            config.child == null) {
          if (config.type == draggedType) return false;
          if (leafTypes.contains(config.type)) return false;
          return true;
        }
        // Otherwise, do not allow drop
        return false;
      },
      onAcceptWithDetails: (widgetInfo) {
        if (onWidgetDropped != null) {
          onWidgetDropped!(_widgetId, widgetInfo.data);
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isDraggingOver = candidateData.isNotEmpty;
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingS,
            vertical: AppConstants.spacingXS,
          ),
          elevation: isSelected
              ? AppConstants.elevationMedium
              : AppConstants.elevationLow,
          color: isDraggingOver
              ? AppTheme.primaryColor.withOpacity(0.15)
              : (isSelected ? AppTheme.primaryColor.withOpacity(0.1) : null),
          child: hasChildren
              ? ExpansionTile(
                  title: _buildWidgetTitle(),
                  subtitle: _buildWidgetSubtitle(),
                  leading: _buildWidgetIcon(),
                  trailing: _buildWidgetActions(context),
                  initiallyExpanded: true,
                  backgroundColor: isSelected
                      ? AppTheme.primaryColor.withOpacity(0.05)
                      : null,
                  children: children,
                  onExpansionChanged: (expanded) {
                    if (!expanded && isSelected) {
                      // Keep selection visible
                    }
                  },
                )
              : ListTile(
                  title: _buildWidgetTitle(),
                  subtitle: _buildWidgetSubtitle(),
                  leading: _buildWidgetIcon(),
                  trailing: _buildWidgetActions(context),
                  selected: isSelected,
                  selectedTileColor: AppTheme.primaryColor.withOpacity(0.1),
                  onTap: () => onWidgetSelected(_widgetId, config),
                ),
        );
      },
    );
  }

  Widget _buildWidgetTitle() {
    return Text(
      config.type,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    );
  }

  Widget _buildWidgetSubtitle() {
    final propertiesCount = config.properties.length;
    final childrenCount =
        (config.children?.length ?? 0) + (config.child != null ? 1 : 0);

    return Text(
      '$propertiesCount properties • $childrenCount children',
      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondaryColor),
    );
  }

  Widget _buildWidgetIcon() {
    IconData icon;
    switch (config.type) {
      case 'Scaffold':
        icon = Icons.tablet;
        break;
      case 'AppBar':
        icon = Icons.web_asset;
        break;
      case 'Column':
        icon = Icons.view_column;
        break;
      case 'Row':
        icon = Icons.view_stream;
        break;
      case 'Container':
        icon = Icons.crop_square;
        break;
      case 'Text':
        icon = Icons.text_fields;
        break;
      case 'ElevatedButton':
      case 'TextButton':
      case 'OutlinedButton':
        icon = Icons.smart_button;
        break;
      case 'Image':
        icon = Icons.image;
        break;
      case 'TextField':
        icon = Icons.input;
        break;
      default:
        icon = Icons.widgets;
    }

    return Icon(
      icon,
      size: 20,
      color: _widgetId == selectedWidgetId
          ? AppTheme.primaryColor
          : AppTheme.textSecondaryColor,
    );
  }

  Widget _buildWidgetActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, size: 16),
          onPressed: () => onWidgetSelected(_widgetId, config),
          tooltip: 'Edit Properties',
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          padding: EdgeInsets.zero,
        ),
        if (config.type != 'Scaffold') // Don't allow deleting the root Scaffold
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 16,
              color: AppTheme.errorColor,
            ),
            onPressed: () => _showDeleteConfirmation(context),
            tooltip: 'Delete Widget',
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
          ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Widget'),
        content: Text(
          'Are you sure you want to delete this ${config.type} widget?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onWidgetDeleted(_widgetId);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
