// integration_test/app_test.dart
import 'package:integration_test/integration_test.dart';

import '../test/step_definitions.pickled.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  runFeatures();
}
