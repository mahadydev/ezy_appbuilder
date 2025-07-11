import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/providers/notifiers/app_builder_widget_palette_provider.dart';
import 'package:ezy_appbuilder/features/appbuilder_new/presentation/widgets/category_icon_widget.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBuilderWidgetPaletteView extends ConsumerWidget {
  const AppBuilderWidgetPaletteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(appBuilderWidgetPaletteNotifierProvider);

    return LayoutBuilder(
      builder: (_, constraints) {
        const minItemWidth = 100.0;
        final crossAxisCount = (constraints.maxWidth / minItemWidth)
            .floor()
            .clamp(1, 6);

        return Padding(
          padding: const EdgeInsets.all(AppConstants.spacingS),
          child: Column(
            children: [
              const SectionHeaderWidget(
                title: 'Widget Palette',
                icon: Icons.widgets,
                subtitle: 'A collection of reusable widgets',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.spacingS,
                ),
                child: SearchBarWidget(
                  hintText: 'Search for widgets...',
                  onChanged: (value) {
                    final notifier = ref.read(
                      appBuilderWidgetPaletteNotifierProvider.notifier,
                    );
                    notifier.filterWidgets(value);
                  },
                ),
              ),
              Expanded(
                child: _buildWidgetList(provider.widgets, crossAxisCount),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWidgetList(List<String> widgets, int crossAxisCount) {
    if (widgets.isEmpty) {
      return const EmptyStateWidget(
        title: 'No widgets found',
        message: 'Try adjusting your search or category filter',
        icon: Icons.search_off,
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.90,
      ),
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int index) {
        return DraggableItemWidget(
          feedback: _PaletteCard(widgetType: widgets[index]),
          data: widgets[index],
          child: _PaletteCard(widgetType: widgets[index]),
        );
      },
    );
  }
}

class _PaletteCard extends StatelessWidget {
  const _PaletteCard({required this.widgetType});

  final String widgetType;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        side: BorderSide(
          color: Colors.black.withAlpha((0.15 * 255).toInt()),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingS),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CategoryIconWidget(type: widgetType),
            const SizedBox(height: AppConstants.spacingXS),
            Text(
              widgetType,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
