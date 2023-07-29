import 'package:flutter/material.dart';

class MovieDbConstants {
  //The Movie DB
  static const String theMovieDbAuthAppBar = "Login to your account";
  static const Color theMovieDbBackground = Color.fromRGBO(3, 37, 65, 1);
  static const Color theMovieDbBlue = Color(0xFF01B4E4);

  static const String theMovieDbHeader1 =
      "In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.";
  static const String theMovieDbHeader2 =
      "If you signed up but didn't get your verification email.";
  static const String theMovieDbUsername = "Username";
  static const String theMovieDbPassword = "Password";
  static const String theMovieDbLogin = "Login";
  static const String theMovieDbResetPassword = "Reset password";
  static const String theMovieDbRegister = "Register";
  static const String theMovieDbVerifyEmail = "Verify email";
  static const String theMovieDb = "";

  static final ButtonStyle baseTheMovieDbButton = ButtonStyle(
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
      textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      backgroundColor:
          MaterialStateProperty.all(MovieDbConstants.theMovieDbBlue),
      foregroundColor: MaterialStateProperty.all(Colors.white));

  static final ButtonStyle baseTheMovieDbLinkButton = ButtonStyle(
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
      textStyle: MaterialStateProperty.all(const TextStyle(
        fontSize: 16,
      )),
      foregroundColor:
          MaterialStateProperty.all(MovieDbConstants.theMovieDbBlue));

  static const String theMovieDbHomeTitle = "TMDB";

  static const InputDecoration authInputDecoration = InputDecoration(
      border: OutlineInputBorder(),
      isCollapsed: true,
      contentPadding: EdgeInsets.all(8));

  static const loadingButton = SizedBox(
      width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2));

  static final movieCardDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.black.withOpacity(0.2),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2))
      ]);
}