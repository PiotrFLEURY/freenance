import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freenance/app.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/model/objects/operation.dart';
import 'package:freenance/view/home/widgets/bottom_sheet.dart';
import 'package:freenance/view_model/providers.dart';
import 'package:mockito/mockito.dart';
import 'package:pickled_cucumber/src/annotations.dart';

import 'cucumber_test.mocks.dart';

@StepDefinition()
class FreenanceStepDefinitions {
  final mockDatabase = MockFreenanceDb();

  FreenanceStepDefinitions() {
    final fakeBudgetList = [
      Budget(
        id: 0,
        label: 'Mon Budget',
        amount: 2_000,
        envelopes: [
          Envelope(
            id: 0,
            label: 'Mon Enveloppe',
            amount: 1_000,
            operations: [
              Operation(
                id: 0,
                label: 'Mon Opération',
                amount: 500,
                date: DateTime.now(),
              ),
            ],
          ),
        ],
      ),
    ];

    when(mockDatabase.init()).thenAnswer((_) async {});
    when(mockDatabase.findAllBudgets()).thenAnswer((_) async => fakeBudgetList);

    when(mockDatabase.init()).thenAnswer((_) async {});
    when(mockDatabase.findAllBudgets()).thenAnswer((_) async => fakeBudgetList);
  }

  @When('I start my App')
  Future<void> iStartMyApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(mockDatabase),
        ],
        child: Freenance(),
      ),
    );
  }

  @Then('I should see a loader')
  Future<void> iShouldSeeALoader(WidgetTester tester) async {
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  }

  @And('then the home page')
  Future<void> thenTheHomePage(WidgetTester tester) async {
    await tester.pumpAndSettle();
    expect(find.byType(HomeBottomSheet), findsOneWidget);
  }
}
