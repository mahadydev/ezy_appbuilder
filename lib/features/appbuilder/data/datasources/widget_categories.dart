import 'package:ezy_appbuilder/features/appbuilder/data/models/widget_info.dart';
import 'package:flutter/material.dart';

final Map<String, List<WidgetInfo>> widgetCategories = {
  'Layout': [
    WidgetInfo(
      name: 'Container',
      icon: Icons.crop_square,
      description: 'A box model container for layout and styling.',
    ),
    WidgetInfo(
      name: 'Column',
      icon: Icons.view_column,
      description: 'Layout children vertically.',
    ),
    WidgetInfo(
      name: 'Row',
      icon: Icons.view_stream,
      description: 'Layout children horizontally.',
    ),
    WidgetInfo(
      name: 'Stack',
      icon: Icons.layers,
      description: 'Stack widgets on top of each other.',
    ),
    WidgetInfo(
      name: 'Positioned',
      icon: Icons.place,
      description: 'Position a child within a Stack.',
    ),
    WidgetInfo(
      name: 'Expanded',
      icon: Icons.open_in_full,
      description: 'Expand a child of a Row, Column, or Flex.',
    ),
    WidgetInfo(
      name: 'Flexible',
      icon: Icons.fit_screen,
      description: 'Flexible space allocation in a flex container.',
    ),
    WidgetInfo(
      name: 'Wrap',
      icon: Icons.wrap_text,
      description: 'Wrap children to the next line.',
    ),
    WidgetInfo(
      name: 'Center',
      icon: Icons.format_align_center,
      description: 'Center a child widget.',
    ),
    WidgetInfo(
      name: 'Align',
      icon: Icons.align_vertical_center,
      description: 'Align a child within its parent.',
    ),
    WidgetInfo(
      name: 'Padding',
      icon: Icons.padding,
      description: 'Add padding around a child.',
    ),
    WidgetInfo(
      name: 'SizedBox',
      icon: Icons.crop_16_9,
      description: 'A box with a fixed size.',
    ),
  ],
  'Text': [
    WidgetInfo(
      name: 'Text',
      icon: Icons.text_fields,
      description: 'Display a string of text.',
    ),
    WidgetInfo(
      name: 'RichText',
      icon: Icons.text_format,
      description: 'Display styled text with multiple styles.',
    ),
    WidgetInfo(
      name: 'TextField',
      icon: Icons.input,
      description: 'Basic text input field.',
    ),
    WidgetInfo(
      name: 'TextFormField',
      icon: Icons.edit,
      description: 'Form-integrated text input field.',
    ),
  ],
  'Button': [
    WidgetInfo(
      name: 'ElevatedButton',
      icon: Icons.smart_button,
      description: 'A Material Design elevated button.',
    ),
    WidgetInfo(
      name: 'TextButton',
      icon: Icons.text_fields,
      description: 'A Material Design flat button.',
    ),
    WidgetInfo(
      name: 'OutlinedButton',
      icon: Icons.crop_square,
      description: 'A Material Design outlined button.',
    ),
    WidgetInfo(
      name: 'IconButton',
      icon: Icons.radio_button_checked,
      description: 'A button with an icon.',
    ),
    WidgetInfo(
      name: 'FloatingActionButton',
      icon: Icons.add_circle,
      description: 'A circular button for primary actions.',
    ),
  ],
  'Input': [
    WidgetInfo(
      name: 'Checkbox',
      icon: Icons.check_box,
      description: 'A Material Design checkbox.',
    ),
    WidgetInfo(
      name: 'Radio',
      icon: Icons.radio_button_checked,
      description: 'A Material Design radio button.',
    ),
    WidgetInfo(
      name: 'Switch',
      icon: Icons.toggle_on,
      description: 'A Material Design switch.',
    ),
    WidgetInfo(
      name: 'Slider',
      icon: Icons.tune,
      description: 'A Material Design slider.',
    ),
    WidgetInfo(
      name: 'DropdownButton',
      icon: Icons.arrow_drop_down_circle,
      description: 'A dropdown button for selecting items.',
    ),
  ],
  'Material': [
    WidgetInfo(
      name: 'Scaffold',
      icon: Icons.tablet,
      description:
          'Implements the basic Material Design visual layout structure.',
    ),
    WidgetInfo(
      name: 'AppBar',
      icon: Icons.web_asset,
      description: 'A Material Design app bar.',
    ),
    WidgetInfo(
      name: 'Card',
      icon: Icons.credit_card,
      description: 'A Material Design card.',
    ),
    WidgetInfo(
      name: 'ListTile',
      icon: Icons.list,
      description:
          'A single fixed-height row that typically contains some text as well as a leading or trailing icon.',
    ),
    WidgetInfo(
      name: 'Drawer',
      icon: Icons.menu,
      description:
          'A Material Design panel that slides in horizontally from the edge of a Scaffold.',
    ),
    WidgetInfo(
      name: 'BottomNavigationBar',
      icon: Icons.space_bar,
      description: 'A Material Design bottom navigation bar.',
    ),
    WidgetInfo(
      name: 'TabBar',
      icon: Icons.tab,
      description: 'A Material Design tab bar.',
    ),
    WidgetInfo(
      name: 'Tab',
      icon: Icons.tab_unselected,
      description: 'A Material Design tab.',
    ),
  ],
  'Scrollable': [
    WidgetInfo(
      name: 'ListView',
      icon: Icons.view_list,
      description: 'A scrollable list of widgets.',
    ),
    WidgetInfo(
      name: 'GridView',
      icon: Icons.grid_on,
      description: 'A scrollable, 2D array of widgets.',
    ),
    WidgetInfo(
      name: 'SingleChildScrollView',
      icon: Icons.swap_vert,
      description: 'A scrollable widget for a single child.',
    ),
    WidgetInfo(
      name: 'PageView',
      icon: Icons.pages,
      description: 'A scrollable list that works page by page.',
    ),
  ],
  'Image': [
    WidgetInfo(
      name: 'Image',
      icon: Icons.image,
      description: 'A widget that displays an image.',
    ),
    WidgetInfo(
      name: 'NetworkImage',
      icon: Icons.cloud_download,
      description: 'Load and display an image from the network.',
    ),
    WidgetInfo(
      name: 'AssetImage',
      icon: Icons.insert_photo,
      description: 'Load and display an image from local assets.',
    ),
    WidgetInfo(
      name: 'CircleAvatar',
      icon: Icons.account_circle,
      description: 'A circular icon or image.',
    ),
    WidgetInfo(
      name: 'Icon',
      icon: Icons.insert_emoticon,
      description: 'A Material Design icon.',
    ),
  ],
};
