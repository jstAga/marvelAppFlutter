import 'package:flutter/material.dart';
import 'package:marvel_app_flutter/ui/widgets/splash_screen/splash_screen_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
