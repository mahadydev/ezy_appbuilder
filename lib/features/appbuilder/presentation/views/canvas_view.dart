import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/canvas_toolbar.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/canvas_viewport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanvasView extends ConsumerWidget {
  const CanvasView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppTheme.canvasColor),
      child: Column(
        children: [_buildCanvasToolbar(), _buildCanvasContent(ref)],
      ),
    );
  }

  // Canvas Toolbar
  Widget _buildCanvasToolbar() {
    return CanvasToolbar();
  }

  // Canvas Content Area
  Widget _buildCanvasContent(WidgetRef ref) {
    return CanvasViewport(
      screenMap: ref.watch(appBuilderStateNotifierProvider).theJson,
      onDragAccept: (details) {
        ref
            .read(appBuilderStateNotifierProvider.notifier)
            .addScaffoldWithAppBar();
        debugPrint('Drag accepted with details: ${details.data}');
        debugPrint(
          'Drag accepted with details: ${ref.watch(appBuilderStateNotifierProvider).theJson}',
        );
      },
    );
  }
}
