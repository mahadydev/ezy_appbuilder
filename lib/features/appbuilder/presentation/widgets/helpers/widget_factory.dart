import 'package:flutter/material.dart';
import 'package:ezy_appbuilder/features/appbuilder/presentation/widgets/helpers/widget_type.dart';

class WidgetFactory {
  static Widget buildMultiChildWidget({
    required WidgetType type,
    required List<Widget> children,
    required Map<String, dynamic> config,
    required Widget widget,
  }) {
    switch (type) {
      case WidgetType.column:
        return Column(
          key: widget.key,
          mainAxisAlignment: widget is Column ? widget.mainAxisAlignment : MainAxisAlignment.start,
          crossAxisAlignment: widget is Column ? widget.crossAxisAlignment : CrossAxisAlignment.center,
          mainAxisSize: widget is Column ? widget.mainAxisSize : MainAxisSize.max,
          children: children,
        );
      case WidgetType.row:
        return Row(
          key: widget.key,
          mainAxisAlignment: widget is Row ? widget.mainAxisAlignment : MainAxisAlignment.start,
          crossAxisAlignment: widget is Row ? widget.crossAxisAlignment : CrossAxisAlignment.center,
          mainAxisSize: widget is Row ? widget.mainAxisSize : MainAxisSize.max,
          children: children,
        );
      case WidgetType.stack:
        return Stack(
          key: widget.key,
          alignment: widget is Stack ? widget.alignment : AlignmentDirectional.topStart,
          textDirection: widget is Stack ? widget.textDirection : null,
          clipBehavior: widget is Stack ? widget.clipBehavior : Clip.hardEdge,
          children: children,
        );
      default:
        return widget;
    }
  }
}
