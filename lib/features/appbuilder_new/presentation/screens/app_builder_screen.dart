import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/notifiers/app_builder_nav_rail_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/views/app_builder_canvas_view.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/views/app_builder_hierarchy_tree_view.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/views/app_builder_nav_rail_view.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/views/app_builder_property_editor_view.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/views/app_builder_widget_palette_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../views/app_builder_appbar_view.dart';

class AppBuilderScreen extends ConsumerStatefulWidget {
  const AppBuilderScreen({super.key});

  @override
  ConsumerState<AppBuilderScreen> createState() => _AppBuilderScreenState();
}

class _AppBuilderScreenState extends ConsumerState<AppBuilderScreen> {
  double leftWidth = 0.50 / 3;
  double centerWidth = 2 / 3;
  double rightWidth = 0.50 / 3;
  double minWidthFraction = 0.15;

  @override
  Widget build(BuildContext context) {
    const resizeBarWidth = 8.0;
    return Scaffold(
      appBar: AppBuilderAppbarView(
        onPressSaveDesign: () => _showSaveDialog(context),
        onPressLoadDesign: () => _showLoadDialog(context),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth - AppConstants.navRailSize;
          final adjustedWidth = totalWidth - 2 * resizeBarWidth;
          final left = leftWidth * adjustedWidth;
          final center = centerWidth * adjustedWidth;
          final right = rightWidth * adjustedWidth;

          return Row(
            children: [
              const AppBuilderNavRailView(),
              SizedBox(width: left, child: _appbuilderLeftPanel()),
              _buildResizeBar(
                onDrag: (dx) {
                  setState(() {
                    final newLeft = left + dx;
                    final newCenter = center - dx;
                    final min = minWidthFraction * adjustedWidth;
                    if (newLeft > min && newCenter > min) {
                      leftWidth = newLeft / adjustedWidth;
                      centerWidth = newCenter / adjustedWidth;
                    }
                  });
                },
              ),
              SizedBox(width: center, child: const AppBuilderCanvasView()),
              _buildResizeBar(
                onDrag: (dx) {
                  setState(() {
                    final newCenter = center + dx;
                    final newRight = right - dx;
                    final min = minWidthFraction * adjustedWidth;
                    if (newCenter > min && newRight > min) {
                      centerWidth = newCenter / adjustedWidth;
                      rightWidth = newRight / adjustedWidth;
                    }
                  });
                },
              ),
              SizedBox(
                width: right,
                child: const AppBuilderPropertyEditorView(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildResizeBar({required void Function(double dx) onDrag}) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: (details) {
          onDrag(details.delta.dx);
        },
        child: Container(
          width: 8,
          color: Colors.grey.shade300,
          child: const Center(
            child: VerticalDivider(thickness: 2, width: 8, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _appbuilderLeftPanel() {
    final navRailState = ref.watch(appBuilderNavRailNotifierProvider);
    switch (navRailState.selectedIndex) {
      case 0:
        return const AppBuilderWidgetPaletteView();
      case 1:
        return const AppBuilderHierarchyTreeView();
      default:
        return Container();
    }
  }

  void _showSaveDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Project'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Project Name',
            hintText: 'Enter a name for your project',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final projectName = controller.text.trim();
              if (projectName.isNotEmpty) {
                ref
                    .read(appBuilderStateNotifierProvider.notifier)
                    .saveProject(projectName);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showLoadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Load Project'),
        content: SizedBox(
          width: 800,
          height: 400,
          child: FutureBuilder<List<String>>(
            future: ref
                .read(appBuilderStateNotifierProvider.notifier)
                .getSavedProjects(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error loading projects'));
              }

              final projects = snapshot.data ?? [];

              if (projects.isEmpty) {
                return const Center(child: Text('No saved projects found'));
              }

              return ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final projectName = projects[index];
                  return ListTile(
                    title: Text(projectName),
                    leading: const Icon(Icons.folder),
                    onTap: () {
                      ref
                          .read(appBuilderStateNotifierProvider.notifier)
                          .loadProject(projectName);
                      Navigator.of(context).pop();
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        ref
                            .read(appBuilderStateNotifierProvider.notifier)
                            .deleteProject(projectName);
                        Navigator.of(context).pop();
                        _showLoadDialog(context); // Refresh the dialog
                      },
                    ),
                  );
                },
              );
            },
          ),
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
}
