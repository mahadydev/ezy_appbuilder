import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class ProperyEditorView extends StatelessWidget {
  const ProperyEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.paletteWidthWide,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(
          right: BorderSide(color: AppTheme.dividerColor, width: 1),
        ),
      ),
      child: Column(children: [_buildHeader()]),
    );
  }

  Widget _buildHeader() {
    return SectionHeaderWidget(
      title: 'Properties',
      subtitle: 'Configure properties of the selected widget',
      icon: Icons.tune,
    );
  }
}
