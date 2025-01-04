import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freenance/app.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/model/objects/operation.dart';
import 'package:freenance/view/envelope/envelope_screen.dart';
import 'package:freenance/view/home/widgets/bottom_sheet.dart';
import 'package:freenance/view/home/widgets/envelope_row.dart';
import 'package:freenance/view/localization/freenance_localization.dart';
import 'package:freenance/view_model/providers.dart';
import 'package:mockito/mockito.dart';
import 'package:pickled_cucumber/src/annotations.dart';

import 'cucumber_test.mocks.dart';

class TestLocalizationSource extends LocalizationsSource {
  @override
  Future<String> provideSource(String path) {
    final source = '''
{
    "app_name": "Freenance",
    "color_picker_title": "Choose a color",
    "color_picker_red_color": "Red",
    "color_picker_green_color": "Green",
    "color_picker_blue_color": "Blue",
    "color_picker_reset_button": "Reset",
    "color_picker_validate_button": "Validate",
    "drawer_menu_home": "My budgets",
    "drawer_menu_color_theme": "Color theme",
    "drawer_menu_about": "About",
    "drawer_menu_language": "Language",
    "drawer_menu_french": "French",
    "drawer_menu_english": "English",
    "confirmation_dialog_cancel": "Cancel",
    "confirmation_dialog_understood": "Understood",
    "confirmation_dialog_confirm": "Confirm",
    "edition_screen_label": "Label",
    "edition_screen_label_hint": "Enter a label",
    "edition_screen_amount": "Amount",
    "edition_screen_amount_hint": "Enter an amount",
    "edition_screen_cancel_button": "Cancel",
    "edition_screen_validate_button": "Validate",
    "envelope_screen_title": "Envelope {}",
    "envelope_screen_search_field": "Search",
    "envelope_screen_search_hint": "Groceries, rent, etc.",
    "envelope_screen_total_operations": "Total",
    "envelope_screen_add_operation": "Add an operation",
    "envelope_screen_remaining": "Remaining {} €",
    "envelope_screen_edit_envelope": "Edit envelope",
    "envelope_screen_edit_operation": "Edit operation",
    "home_screen_budget_exceeded": "Budget exceeded by {} €",
    "home_screen_add_envelope": "Add an envelope",
    "home_screen_remaining": "Remaining",
    "home_screen_create_budget": "Create a budget",
    "home_screen_edit_budget": "Edit a budget"
}
''';
    return Future.value(source);
  }
}

@StepDefinition()
class FreenanceStepDefinitions {
  final mockDatabase = MockFreenanceDb();

  FreenanceStepDefinitions() {
    FreenanceLocalizations.supportedLocales = [
      Locale('en', 'US'),
    ];
    FreenanceLocalizations.source = TestLocalizationSource();

    final fakeOperation = Operation(
      id: 0,
      label: 'My Operation',
      amount: 500,
      date: DateTime.now(),
    );
    final fakeEnvelope = Envelope(
      id: 0,
      label: 'My Envelope',
      amount: 1_000,
      operations: [
        fakeOperation,
      ],
    );
    final fakeBudgetList = [
      Budget(
        id: 0,
        label: 'My Budget',
        amount: 2_000,
        envelopes: [
          fakeEnvelope,
        ],
      ),
    ];

    when(mockDatabase.init()).thenAnswer((_) async {});
    when(mockDatabase.findAllBudgets()).thenAnswer((_) async => fakeBudgetList);

    when(mockDatabase.init()).thenAnswer((_) async {});
    when(mockDatabase.findAllBudgets()).thenAnswer((_) async => fakeBudgetList);

    when(mockDatabase.findEnvelope(any))
        .thenAnswer((_) async => Future.value(fakeEnvelope));
  }

  @Given('I start my App')
  @When('I start my App')
  Future<void> iStartMyApp(WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(mockDatabase),
        ],
        child: Freenance(),
      ),
    );
  }

  @Then('then the home page')
  Future<void> thenTheHomePage(WidgetTester tester) async {
    await tester.pumpAndSettle();
    debugDumpApp();
    expect(find.byType(HomeBottomSheet), findsOneWidget);
  }

  @And('I wait for the loading to finish')
  Future<void> iWaitForTheLoadingToFinish(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }

  @Then('I should already have a budget')
  Future<void> iShouldAlreadyHaveABudget(WidgetTester tester) async {
    expect(find.text('My Budget'), findsOneWidget);
    expect(find.text('2000.0 €'), findsOneWidget);
  }

  @And('I should see an envelope')
  Future<void> andIShouldSeeAnEnvelope(WidgetTester tester) async {
    expect(find.text('My Envelope'), findsOneWidget);
    expect(find.text('1000.0 €'), findsOneWidget);
  }

  @And('I tap on the envelope')
  Future<void> iTapOnTheEnvelope(WidgetTester tester) async {
    await tester.tap(find.byType(EnvelopeRow));
    await tester.pumpAndSettle();
  }

  @Then('I should see an operation of {float} €')
  Future<void> iShouldSeeAnOperationOfEuros(
    WidgetTester tester,
    double amount,
  ) async {
    await tester.pumpAndSettle();

    expect(find.text('My Operation'), findsOneWidget);
    expect(find.text('- ${amount.toStringAsFixed(2)} €'), findsOneWidget);
  }

  @When('I create a new envelope named {string} with {float} amound')
  Future<void> iCreateANewEnvelopeNamedWithAmound(
    WidgetTester tester,
    String label,
    double amount,
  ) async {
    // Click on add button
    await tester.tap(find.text('Add an envelope'));
    await tester.pumpAndSettle();

    // Fill the label
    await tester.enterText(find.byKey(Key('edition_screen_label')), label);
    await tester.pumpAndSettle();

    // Fill the amount
    await tester.enterText(
      find.byKey(Key('edition_screen_amount')),
      amount.toString(),
    );
    await tester.pumpAndSettle();

    // Click on validate button
    await tester.tap(find.text('Validate'));
    await tester.pumpAndSettle();
  }

  @Then('I should see the envelope screen openning')
  Future<void> iShouldSeeTheEnvelopeScreenOpenning(WidgetTester tester) async {
    expect(find.byType(EnvelopeScreen), findsOneWidget);
  }
}
