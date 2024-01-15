import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:servicecontrolapp/model/model_os.dart';

class ProviderPdf extends ChangeNotifier {
  Uint8List? _ordemServicoModel;
  Uint8List get ordemServicoModel => _ordemServicoModel!;

  void minhaOrdemDeServico(Uint8List os) {
    try {
      _ordemServicoModel = os;
      notifyListeners();
    } catch (e) {
      print('erro ao salvar pdf com provider');
    }
  }
}
