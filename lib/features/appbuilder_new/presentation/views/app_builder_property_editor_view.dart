import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderPropertyEditorView extends ConsumerWidget {
  const AppBuilderPropertyEditorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appBuilderStateNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingS),
      child: Column(
        children: [
          SectionHeaderWidget(
            title: 'Property Editor',
            icon: Icons.tune,
            subtitle: appState.selectedWidgetId != null
                ? 'Configure properties of the selected widget'
                : 'Select a widget to edit properties',
          ),
          const Expanded(child: Center(child: Text('No widget selected'))),
        ],
      ),
    );
  }
}
