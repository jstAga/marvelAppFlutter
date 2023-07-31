import 'package:flutter/material.dart';

import 'package:marvel_app_flutter/ui/constants/bases/bases_ext.dart';
import 'package:marvel_app_flutter/ui/constants/constants.dart';
import 'package:marvel_app_flutter/ui/widgets/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MovieDbConstants.theMovieDbBackground,
            title: const Text(
              MovieDbConstants.theMovieDbAuthAppBar,
            )),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            _LoginForm(),
            SizedBox(height: 24),
            _MainContainer(),
          ],
        ));
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
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AuthViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessage(),
        Text(MovieDbConstants.theMovieDbUsername,
            style: BaseTextStyle.baseSimilarText(Colors.black)),
        TextField(
            decoration: MovieDbConstants.authInputDecoration,
            controller: viewModel.usernameTextController),
        const SizedBox(height: 16),
        Text(MovieDbConstants.theMovieDbPassword,
            style: BaseTextStyle.baseSimilarText(Colors.black)),
        TextField(
            decoration: MovieDbConstants.authInputDecoration,
            obscureText: true,
            controller: viewModel.passwordTextController),
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
    final model = context.watch<AuthViewModel>();
    final onPressed =
        model.canStartAuth == true ? () => model.auth(context) : null;
    final Widget child;
    child = model.isAuthInProgress == true
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
    final errorMessage = context.select((AuthViewModel vm) => vm.errorMessage);
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child:
          Text(errorMessage, style: BaseTextStyle.baseSimilarText(Colors.red)),
    );
  }
}
