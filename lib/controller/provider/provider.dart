import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:servicecontrolapp/model/model_os.dart';

class ProviderPdf extends ChangeNotifier {
  String _email = '';
  String get emailClient => _email;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }
}
