import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  Future<void>? Function()? onSessionExpired;
}