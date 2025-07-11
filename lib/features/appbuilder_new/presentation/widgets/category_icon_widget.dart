import 'package:ezy_appbuilder/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CategoryIconWidget extends StatelessWidget {
  const CategoryIconWidget({super.key, required this.type, this.iconSize});
  final String type;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    // You can customize the icon based on the type if needed
    IconData icon;
    switch (type) {
      case 'Scaffold':
        icon = Icons.tablet;
        break;
      case 'Container':
        icon = Icons.crop_square;
        break;
      case 'Column':
        icon = Icons.view_column;
        break;
      case 'Row':
        icon = Icons.view_stream;
        break;
      case 'Stack':
        icon = Icons.layers;
        break;
      case 'Text':
        icon = Icons.text_fields;
        break;
      case 'Button':
        icon = Icons.smart_button;
        break;
      case 'Image':
        icon = Icons.image;
        break;
      case 'Icon':
        icon = Icons.insert_emoticon;
        break;
      case 'Input':
        icon = Icons.input;
        break;
      case 'Checkbox':
        icon = Icons.check_box;
        break;
      case 'Radio':
        icon = Icons.radio_button_checked;
        break;
      case 'Switch':
        icon = Icons.toggle_on;
        break;
      case 'Slider':
        icon = Icons.tune;
        break;
      case 'DropdownButton':
        icon = Icons.arrow_drop_down_circle;
        break;
      case 'ListView':
        icon = Icons.view_list;
        break;
      case 'GridView':
        icon = Icons.grid_on;
        break;
      case 'SingleChildScrollView':
        icon = Icons.swap_vert;
        break;
      case 'PageView':
        icon = Icons.pages;
        break;
      case 'AppBar':
        icon = Icons.web_asset;
        break;
      case 'Card':
        icon = Icons.credit_card;
        break;
      case 'ListTile':
        icon = Icons.list;
        break;
      case 'Drawer':
        icon = Icons.menu;
        break;
      case 'BottomNavigationBar':
        icon = Icons.space_bar;
        break;
      case 'TabBar':
        icon = Icons.tab;
        break;
      case 'Tab':
        icon = Icons.tab_unselected;
        break;
      case 'Positioned':
        icon = Icons.place;
        break;
      case 'Expanded':
        icon = Icons.open_in_full;
        break;
      case 'Flexible':
        icon = Icons.fit_screen;
        break;
      case 'Wrap':
        icon = Icons.wrap_text;
        break;
      case 'Center':
        icon = Icons.format_align_center;
        break;
      case 'Align':
        icon = Icons.align_vertical_center;
        break;
      case 'Padding':
        icon = Icons.padding;
        break;
      case 'SizedBox':
        icon = Icons.crop_16_9;
        break;
      case 'TextField':
        icon = Icons.input;
        break;
      case 'TextFormField':
        icon = Icons.edit;
        break;
      case 'ElevatedButton':
        icon = Icons.smart_button;
        break;
      case 'TextButton':
        icon = Icons.text_fields;
        break;
      case 'OutlinedButton':
        icon = Icons.crop_square;
        break;
      case 'IconButton':
        icon = Icons.radio_button_checked;
        break;
      case 'FloatingActionButton':
        icon = Icons.add_circle;
        break;
      case 'NetworkImage':
        icon = Icons.cloud_download;
        break;
      case 'AssetImage':
        icon = Icons.insert_photo;
        break;
      case 'CircleAvatar':
        icon = Icons.account_circle;
        break;
      case 'RichText':
        icon = Icons.text_format;
        break;
      default:
        icon = Icons.widgets;
    }

    return Icon(
      icon,
      size: iconSize ?? AppConstants.defaultIconSize * 2,
      color: Colors.grey.shade700,
    );
  }
}
