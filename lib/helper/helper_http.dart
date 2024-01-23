import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Http extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  Future<void> funcaoTeste() async {
    _loading = true;
    print('estado variavel boolana: $_loading');
    notifyListeners();
    await Future.delayed(Duration(seconds: 5));
    print('terminou');
    _loading = false;
    print('estado variavel boolana: $_loading');
    notifyListeners();
  }

  Future<void> callCloudFunc(String pdf, String email) async {
    String url =
        "https://us-central1-servicecontrolapp.cloudfunctions.net/helloword";

    http.Response response = await http.post(Uri.parse(url), body: {
      "email": email,
      "pdf": pdf,
    });
    notifyListeners();
    if (response.statusCode == 200) {
      print('enviado com sucesso');
    } else {
      print('falhou');
    }
  }
}
