import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:servicecontrolapp/model/model_os.dart';

class Http {
  Future<void> callCloudFunc(
      String pdf, OrdemServicoModel ordemServicoModel) async {
    String url =
        "https://us-central1-servicecontrolapp.cloudfunctions.net/sendEmailNewServiceOrder";

    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": ordemServicoModel.emailCliente,
          "pdf": pdf,
          'numOS': ordemServicoModel.idOrdemServico,
          'data': ordemServicoModel.dataAtendimento,
          'local': ordemServicoModel.cliente.razaoSocial,
          'namePdf': ordemServicoModel.idOrdemServico,
        }),
        headers: {
          'Content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      print('enviado com sucesso');
    } else {
      print('falhou - Erro: ${response.statusCode} - ${response.body}');
    }
  }
}
