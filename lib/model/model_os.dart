// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';
import 'package:servicecontrolapp/model/model_client.dart';

class OrdemServicoModel {
  final ClienteModel cliente;
  final String nomeCliente;
  final String emailCliente;
  final String equipamento;
  final String marca;
  final String modelo;
  final String ns;
  final String tipoAtendimento;
  final String resumoAtendimento;
  final String dataAtendimento;
  final String horaInicioAtendimento;
  final String horaFinalAtendimento;
  final Uint8List assinatura;

  OrdemServicoModel({
    required this.nomeCliente,
    required this.emailCliente,
    required this.tipoAtendimento,
    required this.dataAtendimento,
    required this.horaInicioAtendimento,
    required this.horaFinalAtendimento,
    required this.cliente,
    required this.equipamento,
    required this.modelo,
    required this.marca,
    required this.ns,
    required this.resumoAtendimento,
    required this.assinatura,
  });
}
