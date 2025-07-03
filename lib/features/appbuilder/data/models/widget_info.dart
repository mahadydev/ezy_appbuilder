import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'widget_info.freezed.dart';

@freezed
sealed class WidgetInfo with _$WidgetInfo {
  const factory WidgetInfo({
    required final String name,
    required final IconData icon,
    required final String description,
  }) = _WidgetInfo;
}
