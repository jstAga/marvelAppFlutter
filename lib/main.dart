import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/app/app.dart';
import 'package:marvel_app_flutter/app/app_view_model.dart';
import 'package:marvel_app_flutter/ui/core/bases/base_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final viewModel = AppViewModel();
  await viewModel.checkAuth();
  const app = App();
  final widget = InheritedProvider(model: viewModel, child: app);
  runApp(widget);
}
