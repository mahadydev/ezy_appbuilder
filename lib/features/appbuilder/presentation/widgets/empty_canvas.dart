import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// A widget that shows a placeholder when no content is available
class EmptyCanvas extends StatelessWidget {
  const EmptyCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border.all(
          color: AppTheme.borderColor,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 64,
            color: AppTheme.textHintColor,
          ),
          const SizedBox(height: AppConstants.spacingL),
          Text(
            'Drop widgets here to start building',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.textHintColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            'Drag widgets from the palette or click to add',
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondaryColor),
          ),
        ],
      ),
    );
  }
}
