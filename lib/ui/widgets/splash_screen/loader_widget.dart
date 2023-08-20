import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/splash_screen/loader_view_cubit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
      listener: _onLoaderViewCubitStateChange,
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _onLoaderViewCubitStateChange(
      BuildContext context, LoaderViewCubitState state) {
    final nextScreen = state == LoaderViewCubitState.authorized
        ? MainNavigationRoutesNames.homeMovieDb
        : MainNavigationRoutesNames.authMovieDb;
    Navigator.pushReplacementNamed(context, nextScreen);
  }
}
