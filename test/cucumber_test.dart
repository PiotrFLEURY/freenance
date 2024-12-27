import 'package:freenance/model/logic/freenance_db.dart';
import 'package:mockito/annotations.dart';

import 'step_definitions.pickled.dart';

@GenerateMocks([FreenanceDb])
void main() => runFeatures();
