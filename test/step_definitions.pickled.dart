// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TestCodeBuilder
// **************************************************************************

import 'package:flutter_test/flutter_test.dart';

import 'step_definitions.dart';

runFeatures() {
  final steps = FreenanceStepDefinitions();
  group(
    'App starts',
    () {
      testWidgets(
        'Start App',
        (WidgetTester widgetTester) async {
          await steps.iStartMyApp(widgetTester);
          await steps.iShouldSeeALoader(widgetTester);
          await steps.thenTheText(
            widgetTester,
            'Freenance',
          );
        },
      );
    },
  );
}
