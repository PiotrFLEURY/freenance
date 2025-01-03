// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TestCodeBuilder
// **************************************************************************

import 'package:flutter_test/flutter_test.dart';

import 'step_definitions.dart';

runFeatures() {
  final steps = FreenanceStepDefinitions();
  group(
    'Budget',
    () {
      testWidgets(
        'First budget',
        (WidgetTester widgetTester) async {
          await steps.iStartMyApp(widgetTester);
          await steps.iWaitForTheLoadingToFinish(widgetTester);
          await steps.iShouldAlreadyHaveABudget(widgetTester);
          await steps.andIShouldSeeAnEnvelope(widgetTester);
        },
      );
      testWidgets(
        'First envelope',
        (WidgetTester widgetTester) async {
          await steps.iStartMyApp(widgetTester);
          await steps.iWaitForTheLoadingToFinish(widgetTester);
          await steps.iTapOnTheEnvelope(widgetTester);
          await steps.iShouldSeeAnOperationOfEuros(
            widgetTester,
            500.0,
          );
        },
      );
    },
  );
  group(
    'App starts',
    () {
      testWidgets(
        'Start App',
        (WidgetTester widgetTester) async {
          await steps.iStartMyApp(widgetTester);
          await steps.iShouldSeeALoader(widgetTester);
          await steps.thenTheHomePage(widgetTester);
        },
      );
    },
  );
}
