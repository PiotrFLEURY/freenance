import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view_model/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'envelope.g.dart';

@riverpod
Future<Envelope> envelope(Ref ref, int envelopeId) async {
  final budgetRepository = ref.watch(budgetRepositoryProvider);
  final envelope = await budgetRepository.fetchEnvelope(envelopeId);
  return envelope;
}
