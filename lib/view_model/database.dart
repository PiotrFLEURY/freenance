import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/logic/freenance_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@riverpod
FreenanceDb database(Ref ref) {
  return FreenanceDb()..init();
}
