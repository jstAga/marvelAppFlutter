import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/app/app.dart';
import 'package:marvel_app_flutter/di/get_it.dart';

void main() {
  setupDependencies();
  const app = App();
  runApp(app);
}
