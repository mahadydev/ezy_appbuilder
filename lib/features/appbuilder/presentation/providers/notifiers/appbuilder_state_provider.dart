import 'package:ezy_appbuilder/features/appbuilder/presentation/providers/states/appbuilder_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appbuilder_state_provider.g.dart';

@riverpod
class AppBuilderStateNotifier extends _$AppBuilderStateNotifier {
  @override
  AppbuilderState build() {
    return const AppbuilderState();
  }

  /// Toggle the preview mode
  void togglePreview() {
    state = state.copyWith(showPreview: !state.showPreview);
  }

  /// Reset the JSON state
  void resetJson() {
    state = state.copyWith(theJson: {});
  }

  /// Reset the JSON state
  void addScaffoldWithAppBar() {
    // sample  JSON structure
    state = state.copyWith(
      theJson: {
        'type': 'Scaffold',
        'properties': {
          'appBar': {
            'type': 'AppBar',
            'properties': {
              'title': 'JSON UI Demo',
              'backgroundColor': '#2196F3',
            },
          },
        },
        'child': {
          'type': 'ListView',
          'properties': {
            'padding': {'top': 16, 'bottom': 16, 'left': 16, 'right': 16},
          },
          'children': [
            {
              'type': 'Card',
              'properties': {
                'elevation': 4,
                'margin': {'bottom': 16},
              },
              'child': {
                'type': 'ListTile',
                'properties': {
                  'title': 'Profile Settings',
                  'subtitle': 'Manage your account',
                },
              },
            },
            {
              'type': 'Container',
              'properties': {
                'padding': 16,
                'decoration': {'color': '#F5F5F5', 'borderRadius': 8},
              },
              'child': {
                'type': 'Row',
                'properties': {'mainAxisAlignment': 'spaceBetween'},
                'children': [
                  {
                    'type': 'Text',
                    'properties': {'text': 'Dark Mode'},
                  },
                  {
                    'type': 'Switch',
                    'properties': {'value': true},
                  },
                ],
              },
            },
          ],
        },
      },
    );
  }
}
