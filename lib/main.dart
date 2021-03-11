import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(testDeviceIds: ["A140E2ABE2B7251DC7F07890E8988679"]);
  runApp(ApplicationWrapper());
}
