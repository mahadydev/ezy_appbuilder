import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/views/canvas_view.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/views/property_editor_view.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/views/widget_palettes_view.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderScreen extends ConsumerWidget {
  const AppBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('AppBuilderScreen build');
    // Listen to the app builder state
    final appBuilderState = ref.watch(appBuilderStateNotifierProvider);

    return Scaffold(
      appBar: AppBuilderAppBar(),
      body: !appBuilderState.showPreview ? _buildDesignMode() : CanvasView(),
    );
  }

  /// Design Mode - shows the builder interface
  Widget _buildDesignMode() {
    return Row(
      children: [
        WidgetPalettesView(),

        Expanded(flex: 3, child: CanvasView()),

        PropertyEditorView(),
      ],
    );
  }
}
