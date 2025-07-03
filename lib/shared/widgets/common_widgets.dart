// import 'package:ezy_appbuilder/core/theme/app_theme.dart';
// import 'package:flutter/material.dart';

// import '../../../core/constants/app_constants.dart';

// /// Common loading widget
// class LoadingWidget extends StatelessWidget {
//   final String? message;
//   final double? size;

//   const LoadingWidget({super.key, this.message, this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: size ?? 48,
//             height: size ?? 48,
//             child: const CircularProgressIndicator(),
//           ),
//           if (message != null) ...[
//             const SizedBox(height: AppConstants.spacingM),
//             Text(
//               message!,
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: AppTheme.textSecondaryColor,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// /// Common error widget
// class ErrorWidget extends StatelessWidget {
//   final String message;
//   final String? title;
//   final IconData? icon;
//   final VoidCallback? onRetry;
//   final String? retryButtonText;

//   const ErrorWidget({
//     super.key,
//     required this.message,
//     this.title,
//     this.icon,
//     this.onRetry,
//     this.retryButtonText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(AppConstants.spacingL),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon ?? Icons.error_outline,
//               size: 64,
//               color: AppTheme.errorColor,
//             ),
//             const SizedBox(height: AppConstants.spacingM),
//             if (title != null) ...[
//               Text(
//                 title!,
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                   color: AppTheme.errorColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: AppConstants.spacingS),
//             ],
//             Text(
//               message,
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: AppTheme.textSecondaryColor,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             if (onRetry != null) ...[
//               const SizedBox(height: AppConstants.spacingL),
//               ElevatedButton(
//                 onPressed: onRetry,
//                 child: Text(retryButtonText ?? 'Retry'),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Common empty state widget
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 64,
              color: AppTheme.textHintColor,
            ),
            const SizedBox(height: AppConstants.spacingM),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingS),
            ],
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppConstants.spacingL),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Common section header widget
class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? action;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: AppConstants.defaultIconSize * 2,
            ),
            const SizedBox(width: AppConstants.spacingS),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppConstants.spacingXS),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

/// Custom search bar widget
class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;

  const SearchBarWidget({
    super.key,
    this.hintText = 'Search...',
    this.onChanged,
    this.onClear,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingM,
        vertical: AppConstants.spacingS,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller?.text.isNotEmpty == true || onClear != null
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller?.clear();
                    onClear?.call();
                    onChanged?.call('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
            vertical: AppConstants.spacingS,
          ),
        ),
      ),
    );
  }
}

/// Custom chip widget for categories/tags
class CustomChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;

  const CustomChipWidget({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.selectedColor,
    this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingM,
          vertical: AppConstants.spacingS,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (selectedColor ?? AppTheme.primaryColor)
              : (unselectedColor ?? Colors.transparent),
          border: Border.all(
            color: isSelected
                ? (selectedColor ?? AppTheme.primaryColor)
                : AppTheme.borderColor,
          ),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

/// Custom draggable item widget
class DraggableItemWidget extends StatelessWidget {
  final Widget child;
  final Widget feedback;
  final dynamic data;
  final VoidCallback? onTap;

  const DraggableItemWidget({
    super.key,
    required this.child,
    required this.feedback,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Draggable(
        data: data,
        feedback: Material(
          elevation: AppConstants.elevationMedium,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          child: feedback,
        ),
        childWhenDragging: Opacity(opacity: 0.5, child: child),
        child: child,
      ),
    );
  }
}
