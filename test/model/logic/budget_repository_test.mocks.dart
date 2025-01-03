// Mocks generated by Mockito 5.4.5 from annotations
// in freenance/test/model/logic/budget_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:freenance/model/logic/freenance_db.dart' as _i4;
import 'package:freenance/model/objects/budget.dart' as _i6;
import 'package:freenance/model/objects/envelope.dart' as _i3;
import 'package:freenance/model/objects/operation.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCompleter_0<T> extends _i1.SmartFake implements _i2.Completer<T> {
  _FakeCompleter_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEnvelope_1 extends _i1.SmartFake implements _i3.Envelope {
  _FakeEnvelope_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FreenanceDb].
///
/// See the documentation for Mockito's code generation for more information.
class MockFreenanceDb extends _i1.Mock implements _i4.FreenanceDb {
  MockFreenanceDb() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Completer<_i5.Database> get dbCompleter => (super.noSuchMethod(
        Invocation.getter(#dbCompleter),
        returnValue: _FakeCompleter_0<_i5.Database>(
          this,
          Invocation.getter(#dbCompleter),
        ),
      ) as _i2.Completer<_i5.Database>);

  @override
  set dbCompleter(_i2.Completer<_i5.Database>? _dbCompleter) =>
      super.noSuchMethod(
        Invocation.setter(
          #dbCompleter,
          _dbCompleter,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);

  @override
  _i2.Future<List<_i6.Budget>> findAllBudgets() => (super.noSuchMethod(
        Invocation.method(
          #findAllBudgets,
          [],
        ),
        returnValue: _i2.Future<List<_i6.Budget>>.value(<_i6.Budget>[]),
      ) as _i2.Future<List<_i6.Budget>>);

  @override
  _i2.Future<List<_i3.Envelope>> findEnvelopesByBudget(_i6.Budget? budget) =>
      (super.noSuchMethod(
        Invocation.method(
          #findEnvelopesByBudget,
          [budget],
        ),
        returnValue: _i2.Future<List<_i3.Envelope>>.value(<_i3.Envelope>[]),
      ) as _i2.Future<List<_i3.Envelope>>);

  @override
  _i2.Future<List<_i7.Operation>> findOperationsByEnvelope(
          _i3.Envelope? envelope) =>
      (super.noSuchMethod(
        Invocation.method(
          #findOperationsByEnvelope,
          [envelope],
        ),
        returnValue: _i2.Future<List<_i7.Operation>>.value(<_i7.Operation>[]),
      ) as _i2.Future<List<_i7.Operation>>);

  @override
  _i2.Future<void> insertBudget(_i6.Budget? editedBudget) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertBudget,
          [editedBudget],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);

  @override
  _i2.Future<void> updateBudget(_i6.Budget? editedBudget) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateBudget,
          [editedBudget],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);

  @override
  _i2.Future<void> delete(_i3.Envelope? envelope) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [envelope],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);

  @override
  void deleteBudget(_i6.Budget? budget) => super.noSuchMethod(
        Invocation.method(
          #deleteBudget,
          [budget],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void insertEnvelope({
    required int? budgetId,
    required _i3.Envelope? envelope,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #insertEnvelope,
          [],
          {
            #budgetId: budgetId,
            #envelope: envelope,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.Future<void> insertOperation({
    required int? envelopeId,
    required _i7.Operation? operation,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertOperation,
          [],
          {
            #envelopeId: envelopeId,
            #operation: operation,
          },
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);

  @override
  _i2.Future<_i3.Envelope> findEnvelope(int? envelopeId) => (super.noSuchMethod(
        Invocation.method(
          #findEnvelope,
          [envelopeId],
        ),
        returnValue: _i2.Future<_i3.Envelope>.value(_FakeEnvelope_1(
          this,
          Invocation.method(
            #findEnvelope,
            [envelopeId],
          ),
        )),
      ) as _i2.Future<_i3.Envelope>);

  @override
  _i2.Future<void> updateOperation(_i7.Operation? operation) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateOperation,
          [operation],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);

  @override
  _i2.Future<void> updateEnvelope(_i3.Envelope? envelope) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateEnvelope,
          [envelope],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);

  @override
  _i2.Future<void> deleteOperation(_i7.Operation? operation) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteOperation,
          [operation],
        ),
        returnValue: _i2.Future<void>.value(),
        returnValueForMissingStub: _i2.Future<void>.value(),
      ) as _i2.Future<void>);
}
