# Flutter App Builder - Widget Drag & Drop System

## 🎯 Project Overview
A comprehensive Flutter application builder that enables users to create dynamic UIs through an intuitive drag-and-drop interface, powered by the `json_ui_builder` package.

## ✅ Implemented Features

### 1. **Widget Drag & Drop System**
- **Widget Palette** with categorized widgets (Layout, Text, Button, Input, Material, etc.)
- **Draggable Widgets** with visual feedback during drag
- **Drop Target Canvas** with visual indicators when widgets are dragged over
- **Smart Widget Addition** with appropriate parent-child relationship logic
- **Error Handling** for invalid widget placements

### 2. **Interactive Hierarchy Tree**
- **Visual Widget Tree** showing parent-child relationships
- **Expandable/Collapsible nodes** for complex widget structures
- **Widget Selection** by clicking on tree nodes
- **Visual Selection Feedback** with highlighting
- **Widget Information Display** (property count, children count)

### 3. **Dynamic Property Editor**
- **Type-Specific Property Forms** adapting to selected widget type
- **Multiple Input Types**:
  - String fields (text, labels, hints)
  - Number fields (dimensions, sizes)
  - Color pickers with visual preview
  - Boolean switches
  - Dropdown selectors (alignment, positioning)
- **Real-Time Updates** reflecting changes immediately on canvas
- **Property Reset** functionality to restore defaults

### 4. **Widget Management**
- **Delete Functionality** with confirmation dialogs
- **Widget Selection** tracking across hierarchy and canvas
- **Property Validation** and error handling
- **Canvas Selection** - click widgets directly on canvas to select them

### 5. **Advanced User Experience**
- **Undo/Redo System** with history management (50 action limit)
- **Keyboard Shortcuts**:
  - `Delete` - Delete selected widget
  - `Escape` - Clear selection
  - `Ctrl+Z` - Undo
  - `Ctrl+Y` / `Ctrl+Shift+Z` - Redo
  - `Ctrl+R` - Reset canvas
- **Enhanced Toolbar** with undo/redo buttons and widget count
- **Toast Notifications** for user feedback
- **Drag Visual Feedback** with border highlights

### 6. **State Management**
- **Riverpod-based State Management** with proper separation of concerns
- **Immutable State** using Freezed for reliability
- **History Tracking** for undo/redo functionality
- **Reactive UI Updates** throughout the application

## 🏗️ Architecture

### State Management
```
AppbuilderState (Freezed)
├── theJson: Map<String, dynamic>         // Canvas widget JSON
├── selectedWidgetId: String?             // Currently selected widget
├── selectedWidgetProperties: Map         // Selected widget properties
├── isCanvasLoading: bool                 // Loading state
└── showPreview: bool                     // Preview mode toggle
```

### Core Components
- **AppBuilderStateNotifier**: Central state management with CRUD operations
- **PropertyForm**: Dynamic form generator for widget properties
- **CanvasViewport**: Drop target with device frame simulation
- **WidgetPalettesView**: Categorized draggable widget palette
- **PropertyEditorView**: Hierarchy tree + property editor

### Widget Categories
- **Layout**: Container, Column, Row, Stack, Positioned, Expanded, etc.
- **Text**: Text, RichText, TextField, TextFormField
- **Button**: ElevatedButton, TextButton, OutlinedButton, IconButton, FAB
- **Input**: Checkbox, Radio, Switch, Slider, DropdownButton
- **Material**: Scaffold, AppBar, Card, ListTile, Drawer, etc.
- **Scrollable**: ListView, GridView, SingleChildScrollView, PageView
- **Image**: Image, NetworkImage, AssetImage, CircleAvatar, Icon

## 🎨 User Interface

### Layout Structure
```
AppBuilderScreen
├── WidgetPalettesView (Left Panel)
│   ├── Search Bar
│   ├── Category Tabs
│   └── Draggable Widget List
├── CanvasView (Center)
│   ├── Canvas Toolbar (Undo/Redo/Reset)
│   └── Device Frame with Drop Target
└── PropertyEditorView (Right Panel)
    ├── Property Editor
    └── Hierarchy Tree
```

## 🔧 Technical Implementation

### JSON UI Builder Integration
- **WidgetConfig** objects for type-safe widget representation
- **JsonUIBuilder** for bi-directional JSON ↔ Widget conversion
- **Widget ID System** for unique identification and manipulation
- **Property Validation** ensuring type safety

### Drag & Drop Implementation
```dart
// Draggable Widget in Palette
DraggableItemWidget<WidgetInfo>(
  data: widgetInfo,
  feedback: DragFeedback(),
  child: WidgetTile(),
)

// Drop Target on Canvas
DragTarget<WidgetInfo>(
  onAcceptWithDetails: (details) => addWidget(details.data.name),
  builder: (context, candidateData, rejectedData) => Canvas(),
)
```

### Property Management
```dart
// Dynamic Property Form
PropertyForm(
  properties: selectedWidget.properties,
  widgetType: selectedWidget.type,
  onPropertiesChanged: (newProperties) => updateWidget(newProperties),
)
```

## 🚀 Usage Instructions

### Getting Started
1. **Add Scaffold**: Start by dragging a Scaffold widget to the canvas
2. **Add Widgets**: Drag widgets from the palette to build your UI
3. **Select Widgets**: Click on widgets in the hierarchy tree or canvas
4. **Edit Properties**: Modify properties in the property editor
5. **Preview**: Use the preview button to see the final result

### Keyboard Shortcuts
- **Delete**: Remove selected widget
- **Escape**: Clear selection
- **Ctrl+Z**: Undo last action
- **Ctrl+Y**: Redo last undone action
- **Ctrl+R**: Reset entire canvas

### Workflow
1. **Design Phase**: Use the widget palette and hierarchy tree
2. **Property Editing**: Fine-tune widget properties
3. **Preview Phase**: Test the final UI
4. **Iteration**: Use undo/redo for rapid prototyping

## 🎯 Key Benefits

1. **Visual Development**: No code required for UI creation
2. **Real-Time Feedback**: Immediate visual updates
3. **Type Safety**: JSON UI Builder ensures valid widget trees
4. **Comprehensive Widget Support**: 50+ Flutter widgets available
5. **Professional UX**: Undo/redo, keyboard shortcuts, visual feedback
6. **Extensible**: Easy to add new widgets and properties

## 🔮 Future Enhancements

- **Widget Templates**: Pre-built UI patterns
- **Animation Support**: Animated widgets and transitions
- **Theme Management**: Multiple theme support
- **Export Options**: Generate Flutter code or save/load projects
- **Custom Widgets**: User-defined custom widget registration
- **Responsive Design**: Breakpoint-based responsive layouts

## 📦 Dependencies

- **json_ui_builder**: Core JSON ↔ Widget conversion
- **flutter_riverpod**: State management
- **freezed**: Immutable data classes
- **device_frame**: Device simulation on canvas

## 🏁 Conclusion

This Flutter App Builder provides a complete, production-ready solution for visual Flutter UI development. The drag-and-drop system, comprehensive property editing, and professional UX features make it suitable for both beginners and advanced developers who want to rapidly prototype Flutter UIs.

The architecture is scalable, maintainable, and follows Flutter best practices, making it easy to extend with additional features and widgets as needed.
