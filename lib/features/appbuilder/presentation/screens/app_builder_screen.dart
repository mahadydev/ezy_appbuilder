import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/views/canvas_view.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/views/property_editor_view.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/views/widget_palettes_view.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderScreen extends ConsumerWidget {
  const AppBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the app builder state
    final appBuilderState = ref.watch(appBuilderStateNotifierProvider);

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.delete): const DeleteWidgetIntent(),
        LogicalKeySet(LogicalKeyboardKey.escape): const ClearSelectionIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ):
            const UndoIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyY):
            const RedoIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.shift,
          LogicalKeyboardKey.keyZ,
        ): const RedoIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyR):
            const ResetCanvasIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          DeleteWidgetIntent: CallbackAction<DeleteWidgetIntent>(
            onInvoke: (intent) {
              final selectedId = appBuilderState.selectedWidgetId;
              if (selectedId != null) {
                ref
                    .read(appBuilderStateNotifierProvider.notifier)
                    .deleteWidget(selectedId);
              }
              return null;
            },
          ),
          ClearSelectionIntent: CallbackAction<ClearSelectionIntent>(
            onInvoke: (intent) {
              ref
                  .read(appBuilderStateNotifierProvider.notifier)
                  .clearSelection();
              return null;
            },
          ),
          UndoIntent: CallbackAction<UndoIntent>(
            onInvoke: (intent) {
              ref.read(appBuilderStateNotifierProvider.notifier).undo();
              return null;
            },
          ),
          RedoIntent: CallbackAction<RedoIntent>(
            onInvoke: (intent) {
              ref.read(appBuilderStateNotifierProvider.notifier).redo();
              return null;
            },
          ),
          ResetCanvasIntent: CallbackAction<ResetCanvasIntent>(
            onInvoke: (intent) {
              ref.read(appBuilderStateNotifierProvider.notifier).resetJson();
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: AppBuilderAppBar(),
            body: appBuilderState.showPreview
                ? CanvasView()
                : _buildDesignMode(),
          ),
        ),
      ),
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

// Custom intents for keyboard shortcuts
class DeleteWidgetIntent extends Intent {
  const DeleteWidgetIntent();
}

class ClearSelectionIntent extends Intent {
  const ClearSelectionIntent();
}

class UndoIntent extends Intent {
  const UndoIntent();
}

class RedoIntent extends Intent {
  const RedoIntent();
}

class ResetCanvasIntent extends Intent {
  const ResetCanvasIntent();
}
