enum WidgetType {
  column,
  row,
  stack,
  wrap,
  listView,
  gridView,
  container,
  center,
  align,
  card,
  padding,
  sizedBox,
  expanded,
  flexible,
  singleChildScrollView,
  pageView,
  positioned,
  scaffold,
  text,
  icon,
  checkbox,
  switchWidget,
  radio,
  slider,
  image,
  listTile,
  elevatedButton,
  textButton,
  outlinedButton,
  textField,
  textFormField,
}

WidgetType? widgetTypeFromString(String? type) {
  switch (type) {
    case 'Column': return WidgetType.column;
    case 'Row': return WidgetType.row;
    case 'Stack': return WidgetType.stack;
    case 'Wrap': return WidgetType.wrap;
    case 'ListView': return WidgetType.listView;
    case 'GridView': return WidgetType.gridView;
    case 'Container': return WidgetType.container;
    case 'Center': return WidgetType.center;
    case 'Align': return WidgetType.align;
    case 'Card': return WidgetType.card;
    case 'Padding': return WidgetType.padding;
    case 'SizedBox': return WidgetType.sizedBox;
    case 'Expanded': return WidgetType.expanded;
    case 'Flexible': return WidgetType.flexible;
    case 'SingleChildScrollView': return WidgetType.singleChildScrollView;
    case 'PageView': return WidgetType.pageView;
    case 'Positioned': return WidgetType.positioned;
    case 'Scaffold': return WidgetType.scaffold;
    case 'Text': return WidgetType.text;
    case 'Icon': return WidgetType.icon;
    case 'Checkbox': return WidgetType.checkbox;
    case 'Switch': return WidgetType.switchWidget;
    case 'Radio': return WidgetType.radio;
    case 'Slider': return WidgetType.slider;
    case 'Image': return WidgetType.image;
    case 'ListTile': return WidgetType.listTile;
    case 'ElevatedButton': return WidgetType.elevatedButton;
    case 'TextButton': return WidgetType.textButton;
    case 'OutlinedButton': return WidgetType.outlinedButton;
    case 'TextField': return WidgetType.textField;
    case 'TextFormField': return WidgetType.textFormField;
    default: return null;
  }
}
