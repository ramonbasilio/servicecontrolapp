import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:servicecontrolapp/model/model_os.dart';

class Http {
  Future<void> callCloudFunc(
    BuildContext context,
    Uint8List pdf,
    OrdemServicoModel ordemServicoModel,
  ) async {
    String url =
        "https://us-central1-servicecontrolapp.cloudfunctions.net/sendEmailNewServiceOrder";

    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "email": ordemServicoModel.emailCliente,
          "pdf": base64Encode(pdf),
          'numOS': ordemServicoModel.idOrdemServico,
          'data': ordemServicoModel.dataAtendimento,
          'local': ordemServicoModel.cliente.razaoSocial,
          'namePdf': ordemServicoModel.idOrdemServico,
        }),
        headers: {
          'Content-type': 'application/json',
        });

    if (response.statusCode == 200) {
      const snackBar = SnackBar(
        content: Text('Email enviado com sucesso!'),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Falha ao enviar email!'),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
