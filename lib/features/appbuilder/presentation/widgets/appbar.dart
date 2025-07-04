import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppBuilderAppBar({super.key});

  @override
  ConsumerState<AppBuilderAppBar> createState() => _AppBuilderAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBuilderAppBarState extends ConsumerState<AppBuilderAppBar> {
  @override
  Widget build(BuildContext context) {
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
          onPressed: () => _showSaveDialog(context),
          tooltip: 'Save Design',
        ),

        // Load Design Button
        IconButton(
          icon: const Icon(Icons.folder_open),
          onPressed: () => _showLoadDialog(context),
          tooltip: 'Load Design',
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
          width: double.maxFinite,
          height: 300,
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

class _ToggleButton extends StatelessWidget {
  final bool showPreview;
  final ValueChanged<bool> onTogglePreview;

  const _ToggleButton({
    required this.showPreview,
    required this.onTogglePreview,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTogglePreview(!showPreview),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingM,
          vertical: AppConstants.spacingS,
        ),
        decoration: BoxDecoration(
          color: showPreview
              ? AppTheme.primaryColor.withValues(alpha: 0.8)
              : AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
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
    );
  }
}
