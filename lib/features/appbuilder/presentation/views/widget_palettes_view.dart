import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:json_ui_builder/json_ui_builder.dart';

class WidgetPalettesView extends StatelessWidget {
  const WidgetPalettesView({super.key});

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
      child: Column(children: [_buildHeader(), _buildWidgetList()]),
    );
  }

  Widget _buildHeader() {
    return SectionHeaderWidget(
      title: 'Widget Palette',
      subtitle: 'Widget list to drag and drop onto the canvas',
      icon: Icons.widgets,
    );
  }

  Widget _buildWidgetList() {
    final List<String> widgets =
        JsonUIBuilder().getPackageInfo()['widget_types'] is List<String>
        ? JsonUIBuilder().getPackageInfo()['widget_types']
        : [];

    widgets.sort((a, b) => a.compareTo(b));

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.spacingM),
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          final String widgetType = widgets[index];
          return _buildWidgetTile(widgetType);
        },
      ),
    );
  }

  Widget _buildWidgetTile(String widgetType) {
    return DraggableItemWidget(
      feedback: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingS),
        child: _buildDragFeedback(widgetType),
      ),
      data: widgetType,
      child: Card(
        child: ListTile(
          title: Text(widgetType),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.drag_indicator, color: AppTheme.textHintColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragFeedback(String widgetType) {
    return Material(
      elevation: AppConstants.elevationMedium,
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingS),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          border: Border.all(color: AppTheme.primaryColor, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.widgets,
              color: AppTheme.primaryColor,
              size: AppConstants.defaultIconSize,
            ),
            const SizedBox(width: AppConstants.spacingS),
            Text(
              widgetType,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
