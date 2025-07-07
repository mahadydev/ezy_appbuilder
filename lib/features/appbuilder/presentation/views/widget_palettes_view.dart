import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:ezy_appbuilder/core/theme/app_theme.dart';
import 'package:ezy_appbuilder/features/appbuilder/data/datasources/widget_categories.dart';
import 'package:ezy_appbuilder/features/appbuilder/data/models/widget_info.dart';
import 'package:ezy_appbuilder/shared/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class WidgetPalettesView extends StatefulWidget {
  const WidgetPalettesView({super.key});

  @override
  State<WidgetPalettesView> createState() => _WidgetPalettesViewState();
}

class _WidgetPalettesViewState extends State<WidgetPalettesView> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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
      child: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          _buildCategoryTabs(),
          Expanded(child: _buildWidgetList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SectionHeaderWidget(title: 'Widget Palette', icon: Icons.widgets);
  }

  Widget _buildSearchBar() {
    return SearchBarWidget(
      hintText: 'Search widgets...',
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          _searchQuery = value.toLowerCase();
        });
      },
      onClear: () {
        setState(() {
          _searchQuery = '';
        });
      },
    );
  }

  Widget _buildCategoryTabs() {
    final allCategories = ['All', ...widgetCategories.keys];

    return SizedBox(
      height: 70,
      child: Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
            vertical: AppConstants.spacingM,
          ),
          itemCount: allCategories.length,
          itemBuilder: (context, index) {
            final category = allCategories[index];
            return Padding(
              padding: const EdgeInsets.only(right: AppConstants.spacingS),
              child: CustomChipWidget(
                label: category,
                isSelected: _selectedCategory == category,
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWidgetList() {
    final List<WidgetInfo> widgets = _getFilteredWidgets();

    if (widgets.isEmpty) {
      return const EmptyStateWidget(
        title: 'No widgets found',
        message: 'Try adjusting your search or category filter',
        icon: Icons.search_off,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        final widgetInfo = widgets[index];
        return _buildWidgetTile(widgetInfo);
      },
    );
  }

  List<WidgetInfo> _getFilteredWidgets() {
    List<WidgetInfo> allWidgets = [];

    if (_selectedCategory == 'All') {
      for (var widgets in widgetCategories.values) {
        allWidgets.addAll(widgets);
      }
    } else {
      allWidgets = widgetCategories[_selectedCategory] ?? [];
    }

    if (_searchQuery.isNotEmpty) {
      allWidgets = allWidgets
          .where(
            (widget) =>
                widget.name.toLowerCase().contains(_searchQuery) ||
                widget.description.toLowerCase().contains(_searchQuery),
          )
          .toList();
    }

    return allWidgets;
  }

  Widget _buildWidgetTile(WidgetInfo widgetInfo) {
    return DraggableItemWidget(
      data: widgetInfo,
      feedback: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildDragFeedback(widgetInfo),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: AppConstants.spacingS),
        child: _buildWideScreenTile(widgetInfo),
      ),
    );
  }

  Widget _buildDragFeedback(WidgetInfo widgetInfo) {
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
              widgetInfo.icon,
              color: AppTheme.primaryColor,
              size: AppConstants.defaultIconSize,
            ),
            const SizedBox(width: AppConstants.spacingS),
            Text(
              widgetInfo.name,
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

  Widget _buildWideScreenTile(WidgetInfo widgetInfo) {
    return ListTile(
      leading: Icon(
        widgetInfo.icon,
        color: AppTheme.primaryColor,
        size: AppConstants.defaultIconSize,
      ),
      title: Text(
        widgetInfo.name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimaryColor,
        ),
      ),
      subtitle: Text(
        widgetInfo.description,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.textSecondaryColor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.drag_indicator, color: AppTheme.textHintColor, size: 16),
        ],
      ),
    );
  }
}
