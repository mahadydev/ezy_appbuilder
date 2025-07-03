import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/notifiers/appbuilder_state_provider.dart';
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
      child: Column(children: [_buildHeader(), _buildHierarchy()]),
    );
  }

  Widget _buildHeader() {
    return Expanded(
      child: Column(
        children: [
          SectionHeaderWidget(
            title: 'Properties',
            subtitle: 'Configure properties of the selected widget',
            icon: Icons.tune,
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget _buildHierarchy() {
    return Expanded(
      child: Consumer(
        builder: (context, ref, _) {
          final json = ref.watch(appBuilderStateNotifierProvider).theJson;
          if (json.isEmpty) {
            return Center(child: Text('No widgets on canvas.'));
          }
          final builder = JsonUIBuilder();
          final rootConfig = builder.jsonToConfig(json);
          return ListView(children: [_HierarchyTree(config: rootConfig)]);
        },
      ),
    );
  }
}

class _HierarchyTree extends StatelessWidget {
  final WidgetConfig config;
  const _HierarchyTree({required this.config});

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    if (config.child != null) {
      children.add(_HierarchyTree(config: config.child!));
    }
    if (config.children != null && config.children!.isNotEmpty) {
      for (final c in config.children!) {
        children.add(_HierarchyTree(config: c));
      }
    }
    return ExpansionTile(
      title: Text('${config.type})'),
      initiallyExpanded: true,
      children: children,
    );
  }
}
