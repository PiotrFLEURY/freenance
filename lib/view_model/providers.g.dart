// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'a9c4b9efe512ffab54ca365b240dfa260fa957f9';

/// See also [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeProvider<FreenanceDb>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = AutoDisposeProviderRef<FreenanceDb>;
String _$budgetRepositoryHash() => r'10598f90afff167e89c918094bd62269569d58f3';

/// See also [budgetRepository].
@ProviderFor(budgetRepository)
final budgetRepositoryProvider = AutoDisposeProvider<BudgetRepository>.internal(
  budgetRepository,
  name: r'budgetRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$budgetRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BudgetRepositoryRef = AutoDisposeProviderRef<BudgetRepository>;
String _$budgetListHash() => r'e2a2baab3f82b1a389c459723ec0446165a6f297';

/// See also [budgetList].
@ProviderFor(budgetList)
final budgetListProvider = AutoDisposeFutureProvider<List<Budget>>.internal(
  budgetList,
  name: r'budgetListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$budgetListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BudgetListRef = AutoDisposeFutureProviderRef<List<Budget>>;
String _$envelopeHash() => r'a676af9c0bf9a75450985da070a20dc05d3b7ee0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [envelope].
@ProviderFor(envelope)
const envelopeProvider = EnvelopeFamily();

/// See also [envelope].
class EnvelopeFamily extends Family<AsyncValue<Envelope>> {
  /// See also [envelope].
  const EnvelopeFamily();

  /// See also [envelope].
  EnvelopeProvider call(
    int envelopeId,
  ) {
    return EnvelopeProvider(
      envelopeId,
    );
  }

  @override
  EnvelopeProvider getProviderOverride(
    covariant EnvelopeProvider provider,
  ) {
    return call(
      provider.envelopeId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'envelopeProvider';
}

/// See also [envelope].
class EnvelopeProvider extends AutoDisposeFutureProvider<Envelope> {
  /// See also [envelope].
  EnvelopeProvider(
    int envelopeId,
  ) : this._internal(
          (ref) => envelope(
            ref as EnvelopeRef,
            envelopeId,
          ),
          from: envelopeProvider,
          name: r'envelopeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$envelopeHash,
          dependencies: EnvelopeFamily._dependencies,
          allTransitiveDependencies: EnvelopeFamily._allTransitiveDependencies,
          envelopeId: envelopeId,
        );

  EnvelopeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.envelopeId,
  }) : super.internal();

  final int envelopeId;

  @override
  Override overrideWith(
    FutureOr<Envelope> Function(EnvelopeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EnvelopeProvider._internal(
        (ref) => create(ref as EnvelopeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        envelopeId: envelopeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Envelope> createElement() {
    return _EnvelopeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnvelopeProvider && other.envelopeId == envelopeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, envelopeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EnvelopeRef on AutoDisposeFutureProviderRef<Envelope> {
  /// The parameter `envelopeId` of this provider.
  int get envelopeId;
}

class _EnvelopeProviderElement
    extends AutoDisposeFutureProviderElement<Envelope> with EnvelopeRef {
  _EnvelopeProviderElement(super.provider);

  @override
  int get envelopeId => (origin as EnvelopeProvider).envelopeId;
}

String _$envelopeCreatedHash() => r'3344d63b3174ccb8b04bdb4aec69ed85c9fa2657';

/// See also [EnvelopeCreated].
@ProviderFor(EnvelopeCreated)
final envelopeCreatedProvider =
    AutoDisposeNotifierProvider<EnvelopeCreated, Envelope?>.internal(
  EnvelopeCreated.new,
  name: r'envelopeCreatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$envelopeCreatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EnvelopeCreated = AutoDisposeNotifier<Envelope?>;
String _$colorNotifierHash() => r'674a7a81ff505bdd8fd82a4f77edf1d3ea162c0d';

/// See also [ColorNotifier].
@ProviderFor(ColorNotifier)
final colorNotifierProvider =
    AutoDisposeNotifierProvider<ColorNotifier, ColorTheme>.internal(
  ColorNotifier.new,
  name: r'colorNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$colorNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ColorNotifier = AutoDisposeNotifier<ColorTheme>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
