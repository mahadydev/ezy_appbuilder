/// Application-wide constants
class AppConstants {
  // App Information
  static const String appName = 'Ezycourse App Builder';
  static const String appDescription =
      'Visual app builder for Ezycourse platform';
  static const String version = '1.0.0';

  // Canvas Configuration
  static const double canvasWidth = 440.0;
  static const double canvasHeight = 956.0;
  static const double minZoomFactor = 0.5;
  static const double maxZoomFactor = 2.0;
  static const double zoomStep = 0.1;

  // Layout Dimensions
  static const double paletteWidthWide = 340.0;
  static const double paletteWidthNarrow = 160.0;
  static const double propertyEditorWidth = 340.0;
  static const double propertyEditorWidthNarrow = 240.0;
  static const double wideScreenBreakpoint = 1200.0;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;

  // Border Radius
  static const double borderRadiusS = 4.0;
  static const double borderRadiusM = 8.0;
  static const double borderRadiusL = 12.0;
  static const double borderRadiusXL = 16.0;

  // Elevation
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;

  // Animation Durations
  static const Duration animationDurationFast = Duration(milliseconds: 150);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  // Default Widget Properties
  static const double defaultFontSize = 16.0;
  static const double defaultIconSize = 24.0;
  static const double defaultButtonHeight = 48.0;
  static const double defaultContainerWidth = 200.0;
  static const double defaultContainerHeight = 100.0;

  // Storage Keys
  static const String storageKeyDesigns = 'app_designs';
  static const String storageKeySettings = 'app_settings';
  static const String storageKeyRecentDesigns = 'recent_designs';
}
