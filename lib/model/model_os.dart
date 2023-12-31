// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:servicecontrolapp/model/model_client.dart';

class OrdemServicoModel {
  final ClienteModel? cliente;
  final String equipamento;
  final String modelo;
  final String marca;
  final String ns;
  final String descricao;
  final Uint8List? assinatura;

  OrdemServicoModel({
    required this.cliente,
    required this.equipamento,
    required this.modelo,
    required this.marca,
    required this.ns,
    required this.descricao,
    required this.assinatura,
  });
}
