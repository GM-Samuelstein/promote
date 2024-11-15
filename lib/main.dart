import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promote/common/repository/employee_repository.dart';
import 'package:promote/root_widget.dart';

Future<void> main() async {
  final repo = EmployeeRepository();

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await repo.initApp();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(
      const ProviderScope(
        child: MobileAssessmentApp(),
      ),
    );
  }, (exception, stackTrace) async {});
}
