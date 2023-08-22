import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marvel_app_flutter/ui/constants/bases/bases_ext.dart';
import 'package:marvel_app_flutter/ui/constants/constants.dart';
import 'package:marvel_app_flutter/ui/main_navigation/main_navigation.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/cubit/auth_view_cubit.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/cubit/auth_view_cubit_state.dart';
import 'package:provider/provider.dart';

class _AuthDataStorage {
  String login = "";
  String password = "";
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewCubit, AuthViewCubitState>(
      listenWhen: (_, current) => current is AuthViwCubitSuccessState,
      listener: (context, state) => _onAuthViewCubitStateChange(context, state),
      child: Provider(
        create: (_) => _AuthDataStorage(),
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: MovieDbConstants.theMovieDbBackground,
                title: const Text(
                  MovieDbConstants.theMovieDbAuthAppBar,
                )),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _LoginForm(),
                const SizedBox(height: 24),
                const _MainContainer(),
              ],
            )),
      ),
    );
  }

  void _onAuthViewCubitStateChange(
    BuildContext context,
    AuthViewCubitState state,
  ) {
    if (state is AuthViwCubitSuccessState) {
      MainNavigation.resetNavigation(context);
    }
  }
}

class _MainContainer extends StatelessWidget {
  const _MainContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 16, color: Colors.black);

    return Column(
      children: [
        const Text(MovieDbConstants.theMovieDbHeader1, style: textStyle),
        const SizedBox(height: 16),
        const Text(MovieDbConstants.theMovieDbHeader2, style: textStyle),
        const SizedBox(height: 2),
        Row(
          children: [
            TextButton(
                onPressed: () {},
                style: MovieDbConstants.baseTheMovieDbButton,
                child: const Text(MovieDbConstants.theMovieDbRegister)),
            const SizedBox(width: 24),
            TextButton(
                onPressed: () {},
                style: MovieDbConstants.baseTheMovieDbButton,
                child: const Text(MovieDbConstants.theMovieDbVerifyEmail))
          ],
        )
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  _LoginForm();

  final loginTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessage(),
        Text(MovieDbConstants.theMovieDbUsername,
            style: BaseTextStyle.baseSimilarText(Colors.black)),
        TextField(
            decoration: MovieDbConstants.authInputDecoration,
            onChanged: (text) => authDataStorage.login = text),
        const SizedBox(height: 16),
        Text(MovieDbConstants.theMovieDbPassword,
            style: BaseTextStyle.baseSimilarText(Colors.black)),
        TextField(
            decoration: MovieDbConstants.authInputDecoration,
            obscureText: true,
            onChanged: (text) => authDataStorage.password = text),
        const SizedBox(height: 24),
        Row(
          children: [
            _AuthButton(),
            const SizedBox(width: 24),
            TextButton(
                style: MovieDbConstants.baseTheMovieDbLinkButton,
                onPressed: () {},
                child: const Text(MovieDbConstants.theMovieDbResetPassword)),
          ],
        )
      ],
    );
  }
}

class _AuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthViewCubit>();
    final isCanStartAuth = cubit.state is AuthViwCubitFormInProgressState ||
        cubit.state is AuthViwCubitErrorState;

    final authDataStorage = context.read<_AuthDataStorage>();

    final onPressed = isCanStartAuth == true
        ? () => cubit.auth(
            login: authDataStorage.login, password: authDataStorage.password)
        : null;

    final Widget child = cubit.state is AuthViwCubitProgressState
        ? MovieDbConstants.loadingButton
        : const Text(MovieDbConstants.theMovieDbLogin);
    return ElevatedButton(
        style: MovieDbConstants.baseTheMovieDbButton,
        onPressed: onPressed,
        child: child);
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage();

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((AuthViewCubit c) {
      final state = c.state;
      return state is AuthViwCubitErrorState ? state.errorMessage : null;
    });
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child:
          Text(errorMessage, style: BaseTextStyle.baseSimilarText(Colors.red)),
    );
  }
}
